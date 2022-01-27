//
//  PersonalModel.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

private typealias FuzzyWordType = (fuzzyWord: String, score: Float32, originalWord: String)

internal class PersonalModel : ModelProtocol {
    private let LEVENSHTEIN_DISTANCE = 2
    private let FORGETTING_LAMBDA:Float32 = 0.1
    private let MIXING_ALPHA:Float32 = 3
    private let BOOSTING_BETA:Float32 = 1.1
    
    private let _persistance: PersistanceType
    
    // todo: replace w private
    internal var _densityMatrixObj:DensityMatrixBuilder
    internal var _densityMatrix:DensityMatrixType
    internal var _wordsDictionary:[String]
    internal var _weightsMatrix:[[Float32]]
    internal var _dictionary:[[Float32]]
    
    init?(persistance: PersistanceType) {
        self._persistance = persistance
        
        // copy-past of the load method, swift compiler issue
        let loadObj = PersistentStorage.shared().load(persistance: _persistance)
        
        _densityMatrix = loadObj.densityMatrix
        _densityMatrixObj = DensityMatrixBuilder(densityMatrix: _densityMatrix)
        
        _wordsDictionary = loadObj.wordDictionary
        _weightsMatrix = loadObj.weightsMatix
        _dictionary = loadObj.dictionary
    }
    
    /// Learn transaction and category
    /// todo: check the type coercion with the R code
    internal func learn(transactionDescription: String, transactionAmount: Double, personalCategoryId: Int) throws {
        let description = StringSanitizer.cleanseString(arg: transactionDescription)
        let words = getWords(description: description)
        let categoryId = personalCategoryId - 1

        // recalculate category weights
        for word in words {
            let wRow = self._wordsDictionary.firstIndex(of: word)
            if wRow != nil {
                let row = wRow!
                _weightsMatrix[row] = (_weightsMatrix[row]).map({ $0 * (1 - FORGETTING_LAMBDA)})
                _weightsMatrix[row][categoryId] += 1
            } else {
                _wordsDictionary.append(word)
                
                var newWeightsRow = [Float32](repeating: 0, count: TransactionCategory.NUMBER_OF_CATEGORIES)
                newWeightsRow[categoryId] = 1
                _weightsMatrix.append(newWeightsRow)
            }
        }
        
        // category frequence per word
        var categoryFrequencyMatrix:[[Float32]] = [[Float32]]()
        for _ in 0..._weightsMatrix.count - 1 {
            let categoryFrequencyMatrixRow = [Float32](repeating: 0, count: TransactionCategory.NUMBER_OF_CATEGORIES)
            categoryFrequencyMatrix.append(categoryFrequencyMatrixRow)
        }
        
        for iRow in 0..._weightsMatrix.count - 1 {
            let sumPerWord = _weightsMatrix[iRow].reduce(0, +)
            
            if sumPerWord != 0 {
                for iCol in 0..._weightsMatrix[iRow].count - 1 {
                    categoryFrequencyMatrix[iRow][iCol] = _weightsMatrix[iRow][iCol] / sumPerWord
                }
            } else {
                print("Data Scientist messed up")
            }
        }

        // term frequency per category
        var termFrequencyMatrix:[[Float32]] = [[Float32]]()
        for _ in 0..._weightsMatrix.count - 1 {
            let termFrequencyMatrixRow = [Float32](repeating: 0, count: TransactionCategory.NUMBER_OF_CATEGORIES)
            termFrequencyMatrix.append(termFrequencyMatrixRow)
        }
        
        for iCol in 0...TransactionCategory.NUMBER_OF_CATEGORIES - 1 {
            var sumPerCategory:Float32 = 0
            for iRow in 0..._weightsMatrix.count - 1 {
                sumPerCategory += _weightsMatrix[iRow][iCol]
            }
            
            if sumPerCategory != 0 {
                for iRow in 0..._weightsMatrix.count - 1 {
                    termFrequencyMatrix[iRow][iCol] = _weightsMatrix[iRow][iCol] / sumPerCategory
                }
            }
        }
        
        _dictionary = [[Float32]]()
        for iRow in 0..._weightsMatrix.count - 1 {
            var dictionaryRow = [Float32]()
            
            for iCol in 0...TransactionCategory.NUMBER_OF_CATEGORIES - 1 {
                let element1 = termFrequencyMatrix[iRow][iCol]
                let element2 = categoryFrequencyMatrix[iRow][iCol]
                
                let element = ((element1 * pow(element2, MIXING_ALPHA)).squareRoot()) * self.BOOSTING_BETA
                
                dictionaryRow.append(element)
            }
            
            _dictionary.append(dictionaryRow)
        }
        
        _densityMatrixObj.learn(amount: transactionAmount, category: TransactionCategory.getCategory(intId: personalCategoryId))
        
        do {
            try save()
        } catch {
            throw error
        }
    }
    
    private func logC(val: Float32, forBase base: Float32) -> Float32 {
        return log(val)/log(base)
    }
    
    // needs to hide as they are not used directly
    internal func categorise(transactionDescription: String, transactionAmount: Double, personal: CategorisationType) -> Int {
        return TransactionCategory.UNCATEGORISED_INT_ID
    }
    
    internal func getOutputTensor(transactionDescription: String, transactionAmount: Double) -> CategorizationOutputTensor {
        var result:[Float32] = [Float32](repeating: 0, count: TransactionCategory.NUMBER_OF_CATEGORIES)
        
        let description = StringSanitizer.cleanseString(arg: transactionDescription)
        let words = getWords(description: description)
        
        let fuzzyWords = getFuzzyWords(words: words)
        
        for categoryId in 0...TransactionCategory.NUMBER_OF_CATEGORIES - 1 {
            for fuzzyWord in fuzzyWords {
                let fuzzyWordIndex = _wordsDictionary.firstIndex(of: fuzzyWord.fuzzyWord)
                
                result[categoryId] += (_dictionary[fuzzyWordIndex!][categoryId] * fuzzyWord.score)
            }
            
            result[categoryId] = result[categoryId].squareRoot()
        }
        
        let likelihood = _densityMatrixObj.getLikelihood(amount: Float32(transactionAmount))
        for i in 0...result.count - 1 {
            result[i] = result[i] * likelihood[i]
        }
        
        return result
    }
    
    private func save() throws {
        PersistentStorage.shared()._densityMatrix = self._densityMatrixObj.DensityMatrix
        PersistentStorage.shared()._wordsDictionary = self._wordsDictionary
        PersistentStorage.shared()._weightsMatrix = self._weightsMatrix
        PersistentStorage.shared()._dictionary = self._dictionary
        
        do {
            try PersistentStorage.shared().save(persistance: _persistance)
        } catch {
            throw CarrotContextError.saveError
        }
    }
    
    internal func load() {
        let loadObj = PersistentStorage.shared().load(persistance: _persistance)
        
        _densityMatrix = loadObj.densityMatrix
        _densityMatrixObj = DensityMatrixBuilder(densityMatrix: _densityMatrix)
        
        _wordsDictionary = loadObj.wordDictionary
        _weightsMatrix = loadObj.weightsMatix
        _dictionary = loadObj.dictionary
    }
    
    private func getWords(description: String) -> [String] {
        var words = description.components(separatedBy: " ")
        
        // filter out the same words
        words = words.sorted()
        
        var i = 1
        while words.count > 1 && i < words.count {
            if words[i - 1] == words[i] {
                words.remove(at: i)
            } else {
                i += 1
            }
        }
        
        return words
    }
    
    private func getFuzzyWords(words: [String]) -> [FuzzyWordType] {
        // per each word we take the closest match (all of them), <= 2 distance
        
        var fuzzyWords : [FuzzyWordType] = []
        for word in words {
            var currentFuzzyWords : [FuzzyWordType] = []

            for indexWord in self._wordsDictionary {
                // no need to calculate and compare the levenshtein distance between words is larger
                if abs(indexWord.count - word.count) <= LEVENSHTEIN_DISTANCE {
                    let distance = word.levenshtein(indexWord)

                    if distance <= LEVENSHTEIN_DISTANCE {
                        let score = getScore(word: word, indexWord: indexWord, distance: distance)

                        if score > 0 {
                            currentFuzzyWords.append((indexWord, score, word))
                        }
                    }
                }
            }

            // filter out the noise via the score value
            // if the score is lower then probably that wasn't the the word we are looking for, let's take it away
            if currentFuzzyWords.count > 0 {
                let maxScore = currentFuzzyWords.max { (left, right) -> Bool in
                    return left.score < right.score
                }

                currentFuzzyWords = currentFuzzyWords.filter { $0.score >= maxScore!.score }
                fuzzyWords.append(contentsOf: currentFuzzyWords)
            }
        }
        
        return fuzzyWords
    }
    
    // score: [0:1], 0 - no match, 1 - exact match
    private func getScore(word: String, indexWord: String, distance: Int) -> Float {
        let length = max(word.count, indexWord.count)
        
        return pow((1-Float(distance)/Float(length)), 2) * 10
    }
}
