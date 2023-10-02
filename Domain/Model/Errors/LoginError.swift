//
//  LoginError.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation

enum LoginError: Error {
    case emailDoesNotExist, invalidPassword, loginFailed, accountCorrupted
    
    var localizedDescription: String {
        switch self {
        case .emailDoesNotExist:
            return "Email does not exist"
        case .invalidPassword:
            return "Invalid password"
        case .loginFailed:
            return "Login Failed"
        case .accountCorrupted:
            return "Account is corrupted"
        }
    }
}
