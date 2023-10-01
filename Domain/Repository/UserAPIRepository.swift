//
//  UserAPIRepository.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import Combine

protocol UserAPIRepository {
    func getUsers(page: Int) -> AnyPublisher<DummyUserPage, Error>
}
