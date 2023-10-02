//
//  UserValidation.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/30/23.
//

import Foundation

enum UserValidationError: Error {
    case invalidUsername(String)
    case invalidEmail(String)
    case invalidPassword(String)
    case invalidUser(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidUsername(let message):
            return message
        case .invalidEmail(let message):
            return message
        case .invalidPassword(let message):
            return message
        case .invalidUser(let message):
            return message
        }
    }
}
