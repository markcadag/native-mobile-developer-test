//
//  UserDataSource.swift
//  AppListingTests
//
//  Created by Mark Anthony Cadag on 9/27/23.
//

import Foundation
import Combine

protocol UserDataSource {
    func getUser(email: String) -> AnyPublisher<User?, Error>
    func saveUser(user: User) -> AnyPublisher<User, Error>
    func removeUser(email: String) -> AnyPublisher<Bool, Error>
}
