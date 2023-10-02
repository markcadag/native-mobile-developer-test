//
//  UserAPI.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation

struct UserAPI: Codable {
    let id: String?
    let title: String?
    let firstName: String?
    let lastName: String?
    let picture: String?
}

extension UserAPI: DomainConvertible {
    func toDomain() -> DummyUser {
        return DummyUser(id: id ?? "", title: title ?? "" , firstName: firstName ?? "",
                         lastName: lastName ?? "", picture: picture ?? "")
    }
}
