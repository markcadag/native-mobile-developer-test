//
//  ListingViewModel.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import Combine

class ListingViewModel: ObservableObject {
    
    // Outputs
    @Published var dummyUsers: [DummyUser] = []
    @Published var error: String = ""
    var currentPage: Int = 1
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let listDummyUseCase: ListDummyUserUseCase
    
    init(listDummyUseCase: ListDummyUserUseCase) {
        self.listDummyUseCase = listDummyUseCase
    }

    func getUsers() {
          listDummyUseCase.execute(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = error.localizedDescription
                case .finished:
                    break
                }
            }
            receiveValue: { dummyPage in
                  self.dummyUsers.append(contentsOf: dummyPage.data)
                  self.currentPage += 1
              }.store(in: &cancellables)
      }
    
    func retryGetUser() {
        if !error.isEmpty {
            error = ""
            getUsers()
        }
    }
}
