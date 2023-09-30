//
//  SecureStorageConvertible.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/29/23.
//

import Foundation

protocol SecureStorageConvertible {
    associatedtype UserSecureStorage
    
    func toUserSecure() -> UserSecureStorage
}
