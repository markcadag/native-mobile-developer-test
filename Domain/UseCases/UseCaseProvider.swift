//
//  UseCaseProvider.swift
//  AppListingTests
//
//  Created by Mark Anthony Cadag on 9/28/23.
//

import Foundation

protocol UseCaseProvider {
    func makeRegistrationUseCase() -> UserRegistrationUseCase
}
