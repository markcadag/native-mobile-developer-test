//
//  ValidatePasswordUseCase.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/27/23.
//
import Foundation


protocol ValidatePasswordUseCase {
    func execute(password: String) -> ValidationResult
}

class ValidatePasswordUseCaseImpl: ValidatePasswordUseCase {
    func execute(password: String) -> ValidationResult {
        if(password.isEmpty) {
            return ValidationResult(success: false, errorMessage: "Password Cannot be Empty")
        }
        
        if(password.count < 6) {
            return ValidationResult(success: false, errorMessage: "Password Must Be Greater Than 6")
        }
        
        if(!containsOneSpecialCharacter(password: password)) {
            return ValidationResult(success: false, errorMessage: "Password Must Contain One Special Character")
        }
        
        if(!containsOneDigit(password: password)) {
            return ValidationResult(success: false, errorMessage: "Password Must Contain One Digit")
        }
        
        return ValidationResult(success: true, errorMessage: nil)
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
