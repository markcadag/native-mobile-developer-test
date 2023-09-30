//
//  SecureStorageDatasource.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/28/23.
//

import Foundation
import Combine


class SecureStorageDatasource: UserDataSource {
    private let keychainManager: KeychainManager
    
    init(keychainManager: KeychainManager) {
        self.keychainManager = keychainManager
    }
    
    func getUser(email: String) -> AnyPublisher<User?, Error> {
        do {
            // Attempt to retrieve a user from the keychain
            if let user: UserSecureStorage = try keychainManager.retrieve(forKey: email) {
                return Just(user.toDomain())
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                // User not found, return nil
                return Just(nil)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    func saveUser(user: User) -> AnyPublisher<User, Error> {
        do {
            // Save the user to the keychain
            try keychainManager.save(user.toUserSecure(), forKey: user.email)
            return Just(user)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    func removeUser(email: String) -> AnyPublisher<Bool, Error> {
        do {
            // Attempt to delete the user from the keychain
            try keychainManager.delete(forKey: email)
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
