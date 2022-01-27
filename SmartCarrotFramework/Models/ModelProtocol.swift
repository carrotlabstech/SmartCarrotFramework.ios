//
//  ModelProtocol.swift
//  OutlabFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

/**
 Defines the model type used for categorisation.
 */
public enum CategorisationType {
    /// The Optimised Native model will be used for categorisation. Personalised user's learning won't be taken into consideration.
    case nonPersonal
    /// The Personalised Model will be used for categorisation.
    case personal
}

internal typealias CategorizationOutputTensor = [Float32]

internal protocol ModelProtocol {
    func categorise(transactionDescription: String, transactionAmount: Double, personal: CategorisationType) -> Int
    func getOutputTensor(transactionDescription: String, transactionAmount: Double) -> CategorizationOutputTensor
    func learn(transactionDescription: String, transactionAmount: Double, personalCategoryId: Int) throws
    func load()
}
