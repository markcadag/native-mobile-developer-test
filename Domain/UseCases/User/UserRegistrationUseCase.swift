//
//  SaveUserUseCase.swift
//  AppListingTests
//
//  Created by Mark Anthony Cadag on 9/28/23.
//

import Foundation
import Combine
import CryptoKit

protocol UserRegistrationUseCase {
    func execute(username: String, email: String, password: String) -> AnyPublisher<User, RegistrationError>
}

class UserRegistrationInteractor: UserRegistrationUseCase {
    private let userRepository: UserRepository
    private var cancellables: Set<AnyCancellable> = []
 
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(username: String, email: String, password: String) -> AnyPublisher<User, RegistrationError>  {
        return userRepository.getUser(email: email)
            .print("getUser")
            .flatMap { user -> AnyPublisher<User, Error> in
                if user != nil {
                    return Fail(error: RegistrationError.userAlreadyExists)
                        .print("userAlreadyExists")
                        .eraseToAnyPublisher()
                } else {
                    let salt = self.generateSalt()
                    let saltBase64 = salt.base64EncodedString()
                    let hashedPassword = self.hashPassword(password, withSalt: salt)
                    let newUser = User(username: username, email: email, password: password, passwordHash: hashedPassword, salt: saltBase64)
                    
                    
                    print("saving password and salt \(hashedPassword) \(saltBase64)");
                    
                    // Return the result of saveUser
                    return self.userRepository.saveUser(user: newUser)
                        .print("saveUser")
                        .mapError { _ in RegistrationError.registrationFailed }
                        .eraseToAnyPublisher()
                }
            }
            .mapError { error in
                guard let error = error as? RegistrationError else { return .registrationFailed }
                return error
            }
            .eraseToAnyPublisher()
    }
    
    private func generateSalt() -> Data {
        var randomBytes = [UInt8](repeating: 0, count: 16) // 16 bytes (128 bits) salt
        _ = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        return Data(randomBytes)
    }
    
    private func hashPassword(_ password: String, withSalt salt: Data) -> String {
        let saltedPassword = password + salt.base64EncodedString()
        if let saltedPasswordData = saltedPassword.data(using: .utf8) {
            let hashed = SHA256.hash(data: saltedPasswordData)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        }
        return ""
    }
}
