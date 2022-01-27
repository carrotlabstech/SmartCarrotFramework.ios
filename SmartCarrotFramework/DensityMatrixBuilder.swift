//
//  DensityEstimator.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal typealias DensityMatrixType = [[Float32]]

internal class DensityMatrixBuilder {
    private let X_BASIS_COORDINATES_NUMBER_ONESIGN = 251
    private let X_BASIS_COORDINATES_NUMBER = 251 * 2 + 1
    private var _xBasisCoordinates = [Float32]()
    private var _densityMatrix = [[Float32]]()
    private var _forgettingLambda = 0.1
    
    internal var DensityMatrix:DensityMatrixType {
        get {
            return _densityMatrix
        }
    }
    
    init(densityMatrix:DensityMatrixType) {
        self._densityMatrix = densityMatrix
        
        if _densityMatrix.count == 0 {
            self._densityMatrix = buildAndFillNewDensityMatrix()
        }
        
        self._xBasisCoordinates = buildXBasisCoordinates()
    }
    
    internal func buildXBasisCoordinates() -> [Float32] {
        var positiveCoordinates:[Float32] = [Float32](repeating: 0, count: X_BASIS_COORDINATES_NUMBER_ONESIGN)
        
        for index in 0...X_BASIS_COORDINATES_NUMBER_ONESIGN - 1 {
            positiveCoordinates[index] = pow(10, (Float32(index) * (Float32(6) / Float32(X_BASIS_COORDINATES_NUMBER_ONESIGN - 1))))
        }
        
        var result = positiveCoordinates.map({ -$0 })
        result.sort()
        result.append(0)
        result.append(contentsOf: positiveCoordinates)
        
        return result
    }
    
    /// Finds the right upper boundary for a value. If the value exceeds all the elements in the array then
    /// the last index of the array is taken
    internal func getRightBoundaryIndex(x:Float32, xFuncCoordinates:[Float32]) -> Int {
        for i in 1...xFuncCoordinates.count - 1 - 1 {
            if x > xFuncCoordinates[xFuncCoordinates.count - 1 - i] {
                return xFuncCoordinates.count - i
            }
        }
        
        return 1
    }
    
    /// Finds the left low boundary for a value. If the value is lesser than all the elements in the array then
    /// the first index of the array is taken
    internal func getLeftBoundaryIndex(x:Float32, xFuncCoordinates:[Float32]) -> Int {
        for i in 0...xFuncCoordinates.count - 1 - 1 {
            
            // greater than OR equal is important so that we have different left and right indexes for a value
            // which equals one of the elements of the array
            if x <= xFuncCoordinates[i + 1] {
                return i
            }
        }
        
        return xFuncCoordinates.count - 2
    }
    
    internal func getInterpolation(xCoordindates:[Float32], xFuncCoordinates:[Float32], yFuncCoordindates:[Float32]) -> [Float32] {
        var result:[Float32] = [Float32]()
        
        for x in xCoordindates {
            let leftIndex = getLeftBoundaryIndex(x: x, xFuncCoordinates: xFuncCoordinates)
            let rightIndex = getRightBoundaryIndex(x: x, xFuncCoordinates: xFuncCoordinates)
            
            var slope = (yFuncCoordindates[rightIndex] - yFuncCoordindates[leftIndex]) / (xFuncCoordinates[rightIndex] - xFuncCoordinates[leftIndex])
            slope = slope * (x - xFuncCoordinates[leftIndex]) + yFuncCoordindates[leftIndex]
            
            result.append(slope)
        }

        return result
    }
    
    internal func getLikelihood(amount:Float32) -> [Float32] {
        var result = [Float32]()
        
        for i in 0...TransactionCategory.NUMBER_OF_CATEGORIES - 1 {
            result.append(contentsOf: getInterpolation(xCoordindates: [amount], xFuncCoordinates: _xBasisCoordinates, yFuncCoordindates: _densityMatrix[i]))
        }
        
        return result.map({ $0 > 1 ? 1 : $0 })
    }
    
    // Updates internal density matrix. Does not save it in the persistent storage
    internal func learn(amount:Double, category:TransactionCategory) {
        let sigma = abs(amount) / 5
        
        var additions:[Float32] = [Float32]()
        for x in _xBasisCoordinates {
            additions.append(normalDistribution(μ: Float32(amount), σ: Float32(sigma), x: x))
        }
        
        let binWidth:Float32 = 0.06
        var binMids:[Float32] = [Float32]()
        for i in 0..._xBasisCoordinates.count - 2 {
            binMids.append((_xBasisCoordinates[i] + _xBasisCoordinates[i + 1])/2)
        }
        
        let areaAdditions = getInterpolation(xCoordindates: binMids, xFuncCoordinates: _xBasisCoordinates, yFuncCoordindates: additions).reduce(Float32(0), +) * binWidth
        additions = additions.map({$0 / areaAdditions})
        
        let categoryIndex = category.getIntId() - 1
        _densityMatrix[categoryIndex] = _densityMatrix[categoryIndex].map({ $0 * Float32(1 - _forgettingLambda) })
        for i in 0...additions.count - 1 {
            _densityMatrix[categoryIndex][i] += additions[i]
        }
    }
    
    private func buildAndFillNewDensityMatrix() -> [[Float32]] {
        var result = [[Float32]]()
        
        let noCols = X_BASIS_COORDINATES_NUMBER
        let noRows = TransactionCategory.NUMBER_OF_CATEGORIES
        for _ in 0...noRows - 1 {
            result.append([Float32](repeating: 0.15, count: noCols))
        }
        
        return result
    }
    
    // Normal distribution
    // taken from here https://github.com/mbcltd/swift-normal-distribution/blob/master/swift-normal-distribution/NormalDistribution.swift
    private func normalDistribution(μ:Float32, σ:Float32, x:Float32) -> Float32 {
        let a = exp( -1 * pow(x-μ, 2) / ( 2 * pow(σ,2) ) )
        let b = σ * sqrt( 2 * Float32.pi )
        return a / b
    }
}
