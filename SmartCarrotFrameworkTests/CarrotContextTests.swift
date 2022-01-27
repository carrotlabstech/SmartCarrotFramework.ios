//
//  CategorisationApplicationContextTests.swift
//  OutlabFrameworkTests
//
//  Copyright © 2019 Outlab gmbh. All rights reserved.
//

import Foundation
import XCTest
@testable import SmartCarrotFramework

// https://stackoverflow.com/questions/30500152/completionhandler-connot-be-executed-in-unit-test-of-xcode-ex-asynchronous-api
// The problem is because the test functions exit before the completion handler finishes.
//
// From Xcode 6, Apple shipped an asynchronous testing facility called XCTestExpectation.
// This thing enables us to wait some time before going out of scope. Usage is as simple as:
class CategorisationApplicationContextTests: XCTestCase {
    func testSetAppIdSuccessful() {
//        let categoriser = CategorisationApplicationContext()
//        let creds = CategorisationApplicationCredentials(applicationCode: "test.application.ios.v1", licenseKey: "Hr64DhJaDSTh78Fg90")
//
//        let expectation = self.expectation(description: "POST Auth Task Executed")
//
//        let resultCallback: AuthResultHandler = { result, error in
//            XCTAssertEqual(result, true)
//
//            expectation.fulfill()
//        }
//
//        categoriser.setAppId(credentials: creds, resultCallback: resultCallback)
//
//        waitForExpectations(timeout: 5, handler: nil)
    }
    
//    func testSetAppIdFail() {
//        let categoriser = CategorisationApplicationContext()
//        let creds = CategorisationApplicationCredentials(applicationCode: "test.application.ios.v1", licenseKey: "wrongHr64DhJaDSTh78Fg90")
//        
//        let expectation = self.expectation(description: "POST Auth Task Executed")
//        
//        let resultCallback: AuthResultHandler = { result, error in
//            XCTAssertEqual(result, false)
//            XCTAssertEqual(error, CategorisationContextError.notAuthorised)
//            
//            expectation.fulfill()
//        }
//        
//        categoriser.setAppId(credentials: creds, resultCallback: resultCallback)
//        
//        waitForExpectations(timeout: 5, handler: nil)
//    }
    
#if COUNTRY_CH
    func testLicenseSetAppId() {
        let context = CarrotContext(persistance: .ephemeral)
        let license =
        """
{ "licenseKey": "KSUnZCs6OiYvZC4+ZDIpPi85PmQ+JSUmaiMlOWp4enh4e3t7e2osPyYmantqeX55DA4AfHsIeQB4enp6enoECwt/fwh/BXl6Dn56Gnx+AHkLc3JqCQh7fQ8LDg8ICXt6CH99eAsMeXgPeXwJfXMOe399eHkLCQwIfA4JDwh9CQx9D38Pe3t9DHJ4cwgIfw4Lfw56ekA=",
"signature": "r+GUsxDuZc9YuRmhqzELHJYLlCgxlGsGLf2NY4A0q3Q3s8ndzcd6VsMYwvSAiWI4AY+sN4t/OccX3EJKjK2abAAYTChENYv+cgOa+g9KkciT3O0XFYYpD7oqIot8JPcxtv0TKdwvbAjDapeWO5QElyeSqWDF2wJcHgaUM3kpqRkoLpfQNLCUpvczWcCaLZbsg+pDTdjMZdeS1K9C8Prv8edk1Sq1hEb6Mhab0KQTNl50/HMi7PnR+YdQPLPt4AQwwXh3OxXv3EMrkBZNWQ+OsCfYmIpbdhWzEDrsK96WtBinEMahiLEt6akTE4V61WN5nL+NpPKVjT9p841YOXw+MCndGc40u+nfEeuMqwm4Kf5hsw6gXGFd9Vc2o51f3oYT1hbW13kU+6Y9LjhaLQW16XSWA0+sSOs2RE0w2aWd9odIbU+c+8k3UcsnImNtKfr3EHXo+aNB9twZ0AOolmpFkQQd4bu++CdXgEeIa1MX31oCEfuAOl9YERxqG9itePYf8M2HLL/1QAgNywbsVcrWtjTrV3hOOD8DzYHjtVajndVnjslOge82q+7O5s/iP4EEr+XG6Lhp4W+55RlRcx4MWAwa8XlgAFakrVSwkFQ1zjU4K47WbzRjS/wb4LWwOJXoTfo7ohRALNpshE20Ft/LSUCLEfJp88MNrVKLWKBQkmM=" }
"""
        
        try? context.setLicense(license: license)
    }
    
#elseif COUNTRY_US
    func testLicenseSetAppIdUS() {
        let context = CarrotContext(persistance: .ephemeral)
        let license =
        """
        { "licenseKey": "KSUnZCs6OiYvZC4+ZDIpPi85PmQ+JSUmaiMlOWp4enh4e3t7e2osPyYmantqeX55DA4AfHsIeQByenp6BHt7CAx5fwV5eg5+ehp8fgB5C3Nyanl/DwtzDntyDn97e3h/CQx7eAxze3h6D3p5en54DHtyenJ9cg57ewx9DH95Cwt4eQx6fn16Dgx6e3kMDwlye35A",
        "signature": "Zs3dXPytDxpiHVEZX2pR9LuqdtYUvS1h49OdrQ6FjUTzzigSEZ01ESjXyPPjIIGZtzJ+G/faGZkqCffUp/LG/wU7ON4uQd09XAJF3aqgvZun6BSM5LhD4dpnSmiopU2M63SXo4lcSOMmdSaWOX4Ta0ciKnDgKnPPeqFPQjDc0w1XpN2yhnJbuKL2uCgnzGFLAACyI+B+7/YEgW3HQbZ8kGHTnpdRMmBRwSchjhFgEp058LToqsxDrVtuKKGb/anqvc4E9Xr8ABT0grxM2tPfODuocgNIe1hUX8vbagHa0IkyzDTF2VOvLztatR3Krpckk0DJEZ61YwNF4kFM48Zwn5XIc6FbALpfSKLtB4zRhhZz01eLCJxnfvj/SAWFKi3F47I6VJqfgsinLAU8W7vSuZe1cVEpzbsL608MIMYtaWgZbfqS3nA5Un8AO02vFBbSTRLSjC3F9N7GbBCXd/9POBonKUgGFqy3w/FostNn/MXVzpu5i6JmgcDHevf0QmoAL1i55bwZq7pD777QVb8GyegWN4FZ37kQ2LMabkqJZPRj2/NoF2GHQ/UQ+s6Bvry0n+2BIJcDwnrO3a2FA7C/hc//1qg0s4fvaUItIAprS6HF4uqBJ0ug8OSfJEp21DnAoBhq8sRwEwFqTmWA45CXgJFpfHs6J//rMa7JJiMUKn8=" }
"""
        try? context.setLicense(license: license)
    }
#endif
        
    func testLicenseSetAppIdWrongSingature() throws {
        let context = CarrotContext(persistance: .ephemeral)
        let license =
    """
    { "licenseKey": "KSUnZCs6OiYvZC4+ZDIpPi85PmQ+JSUmaiMlOWp4enh4e3t7e2osPyYmantqeX55DA4AfHsIeQB4enp6enoECwt/fwh/BXl6Dn56Gnx+AHkLc3JqCQh7fQ8LDg8ICXt6CH99eAsMeXgPeXwJfXMOe399eHkLCQwIfA4JDwh9CQx9D38Pe3t9DHJ4cwgIfw4Lfw56ekA=",
    "signature": "r+GUsxDuZc9YuRmhqzELHJYLlCgxlGsGLf2NY4A0q3Q3s8ndzcd6VsMYwvSAiWI4AY+sN4t/OccX3EJKjK2abAAYTChENYv+cgOa+g9KkciT3O0XFYYpD7oqIot8JPcxtv0TKdwvbAjDapeWO5QElyeSqWDF2wJcHgaUM3kpqRkoLpfQNLCUpvczWcCaLZbsg+pDTdjMZdeS1K9C8Prv8edk1Sq1hEb6Mhab0KQTNl50/HMi7PnR+YdQPLPt4AQwwXh3OxXv3EMrkBZNWQ+OsCfYmIpbdhWzEDrsK96WtBinEMahiLEt6akTE4V61WN5nL+NpPKVjT9p841YOXw+MCndGc40u+nfEeuMqwm4Kf5hsw6gXGFd9Vc2o51f3oYT1hbW13kU+6Y9LjhaLQW16XSWA0+sSOs2RE0w2aWd9odIbU+c+8k3UcsnImNtKfr3EHXo+aNB9twZ0AOolmpFkQQd4bu++CdXgEeIa1MX31oCEfuAOl9YERxqG9itePYf8M2HLL/1QAgNywbsVcrWtjTrV3hOOD8DzYHjtVajndVnjslOge82q+7O5s/iP4EEr+XG6Lhp4W!55RlRcx4MWAwa8XlgAFakrVSwkFQ1zjU4K47WbzRjS/wb4LWwOJXoTfo7ohRALNpshE20Ft/LSUCLEfJp88MNrVKLWKBQkmM=" }
    """
            
        try XCTAssertThrowsError(context.setLicense(license: license))
    }
    
    func testWronglyFormattedLicense() throws {
        let context = CarrotContext(persistance: .ephemeral)
                let license =
                """
        { "licenseKey: "KSUnZCs6OiYvZC4+ZDIpPi85PmQ+JSUmaiMlOWp4enh4e3t7e2osPyYmantqeX55DA4AfHsIeQB4enp6enoECwt/fwh/BXl6Dn56Gnx+AHkLc3JqCQh7fQ8LDg8ICXt6CH99eAsMeXgPeXwJfXMOe399eHkLCQwIfA4JDwh9CQx9D38Pe3t9DHJ4cwgIfw4Lfw56ekA=",
        "signature": "r+GUsxDuZc9YuRmhqzELHJYLlCgxlGsGLf2NY4A0q3Q3s8ndzcd6VsMYwvSAiWI4AY+sN4t/OccX3EJKjK2abAAYTChENYv+cgOa+g9KkciT3O0XFYYpD7oqIot8JPcxtv0TKdwvbAjDapeWO5QElyeSqWDF2wJcHgaUM3kpqRkoLpfQNLCUpvczWcCaLZbsg+pDTdjMZdeS1K9C8Prv8edk1Sq1hEb6Mhab0KQTNl50/HMi7PnR+YdQPLPt4AQwwXh3OxXv3EMrkBZNWQ+OsCfYmIpbdhWzEDrsK96WtBinEMahiLEt6akTE4V61WN5nL+NpPKVjT9p841YOXw+MCndGc40u+nfEeuMqwm4Kf5hsw6gXGFd9Vc2o51f3oYT1hbW13kU+6Y9LjhaLQW16XSWA0+sSOs2RE0w2aWd9odIbU+c+8k3UcsnImNtKfr3EHXo+aNB9twZ0AOolmpFkQQd4bu++CdXgEeIa1MX31oCEfuAOl9YERxqG9itePYf8M2HLL/1QAgNywbsVcrWtjTrV3hOOD8DzYHjtVajndVnjslOge82q+7O5s/iP4EEr+XG6Lhp4W+55RlRcx4MWAwa8XlgAFakrVSwkFQ1zjU4K47WbzRjS/wb4LWwOJXoTfo7ohRALNpshE20Ft/LSUCLEfJp88MNrVKLWKBQkmM=" }
        """

        try XCTAssertThrowsError(context.setLicense(license: license))
    }
    
    func testLicenseDoesNotHaveModule() {
        let context = CarrotContext(persistance: .ephemeral)
        try? context.setLicense(license: GlobalsTests.CATEGORISE_ONLY_LICENSE)
        
        let zenAPI = try? context.getZenAPI()
        XCTAssertNil(zenAPI)
        
        let budgetAPI = try? context.getBudgetAPI()
        XCTAssertNil(budgetAPI)
        
        let transactionAPI = try? context.getTransactionAPI()
        XCTAssertNil(transactionAPI)
        
        let catAPI = try? context.getCategorisationAPI()
        XCTAssertNotNil(catAPI)
    }
    
}
