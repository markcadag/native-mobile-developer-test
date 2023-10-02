//
//  LoginUseCase.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import Combine
import CryptoKit

protocol UserLoginUseCase {
    func execute(email: String, password: String) -> AnyPublisher<User, LoginError>
}

class UserLoginUseCaseInteractor: UserLoginUseCase {
    private let userRepository: UserRepository
    private var cancellables: Set<AnyCancellable> = []
 
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(email: String, password: String) -> AnyPublisher<User, LoginError>  {
        return userRepository.getUser(email: email)
           .flatMap { user -> AnyPublisher<User, Error> in
               guard let user = user else {
                    return Fail(error: LoginError.emailDoesNotExist)
                        .eraseToAnyPublisher()
               }
               
               guard let salt = user.salt.data(using: .utf8) else {
                   return Fail(error: LoginError.accountCorrupted)
                       .eraseToAnyPublisher()
               }
                
               let isPasswordMatch = self.isPasswordMatched(password: password, salt: salt, hashedPassword: user.passwordHash)
                
               if(!isPasswordMatch) {
                   return Fail(error: LoginError.invalidPassword)
                        .eraseToAnyPublisher()
               }
            
                return Just(user)
                    .mapError { _ in LoginError.loginFailed }
                    .eraseToAnyPublisher()
            }
            .mapError { error in
                guard let error = error as? LoginError else { return .loginFailed }
                return error
            }
            .eraseToAnyPublisher()
    }
    
    private func isPasswordMatched(password: String, salt: Data, hashedPassword: String) -> Bool {
        let enteredPasswordHash = hashPassword(password, withSalt: salt)
        return enteredPasswordHash == hashedPassword
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
