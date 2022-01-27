//
//  MasterModel.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class MasterModel : ModelProtocol {
    private var _optimizedPrimeModel: OptimizedPrimeModel?
    private var _personalModel: PersonalModel?
    
    init?(persistance: PersistanceType, weightTensor: [Int]? = nil) {
        _optimizedPrimeModel = OptimizedPrimeModel(weightTensor: weightTensor)
        _personalModel = PersonalModel(persistance: persistance)
        
        if (_optimizedPrimeModel == nil || _personalModel == nil) {
            return nil
        }
    }
    
    internal func categorise(transactionDescription: String, transactionAmount: Double, personal: CategorisationType) -> Int {
        if StringSanitizer.cleanseString(arg: transactionDescription) == ""	 {
            return TransactionCategory.UNCATEGORISED_INT_ID
        }
        
        var outputTensor = CategorizationOutputTensor()
        
        if personal == .personal {
            outputTensor = getOutputTensor(transactionDescription: transactionDescription, transactionAmount: transactionAmount)
        } else {
            outputTensor = _optimizedPrimeModel!.getOutputTensor(transactionDescription: transactionDescription, transactionAmount: transactionAmount)
        }
        
        // Filter expenses/income out depending on the amount sign
        for category in 0...outputTensor.count - 1 {
            if transactionAmount > 0 && !INCOME_CATEGORY_INT_IDS.contains(category) {
                outputTensor[category] = 0
            }
            
            if transactionAmount < 0 && INCOME_CATEGORY_INT_IDS.contains(category) {
                outputTensor[category] = 0
            }
        }
        
        let winnerIndex = outputTensor.indexOfMax!
        let winnerCertainty = outputTensor[winnerIndex]
        
        var result = TransactionCategory.UNCATEGORISED_INT_ID
        
        if winnerCertainty > ModelContext.CERTAINTY_THRESHOLD {
            // category id starts with 1, not 0
            result = winnerIndex + 1
        } else {
            result = TransactionCategory.UNCATEGORISED_INT_ID
        }
        
        return result
    }

    internal func getOutputTensor(transactionDescription: String, transactionAmount: Double) -> CategorizationOutputTensor {
        let opModelTensor = _optimizedPrimeModel?.getOutputTensor(transactionDescription: transactionDescription, transactionAmount: transactionAmount)
        let personalModelTensor = _personalModel?.getOutputTensor(transactionDescription: transactionDescription, transactionAmount: transactionAmount)
        
        // this just sums elements of two arrays
        return zip(opModelTensor!, personalModelTensor!).map(+)
    }
    
    internal func learn(transactionDescription: String, transactionAmount: Double, personalCategoryId: Int) throws {
        do {
            try _personalModel!.learn(transactionDescription: transactionDescription, transactionAmount: transactionAmount, personalCategoryId: personalCategoryId)
        } catch {
            throw error
        }
    }
    
    internal func load() {
        _optimizedPrimeModel!.load()
        _personalModel!.load()
    }
}
