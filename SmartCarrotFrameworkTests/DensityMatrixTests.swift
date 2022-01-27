//
//  DensityMatrixTests.swift
//  SmartCarrotFrameworkTests
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import XCTest
@testable import SmartCarrotFramework

class DensityMatrixTests: XCTestCase {
    let _eps:Float32 = 0.0000001
    let estimator = DensityMatrixBuilder(densityMatrix: DensityMatrixType())
    
    func testLeftBoundaryIndex() {
        let xVal:[Float32] = [-5, 0, 3, 10]
        
        XCTAssertEqual(estimator.getLeftBoundaryIndex(x: -10, xFuncCoordinates: xVal), 0)
        XCTAssertEqual(estimator.getLeftBoundaryIndex(x: -3, xFuncCoordinates: xVal), 0)
        XCTAssertEqual(estimator.getLeftBoundaryIndex(x: 0, xFuncCoordinates: xVal), 0)
        XCTAssertEqual(estimator.getLeftBoundaryIndex(x: 1, xFuncCoordinates: xVal), 1)
        XCTAssertEqual(estimator.getLeftBoundaryIndex(x: 11, xFuncCoordinates: xVal), 2)
    }
    
    func testRightBoundaryIndex() {
        let xVal:[Float32] = [-5, 0, 3, 10]
        
        XCTAssertEqual(estimator.getRightBoundaryIndex(x: -10, xFuncCoordinates: xVal), 1)
        XCTAssertEqual(estimator.getRightBoundaryIndex(x: -3, xFuncCoordinates: xVal), 1)
        XCTAssertEqual(estimator.getRightBoundaryIndex(x: 0, xFuncCoordinates: xVal), 1)
        XCTAssertEqual(estimator.getRightBoundaryIndex(x: 1, xFuncCoordinates: xVal), 2)
        XCTAssertEqual(estimator.getRightBoundaryIndex(x: 11, xFuncCoordinates: xVal), 3)
    }
    
    func testGetInterpolation() {
        let xVal:[Float32] = [-5,0,3,10]
        let yVal:[Float32] = [10,-10,15,-15]
        let xCoordinates:[Float32] = [-10, -3, 0, 1.5, 5, 500]
        
        let results = estimator.getInterpolation(xCoordindates: xCoordinates, xFuncCoordinates: xVal, yFuncCoordindates: yVal)
        
        XCTAssertLessThan(results[0] - 30, _eps)
        XCTAssertLessThan(results[1] - 2, _eps)
        XCTAssertLessThan(results[2] + 10, _eps)
        XCTAssertLessThan(results[3] - 2.5, _eps)
        XCTAssertLessThan(results[4] - 6.4285717, _eps)
        XCTAssertLessThan(results[5] + 2115, _eps)
    }
    
    func testPrebuiltXCoordindates() {
        let estimator = DensityMatrixBuilder(densityMatrix: DensityMatrixType())
        
        let xBasisCoordinates = estimator.buildXBasisCoordinates()
        
        XCTAssert(xBasisCoordinates.count == 251 * 2 + 1, "x basis coordinates array length is wrong")
        XCTAssert(xBasisCoordinates[4] + 801678.563 < self._eps, "x basis coordinates element 5 is wrong")
        XCTAssert(xBasisCoordinates[399] - 3372.87402 < self._eps, "x basis coordinates element 5 is wrong")
    }

    func testCleanDensityMatrix() {
        let dm = DensityMatrixBuilder(densityMatrix: DensityMatrixType())
        
        XCTAssertLessThan(abs(dm.DensityMatrix.joined().reduce(Float32(0), +) - 8144.8635), _eps )
    }

    func testDensityMatrix() {
        let dm = DensityMatrixBuilder(densityMatrix: DensityMatrixType())
        
        dm.learn(amount: -200, category:  TransactionCategory("groceries"))
        dm.learn(amount: -250, category:  TransactionCategory("groceries"))
        dm.learn(amount: -120, category:  TransactionCategory("groceries"))
        dm.learn(amount: -60000, category: TransactionCategory("car_buy"))
        dm.learn(amount: -80000, category: TransactionCategory("car_buy"))
        
        XCTAssertLessThan(abs(dm.DensityMatrix.joined().reduce(Float32(0), +) - 8186.970883333), _eps )
    }
    
    func testLiklihood() {
        let dm = DensityMatrixBuilder(densityMatrix: DensityMatrixType())
        
        dm.learn(amount: -200, category:  TransactionCategory("groceries"))
        dm.learn(amount: -250, category:  TransactionCategory("groceries"))
        dm.learn(amount: -120, category:  TransactionCategory("groceries"))
        dm.learn(amount: -60000, category: TransactionCategory("car_buy"))
        dm.learn(amount: -80000, category: TransactionCategory("car_buy"))
    
        XCTAssertEqual(dm.getLikelihood(amount: 100).count, 108)
        XCTAssertLessThan(abs( dm.getLikelihood(amount: -100000)[75] - 0.810547), _eps)
        XCTAssertLessThan(abs( dm.getLikelihood(amount: -90000 )[75] - 1.000000000 ), _eps)
        XCTAssertLessThan(abs( dm.getLikelihood(amount: -210 )[75] - 0.13854942), _eps )
        
        XCTAssertLessThan(abs( dm.getLikelihood(amount: -500000).reduce(Float32(0), +) - 16.130833), _eps)
        XCTAssertLessThan(abs( dm.getLikelihood(amount: -90000).reduce(Float32(0), +) - 17.009333), _eps)
    }
    
    func testLikliHoodOfChildren() {
        let dm = DensityMatrixBuilder(densityMatrix: DensityMatrixType())
        
        dm.learn(amount: -1600, category: TransactionCategory("children"))
        dm.learn(amount: -1600, category: TransactionCategory("children"))
        XCTAssertEqual(dm.getLikelihood(amount: -1600)[20], 1)

    }
}
