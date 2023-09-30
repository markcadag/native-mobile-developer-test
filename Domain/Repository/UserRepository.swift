//
//  UserRepository.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/28/23.
//

import Combine

protocol UserRepository {
    func getUser(email: String) -> AnyPublisher<User?, Error>
    func saveUser(user: User) -> AnyPublisher<User, Error>
    func delete(email: String) -> AnyPublisher<Bool, Error>
}
