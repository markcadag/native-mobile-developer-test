//
//  User.swift
//  AppListingTests
//
//  Created by Mark Anthony Cadag on 9/27/23.
//

import Foundation


struct User {
    let username: String
    let email: String
    let password: String?
    let passwordHash: String
    let salt: String
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(username)
        hasher.combine(email)
    }
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username && lhs.email == rhs.email
    }
}


