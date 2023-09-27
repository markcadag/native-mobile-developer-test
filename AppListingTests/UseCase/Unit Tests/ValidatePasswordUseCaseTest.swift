//  ValidatePasswordUseCaseTests.swift
//  AppListingTests
//
//  Created by Mark Anthony Cadag on 9/27/23.
//
import XCTest

class ValidatePasswordUseCaseTests: XCTestCase {
    var passwordValidator: ValidatePasswordUseCase!
    
    override func setUp() {
        super.setUp()
        passwordValidator = ValidatePasswordUseCaseImpl()
    }

    override func tearDown() {
        passwordValidator = nil
        super.tearDown()
    }

    func testEmptyPassword() {
        let result = passwordValidator.execute(password: "")
        XCTAssertFalse(result.success, "Empty password should result in failure")
        XCTAssertEqual(result.errorMessage, "Password Cannot be Empty", "Error message should indicate that the password cannot be empty")
    }

    func testShortPassword() {
        let result = passwordValidator.execute(password: "abcde")
        XCTAssertFalse(result.success, "Short password should result in failure")
        XCTAssertEqual(result.errorMessage, "Password Must Be Greater Than 6", "Error message should indicate that the password must be greater than 6 characters")
    }

    func testPasswordWithoutSpecialCharacter() {
        let result = passwordValidator.execute(password: "Password123")
        XCTAssertFalse(result.success, "Password without a special character should result in failure")
        XCTAssertEqual(result.errorMessage, "Password Must Contain One Special Character", "Error message should indicate that the password must contain one special character")
    }

    func testPasswordWithoutDigit() {
        let result = passwordValidator.execute(password: "Password!")
        XCTAssertFalse(result.success, "Password without a digit should result in failure")
        XCTAssertEqual(result.errorMessage, "Password Must Contain One Digit", "Error message should indicate that the password must contain one digit")
    }

    func testValidPassword() {
        let result = passwordValidator.execute(password: "P@ssw0rd1")
        XCTAssertTrue(result.success, "Valid password should result in success")
        XCTAssertNil(result.errorMessage, "Error message should be nil for a valid password")
    }
}
