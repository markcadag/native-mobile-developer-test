//
//  FetchUserListUseCase.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import Combine
import CryptoKit

protocol ListDummyUserUseCase {
    func execute(page: Int) -> AnyPublisher<DummyUserPage, NetworkError>
}

class ListDummyUserUseCaseInteractor: ListDummyUserUseCase {
    private let userRepository: UserAPIRepository
    private var cancellables: Set<AnyCancellable> = []
 
    init(userRepository: UserAPIRepository) {
        self.userRepository = userRepository
    }
    
    func execute(page: Int) -> AnyPublisher<DummyUserPage, NetworkError> {
        return self.userRepository.getUsers(page: page)
            .mapError { error in
                guard let error = error as? NetworkError else { return NetworkError.apiError("Unknown Error") }
                return error
            }.eraseToAnyPublisher()
    }
}
