//
//  RegistrationViewModel.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/30/23.
//

import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    
    // Inputs
    @Published var email = ""
    @Published var username = ""
    @Published var password = ""
    
    // Outputs
    @Published var emailValidation = ""
    @Published var usernameValidation = ""
    @Published var passwordValidation = ""
    @Published var userExistenceValidation = ""
      
    private var cancellables: Set<AnyCancellable> = []
    
    private let registrationValidator: RegistrationValidationUseCase
    private let registrationUseCase: UserRegistrationUseCase
    
    init(registrationValidator: RegistrationValidationUseCase, registrationUseCase: UserRegistrationUseCase) {
        self.registrationValidator = registrationValidator
        self.registrationUseCase = registrationUseCase
    }
    
    func initViewModel() {
        
        $username.debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] value in
                guard let self = self else { return }
                self.validateField(value: value, into: \.usernameValidation, validator: self.registrationValidator.validateUsername)
            }.store(in: &cancellables)
        
        $email.debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self.validateField(value: value, into: \.emailValidation, validator: self.registrationValidator.validateEmail)
            }.store(in: &cancellables)
        
        $password.debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                self.validateField(value: value, into: \.passwordValidation, validator: self.registrationValidator.validatePassword)
            }.store(in: &cancellables)
    }
    
    func registerUser() {
        registrationUseCase.execute(username: username, email: email, password: password)
            .print("registration")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.userExistenceValidation = ""
                    break
                case .failure(let error):
                    self.userExistenceValidation = error.localizedDescription
                }
            }, receiveValue: { _ in
            })
            .store(in: &cancellables)
    }
    
    func validateField<Value>(
        value: Value,
        into resultKeyPath: ReferenceWritableKeyPath<RegistrationViewModel, String>,
        validator: @escaping (Value) -> AnyPublisher<Void, Error>
    ) {
        validator(value)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self[keyPath: resultKeyPath] = ""
                    break
                case .failure(let error):
                    if let userValidationError = error as? UserValidationError {
                        self[keyPath: resultKeyPath] = userValidationError.localizedDescription
                    }
                }
            }, receiveValue: { _ in
            })
            .store(in: &cancellables)
    }

}
