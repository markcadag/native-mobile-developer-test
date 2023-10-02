//
//  LoginViewModel.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    // Inputs
    @Published var email = ""
    @Published var password = ""
    
    // Outputs
    @Published var emailValidation = ""
    @Published var passwordValidation = ""
    @Published var userExistenceValidation = ""
    @Published var isButtonEnabled = false

      
    private var cancellables: Set<AnyCancellable> = []
    
    private let fieldValidator: FieldValidationUseCase
    private let userLoginUseCase: UserLoginUseCase
    
    init(fieldValidator: FieldValidationUseCase, userLoginUseCase: UserLoginUseCase) {
        self.fieldValidator = fieldValidator
        self.userLoginUseCase = userLoginUseCase
    }
    
    func initViewModel() {
        
        $email.debounce(for: 0.5, scheduler: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] value in
                guard let self = self else { return }
                self.validateField(value: value, into: \.emailValidation, validator: self.fieldValidator.validateEmail)
            }.store(in: &cancellables)
        
        $password.debounce(for: 0.5, scheduler: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] value in
                guard let self = self else { return }
                self.validateField(value: value, into: \.passwordValidation, validator: self.fieldValidator.validatePassword)
            }.store(in: &cancellables)
        
        Publishers.CombineLatest($emailValidation, $passwordValidation)
            .dropFirst() // This ensures that the initial values are not considered
            .map { emailValidation, passwordValidation in
                // Disable the button if either emailValidation or passwordValidation is not empty
                return emailValidation.isEmpty && passwordValidation.isEmpty && !self.email.isEmpty && !self.password.isEmpty
            }
            .assign(to: &$isButtonEnabled)
    }
    
    func loginUser() {
        userLoginUseCase.execute(email: email, password: password)
            .print("registration")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.userExistenceValidation = ""
                    break
                case .failure(let error):
                    self.userExistenceValidation = error.localizedDescription
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    func validateField<Value>(
        value: Value,
        into resultKeyPath: ReferenceWritableKeyPath<LoginViewModel, String>,
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
