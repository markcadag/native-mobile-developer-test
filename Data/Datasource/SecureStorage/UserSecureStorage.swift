//
//  UserSecureStorage.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/29/23.
//

import Foundation

struct UserSecureStorage: Codable {
    let username: String
    let email: String
    let passwordHash: String
    let salt: String
}

extension UserSecureStorage: DomainConvertible {
    func toDomain() -> User {
        return User(username: username, email: email, password: nil, passwordHash: passwordHash, salt: salt)
    }
}

extension User: SecureStorageConvertible {
    func toUserSecure() -> UserSecureStorage {
        return UserSecureStorage(username: username, email: email, passwordHash: passwordHash, salt: salt)
    }
}
