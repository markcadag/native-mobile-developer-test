//
//  UserResponse.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation

struct UserAPIResponse: Codable {
    let data: [UserAPI]
    let total: Int
    let page: Int
    let limit: Int
}

extension UserAPIResponse: DomainConvertible {
    func toDomain() -> DummyUserPage {
        DummyUserPage(data: data.map { $0.toDomain() }, total: total,
                           page: page, limit: limit)
    }
}
