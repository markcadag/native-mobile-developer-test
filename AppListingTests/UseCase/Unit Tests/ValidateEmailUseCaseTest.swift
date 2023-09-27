//
//  ValidateEmailUseCaseTest.swift
//  AppListingTests
//
//  Created by Mark Anthony Cadag on 9/27/23.
//

import Foundation
import XCTest

class ValidateEmailUseCaseTests: XCTestCase {
    var emailValidator: ValidateEmailUseCase!
    
    override func setUp() {
        super.setUp()
        emailValidator = ValidateEmailUseCaseImpl()
    }

    override func tearDown() {
        emailValidator = nil
        super.tearDown()
    }

    func testEmptyEmail() {
        let result = emailValidator.execute(email: "")
        XCTAssertFalse(result.success, "Empty email should result in failure")
        XCTAssertEqual(result.errorMessage, "Email Cannot be Empty", "Error message should indicate that the email cannot be empty")
    }

    func testInvalidEmail() {
        let result = emailValidator.execute(email: "invalid-email")
        XCTAssertFalse(result.success, "Invalid email should result in failure")
        XCTAssertEqual(result.errorMessage, "Invalid Email", "Error message should indicate that the email is invalid")
    }

    func testValidEmail() {
        let result = emailValidator.execute(email: "valid.email@example.com")
        XCTAssertTrue(result.success, "Valid email should result in success")
        XCTAssertNil(result.errorMessage, "Error message should be nil for a valid email")
    }
}
