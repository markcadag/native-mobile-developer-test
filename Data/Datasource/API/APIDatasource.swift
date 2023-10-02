//
//  APIDatasource.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import Combine


class APIDatasource: UserAPIDataSource {
    private let apiManager: APIManager<UserAPIResponse>
    
    init(apiManager: APIManager<UserAPIResponse>) {
        self.apiManager = apiManager
    }
    
    func getUsers(page: Int) -> AnyPublisher<DummyUserPage, Error> {
        let queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        return apiManager.get(path: "/user", queryItems)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
}
