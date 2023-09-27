//
//  ValidateEmailUseCase.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/27/23.
//
import Foundation


protocol ValidateEmailUseCase {
    func execute(email: String) -> ValidationResult
}

class ValidateEmailUseCaseImpl: ValidateEmailUseCase {
    func execute(email: String) -> ValidationResult {
        if(email.isEmpty) {
            return ValidationResult(success: false, errorMessage: "Email Cannot be Empty")
        }
        
        if(!isValidEmail(email: email)) {
            return ValidationResult(success: false, errorMessage: "Invalid Email")
        }
        
        return ValidationResult(success: true, errorMessage: nil)
        
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}


