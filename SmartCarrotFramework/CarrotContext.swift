//
//  CategorisationApplicationContext.swift
//  OutlabFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

//public typealias AuthResultHandler = (Bool, CategorisationContextError?) -> ()


/// Possible error codes in the `CarrotContext`.
public enum CarrotContextError: Error {
    /// Invalid License.
    case invalidLicense
    
    /// License has expired.
    case licenseHasExpired
    
    /// License has been issued for a different application bundle id.
    case wrongBundleId
    
    /// Failed to obtain application bundle id.
    case couldNotLoadBundleId
    
    /**
     Failed to load the AI model file.
    
     Try to download the SDK one more time, most probably it is corrupted.
    */
    case failedToLoadModel
    
    /**
     Customer is not authorised to use the API.
    
     Please check the license, it's either invalid, or issued for the different application bundle id, or not issued for this particular API. */
    case notAuthorised
    
    /**
     Writing the personalised model to persistent storage failed.

     Most probaly the device has run out of space.
    */
    case saveError
    
    /**
     Loading the personalised model from persistent storage failed.
     
     The personalised model can be corrupt, you may try to reset it.
     */
    case loadError
    
    /// The feature is not implemented.
    case notImplementedError
    
    /**
     Encryption key is not set. It is required to store transactions and related entities in the persistent storage.
 
     Please set the key in `CarrotContext` and try again.
    */
    case encryptionKeyNotSetError
    
    /**
        Encryption Initialisation Vector is not set or invalid. It is required to store transactions and related entities in the persistent storage.
        Initialisation vector must be of 16 character length.
    
        Please set the vector in `CarrotContext` and try again.
       */
    case encryptionInvalidInitialisationVectorError
    
    /**
     Entity being saved into the persistent storage has an empty id. Entity ids should be managed by the customer application.
     
     Please set the entity id and try again.
     */
    case emptyEntityId
    /**
     No budgets were set for Zen Score calculations. Please set at least one and repeat.
     */
    case zenScoreNoBudgets
    
    /**
     The error is unknown to the `CarrotContext`.
     */
    case undefined
}

/**
 Carrot Context class. Them main entry point into the Framework.
 */
public final class CarrotContext {
    private var _model : ModelProtocol?
    private var _persistence = PersistanceType.persistent
    private var _isAuthenticated: Bool = false
    private var _credentials: CarrotCredentials?
    
    private var _categoriserAPI: CategorisationAPI?
    private var _transactionAPI: TransactionAPI?
    private var _budgetAPI: BudgetAPI?
    private var _zenAPI: ZenAPI?
    
    /**
        Public constructur. Returns a new instance of a `CarrotContext` class.
     
     # Note:
     Warning: `CarrotContext` class is not thread safe.
    */
    public init() {
        _persistence = .persistent
    }
    
    internal init(persistance: PersistanceType) {
        _persistence = persistance
    }
    
    /**
     Applies library license. Throws an Error if the license is invalid.
     
     - Parameter license: license key

     - Throws: `CategorisationContextError.invalidLicense` if license is invalid
     - Throws: `CategorisationContextError.licenseHasExpired` if license has expired
     - Throws: `CategorisationContextError.couldNotLoadBundleId` if application bundle id did not load
     - Throws: `CategorisationContextError.wrongBundleId` if the library is licensed for another application
     - Throws: `CategorisationContextError.failedToLoadModel` if model can't load
     */
    public func setLicense(license: String) throws {
        _credentials = try CarrotCredentials(license)
        try validateCredentials(_credentials!)
    }
    
    /**
    Applies library license and sets encryption parameters. Throws an Error if the license is invalid.
    
    - Parameter license: license key
    - Parameter encryptionKey: Encryption Key
    - Parameter encryptionIV: Encryption Initialisation Vector, must be of length 16
    
    - Throws: `CategorisationContextError.invalidCredentials` if parameters are empty
    - Throws: `CategorisationContextError.couldNotLoadBundleId` if model can't load
    - Throws: `CategorisationContextError.wrongBundleId` if the library is licensed for another application
    - Throws: `CategorisationContextError.failedToLoadModel` if model can't load
    */
    public func seLicense(license: String, encryptionKey: String, encryptionIV: String) throws {
        setEncryption(key: encryptionKey, iv: encryptionIV)
        try setLicense(license: license)
    }
    
    internal func validateCredentials(_ credentials: CarrotCredentials) throws {
        _isAuthenticated = false
        
        do {
            try credentials.validateSignature()
            
            let licenseDecoder = try LicenseDecoder(license: credentials.licenseKey)
            
            if !licenseDecoder.checkPlatform() {
                throw CarrotContextError.invalidLicense
            }
            
            guard let bundleID = Bundle.main.bundleIdentifier else {
                throw CarrotContextError.couldNotLoadBundleId
            }
            
            if !licenseDecoder.checkBundleId(bundleId: bundleID) {
                throw CarrotContextError.wrongBundleId
            }
            
            if !licenseDecoder.checkExpirationDate() {
                throw CarrotContextError.licenseHasExpired
            }
            
            if !licenseDecoder.checkModules(modules: [LicenseDecoder.MODULE_FULL, LicenseDecoder.MODULE_CATEGORISE]) {
                throw CarrotContextError.invalidLicense
            }
            
            // TODO: extract version and check it
            
            let tflWeightTensor = licenseDecoder.extractTensorFlowLiteParameters()
            self._model = MasterModel(persistance: self._persistence, weightTensor: tflWeightTensor)
            
            if self._model == nil {
                throw CarrotContextError.failedToLoadModel
            }
            
            _isAuthenticated = true
        }
        catch {
            _isAuthenticated = false
            _model = nil
            throw error
        }
    }
    
    /**
     Set Encryption parameters. The encryption parameters are required for storing data in the persistent storage. If the encryption keys were not set, then all persistent related methods will `throw`
     
     - Parameter key: encryptions key
     - Parameter iv: Inititalisation vector, must be of length 16
     */
    public func setEncryption(key: String, iv: String) {
        SharedContext.shared.key = key
        SharedContext.shared.iv = iv
    }
    
    /**
     Provides the Categorisation API.
     `CarrotContext` validates the license and instantiates the object if license is valid, otherwise it throws an error.
     
     - Throws
     - Returns `CategorisationAPI`
     */
    public func getCategorisationAPI() throws -> CategorisationAPI {
        if _categoriserAPI == nil {
            _categoriserAPI = try CategorisationAPI(model: self._model, isAuthenticated: self._isAuthenticated, persistence: self._persistence, credentials: _credentials)
        }
        
        return _categoriserAPI!
    }
    
    /**
     Provides the Transaction API
     `CarrotContext` validates the license and instantiates the object if license is valid, otherwise it throws an error.
     
     - Throws
     - Returns `TransactionAPI`
     */
    public func getTransactionAPI() throws -> TransactionAPI {
        if _transactionAPI == nil {
            _transactionAPI = try TransactionAPI(categoriser: getCategorisationAPI(), credentials: _credentials)
        }
        
        return _transactionAPI!
    }
    
    /**
     Provides Budget API
     `CarrotContext` validates the license and instantiates the object if license is valid, otherwise it throws an error.
     
     - Throws
     - Returns `BudgetAPI`
     */
    public func getBudgetAPI() throws -> BudgetAPI {
        if _budgetAPI == nil {
            _budgetAPI = try BudgetAPI(transactionAPI: getTransactionAPI(), credentials: _credentials)
        }
        
        return _budgetAPI!
    }
    
    /**
     Provides Zen Score API
     `CarrotContext` validates the license and instantiates the object if license is valid, otherwise it throws an error.
     
     - Throws
     - Returns `ZenAPI`
     */
    public func getZenAPI() throws -> ZenAPI {
        if _zenAPI == nil {
            _zenAPI = try ZenAPI(transactionAPI: getTransactionAPI(), budgetAPI: getBudgetAPI(), credentials: _credentials)
        }
        
        return _zenAPI!
    }
}
