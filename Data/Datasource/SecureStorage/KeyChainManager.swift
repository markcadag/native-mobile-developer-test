//
//  KeyChainManager.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/28/23.
//

import Foundation
import Security

class KeychainManager {
    // MARK: - Properties
    
    private let service: String
    
    // MARK: - Initialization
    
    init(service: String) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func save<T: Codable>(_ object: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(object)
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecValueData: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError(status: status)
        }
    }
    
    func retrieve<T: Codable>(forKey key: String) throws -> T? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                return nil
            }
            throw KeychainError(status: status)
        }
        
        guard let data = item as? Data else {
            throw KeychainError(type: .unexpectedData)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func delete(forKey key: String) throws {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError(status: status)
        }
    }
    
    // MARK: - Error Handling
    
    enum KeychainError: Error {
        case unexpectedData
        case itemNotFound
        case status(OSStatus)
        
        init(status: OSStatus) {
            self = .status(status)
        }
        
        init(type: KeychainError) {
            self = type
        }
    }
}
