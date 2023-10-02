//
//  RegistrationError.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/30/23.
//

import Foundation

enum RegistrationError: Error {
    case userAlreadyExists, registrationFailed
    
    var localizedDescription: String {
        switch self {
        case .userAlreadyExists:
            return "User Already Exist"
        case .registrationFailed:
            return "Registration Failed"
        }
    }
}
