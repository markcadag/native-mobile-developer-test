//
//  UserRepositoryAPI.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import Combine

class UserRepositoryAPIImpl: UserAPIRepository {
    private let userDataSource: UserAPIDataSource
    
    init(userDataSource: UserAPIDataSource) {
        self.userDataSource = userDataSource
    }
    
    func getUsers(page: Int) -> AnyPublisher<DummyUserPage, Error> {
        return userDataSource.getUsers(page: page)
    }
}
