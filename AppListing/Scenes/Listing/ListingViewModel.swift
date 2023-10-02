//
//  ListingViewModel.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import Combine
import UIKit

class ListingViewModel: ObservableObject {
    
    // Outputs
    @Published var dummyUsers: [DummyUser] = []
    @Published var error: String = ""
    var currentPage: Int = 1
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let listDummyUseCase: ListDummyUserUseCase
    
    @Published var showAlertMessage = false
    @Published var openCameraRoll = false
    @Published var message = ""
    
    init(listDummyUseCase: ListDummyUserUseCase) {
        self.listDummyUseCase = listDummyUseCase
    }

    func getUsers() {
          listDummyUseCase.execute(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = "\(error.localizedDescription). Tap to retry again"
                case .finished:
                    break
                }
            }
            receiveValue: { dummyPage in
                if(dummyPage.data.isEmpty) {
                    self.error = "Reached Last Page. Tap to retry again"
                    return
                }
                self.dummyUsers.append(contentsOf: dummyPage.data)
                self.currentPage += 1
              }.store(in: &cancellables)
      }
    
    func savePhoto(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        showAlertMessage = true
        message = "Image Saved"
    }
    
    func retryGetUser() {
        if !error.isEmpty {
            error = ""
            getUsers()
        }
    }
}
