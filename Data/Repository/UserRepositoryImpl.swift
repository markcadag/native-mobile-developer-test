//
//  UserRepositoryImpl.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/28/23.
//

import Foundation
import Combine

class UserRepositoryImpl: UserRepository {
    private let userDataSource: UserDataSource
    
    init(userDataSource: UserDataSource) {
        self.userDataSource = userDataSource
    }
    
    func getUser(email: String) -> AnyPublisher<User?, Error> {
        return userDataSource.getUser(email: email)
    }
    
    func saveUser(user: User) -> AnyPublisher<User, Error> {
        return userDataSource.saveUser(user: user)
    }
    
    func delete(email: String) -> AnyPublisher<Bool, Error> {
        return userDataSource.removeUser(email: email)
    }
}
