//
//  RegistrationValidationUseCase.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/30/23.
//

import Foundation
import Combine

protocol FieldValidationUseCase {
    func validateUsername(username: String) -> AnyPublisher<Void, Error>
    func validateEmail(email: String) -> AnyPublisher<Void, Error>
    func validatePassword(password: String) -> AnyPublisher<Void, Error>
}

class FieldValidator: FieldValidationUseCase {
    
    let UNAME_MAX_CHARACTER = 6
    let PWORD_MAX_CHARACTER = 6
    private let userRepository: UserRepository
   
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func validateUsername(username: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            if username.isEmpty {
                promise(.failure(UserValidationError.invalidUsername("Username is required.")))
            } else if username.count < self.UNAME_MAX_CHARACTER {
                promise(.failure(UserValidationError.invalidUsername("Username should have at least \(self.UNAME_MAX_CHARACTER) characters.")))
            } else {
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
    
    func validateEmail(email: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            // Simplified email validation, you can use a regular expression for a more robust check.
            if email.isEmpty {
                promise(.failure(UserValidationError.invalidEmail("Email is required")))
            } else if !self.isValidEmail(email: email) {
                promise(.failure(UserValidationError.invalidEmail("Invalid email format")))
            } else {
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
    
    func validatePassword(password: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            if password.isEmpty {
                promise(.failure(UserValidationError.invalidPassword("Password is required")))
            } else if password.count < self.PWORD_MAX_CHARACTER {
                promise(.failure(UserValidationError.invalidPassword("Password should have at least \(self.PWORD_MAX_CHARACTER) characters")))
            } else if !self.containsOneSpecialCharacter(password: password) {
                promise(.failure(UserValidationError.invalidPassword("Password should have at least one special character")))
            } else if !self.containsOneDigit(password: password) {
                promise(.failure(UserValidationError.invalidPassword("Password should have at least one digit")))
            } else {
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func containsOneSpecialCharacter(password: String) -> Bool {
        let passwordRegex = ".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>?].*"
        return regexValidation(password: password, regex: passwordRegex)
    }
    
    func containsOneDigit(password: String) -> Bool {
        let passwordRegex = ".*[0-9].*"
        return regexValidation(password: password, regex: passwordRegex)
    }
    
    func regexValidation(password: String, regex: String) -> Bool {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return passwordPredicate.evaluate(with: password)
    }

}
