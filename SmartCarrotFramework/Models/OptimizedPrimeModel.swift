//
//  ModelProtocol.swift
//  OutlabFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation
//import TensorFlowLite

// Very important: we don't expose the model class to the outer world
internal class OptimizedPrimeModel : ModelProtocol {
     /// The current thread count used by the TensorFlow Lite Interpreter.
    private let _threadCount: Int
    private let _weightTensor: [Int]?
    
    /// TensorFlow Lite `Interpreter` object for performing inference on a given model.
    private var interpreter: Interpreter
    
    init?(threadCount: Int = 1, weightTensor: [Int]? = nil) {
        // Construct the path to the model file.
        guard let modelPath = Bundle(identifier: ModelContext.BUNDLE_IDENTIFIER)!.path(forResource: "b".u.m.b.l.e, ofType: "b".e)
            else {
                print("Failed to load the model.")
                return nil
        }
        
        // Specify the options for the `Interpreter`.
        self._threadCount = threadCount
        self._weightTensor = weightTensor
        
        var options = Interpreter.Options()
        options.threadCount = self._threadCount
        if _weightTensor != nil {
            options.initWeightTensor(weightTensor: self._weightTensor!)
        }
        
        do {
            // Create the `Interpreter`.
            interpreter = try Interpreter(modelPath: modelPath, options: options)
            
            // Allocate memory for the model's input `Tensor`s.
            try interpreter.allocateTensors()
        } catch let error {
            print("Failed to create the interpreter with error: \(error.localizedDescription)")
            return nil
        }
    }
    
    internal func learn(transactionDescription: String, transactionAmount: Double, personalCategoryId: Int) {
        // not implemented / not required
    }
    
    internal func load() {
        // not implemented / not required
    }
    
    internal func getOutputTensor(transactionDescription: String, transactionAmount: Double) -> CategorizationOutputTensor {
        var result:[Float32] = CategorizationOutputTensor()
        let description = StringSanitizer.cleanseString(arg: transactionDescription)
        
        //let tensor = InputTensorBuilder().build(description: description)
        let tensor = ComplexEnglishInputTensorBuilder().build(description: description)
        let outputTensor: Tensor
        
        do {
            _ = try interpreter.input(at: 0)
            let data = Data(copyingBufferOf: tensor)
            
            try interpreter.copy(data, toInputAt: 0)
            
            try interpreter.invoke()
            
            // Get the output `Tensor` to process the inference results.
            outputTensor = try interpreter.output(at: 0)
            
            result = [Float32](unsafeData: outputTensor.data) ?? []
        } catch let error {
            print("Failed to invoke the interpreter with error: \(error.localizedDescription)")
        }
        
        return result
    }
    
    internal func categorise(transactionDescription: String, transactionAmount: Double, personal: CategorisationType) -> Int {
        var result:Int = TransactionCategory.UNCATEGORISED_INT_ID
        
        let outputTensor = getOutputTensor(transactionDescription: transactionDescription, transactionAmount: transactionAmount)
        
        let winnerIndex = outputTensor.indexOfMax!
        let winnerCertainty = outputTensor[winnerIndex]
        
        if winnerCertainty > ModelContext.CERTAINTY_THRESHOLD {
            // category id starts with 1, not 0
            result = winnerIndex + 1
        } else {
            result = TransactionCategory.UNCATEGORISED_INT_ID
        }
        
        return result
    }
}


