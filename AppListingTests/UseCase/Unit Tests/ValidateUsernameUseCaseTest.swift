//
//  ValidateUsernameUseCaseTest.swift
//  AppListingTests
//
//  Created by Mark Anthony Cadag on 9/27/23.
//
import XCTest

class ValidateUsernameUseCaseTests: XCTestCase {
    var usernameValidator: ValidateUsernameUseCase!
    
    override func setUp() {
        super.setUp()
        usernameValidator = ValidateUsernameUseCaseImpl()
    }

    override func tearDown() {
        usernameValidator = nil
        super.tearDown()
    }

    func testEmptyUsername() {
        let result = usernameValidator.execute(username: "")
        XCTAssertFalse(result.success, "Empty username should result in failure")
        XCTAssertEqual(result.errorMessage, "Username Cannot be Empty", "Error message should indicate that the username cannot be empty")
    }

    func testShortUsername() {
        let result = usernameValidator.execute(username: "abcde")
        XCTAssertFalse(result.success, "Short username should result in failure")
        XCTAssertEqual(result.errorMessage, "Username character must be greater than or equal to 6", "Error message should indicate that the username must be at least 6 characters")
    }

    func testValidUsername() {
        let result = usernameValidator.execute(username: "validUsername")
        XCTAssertTrue(result.success, "Valid username should result in success")
        XCTAssertNil(result.errorMessage, "Error message should be nil for a valid username")
    }
}
