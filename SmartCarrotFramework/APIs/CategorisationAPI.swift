//
//  EdgeAPI.swift
//  SmartCarrotFramework
//
//  Copyright © 2020 CarrotLabs gmbh. All rights reserved.
//

import Foundation

/**
 Allows you to categorise and learn a user’s personalisation setting.
 
 The object of the `CategorisationAPI` class cannot be explicitly instantiated, please call `CarrotContext.getCategorisationAPI()` for that.
 */
public final class CategorisationAPI : ModuleAPI {
    private var _model : ModelProtocol?
    private var _persistence = PersistanceType.persistent
    private var _isAuthenticated: Bool = false
    
    internal init(model: ModelProtocol?, isAuthenticated: Bool, persistence: PersistanceType, credentials: CarrotCredentials?) throws {
        super.init(modules: [LicenseDecoder.MODULE_CATEGORISE], credentials: credentials)
        
        self._model = model
        self._persistence = persistence
        self._isAuthenticated = isAuthenticated
        
        try validateSettings()
    }
    
    /**
     Categorises a transaction
     
     - Parameter description: transaction description
     - Parameter amount: transaction amount
     - Parameter isPersonal: if personalisation should be applied. Set it to `.personal` if you want to apply user personalisation settings, and to `nonPersonal` if you want to use generalised model. Default value is `.personal`.
     
     - Throws `CarrotContextError.notAuthorised` if CategorizationContext has not been authorized
     - Throws `CarrotContextError.failedToLoadModel` if the model doesn't load
     
     - Returns Transaction category Id
     */
    public func categorise(description: String, amount: Decimal, isPersonal: CategorisationType = .personal) throws -> Int {
        let model:ModelProtocol = try getVerifiedModel()
        return model.categorise(transactionDescription: description, transactionAmount: amount.doubleValue, personal: isPersonal)
    }
    
    /**
     Learns user's categorisation on a transaction
     
     - Parameter description: transaction description
     - Parameter amount: transaction amount
     - Parameter personalCategoryId: transaction category id, defined by the user
     
     - Throws `CarrotContextError.notAuthorised` if CategorizationContext has not been authorized
     - Throws `CarrotContextError.failedToLoadModel` if the model doesn't load
     - Throws `CarrotContextError.loadError` if it failed to load user personalised settings.
     - Throws `CarrotContextError.saveError` if it failed to save user personalised settings.
     */
    public func learn(description: String, amount: Decimal, personalCategoryId: Int) throws {
        let model = try getVerifiedModel()
        try model.learn(transactionDescription: description, transactionAmount: amount.doubleValue, personalCategoryId: personalCategoryId)
    }
    
    /**
     Deletes (resets) all user's learnings
     
     - Throws `CarrotContextError.saveError` if new data could not be saved
     - Throws `CarrotContextError.notAuthorised` if CategorizationContext has not been authorized
     - Throws `CarrotContextError.failedToLoadModel` if the model doesn't load
     - Throws `CarrotContextError.saveError` if it failed to save user personalised settings.
    */
    public func reset() throws {
        PersistentStorage.shared().reset()
        
        do {
            try PersistentStorage.shared().save(persistance: self._persistence)
        } catch {
            throw CarrotContextError.saveError
        }
        
        let model = try getVerifiedModel()
        model.load()
    }
    
    // Checks all the requirements to the model, functions of which could be executed
    private func getVerifiedModel() throws -> ModelProtocol {
        if !self._isAuthenticated {
            throw CarrotContextError.notAuthorised
        }
        
        guard let model = self._model else {
            throw CarrotContextError.failedToLoadModel
        }
        
        return model
    }
    
    internal override func validateSettings() throws {
        try super.validateSettings()
        
        if !self._isAuthenticated {
            throw CarrotContextError.notAuthorised
        }
        
        if _model == nil {
            throw CarrotContextError.failedToLoadModel
        }
    }
}
