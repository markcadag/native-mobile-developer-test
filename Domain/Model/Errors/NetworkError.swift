//
//  APIError.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation

enum NetworkError: Error {
    case apiError(String)

    var localizedDescription: String {
        switch self {
        case .apiError(let message):
            return message
        }
    }
}

