//
//  ValidateEmailUseCase.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/27/23.
//
import Foundation


protocol ValidateUsernameUseCase {
    func execute(username: String) -> ValidationResult
}

class ValidateUsernameUseCaseImpl: ValidateUsernameUseCase {
    func execute(username: String) -> ValidationResult {
        if(username.isEmpty) {
            return ValidationResult(success: false, errorMessage: "Username Cannot be Empty")
        }
        
        if(username.count < 6) {
            return ValidationResult(success: false, errorMessage: "Username character must be greater than or equal to 6")
        }
        
        return ValidationResult(success: true, errorMessage: nil)
        
    }
}
