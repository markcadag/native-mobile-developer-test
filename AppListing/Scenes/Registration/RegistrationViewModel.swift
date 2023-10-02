//
//  RegistrationViewModel.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/30/23.
//

import Foundation
import Combine
import SwiftUI

enum RegistrationRoute : String , Hashable {
    case listView
}

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
    @Published var isButtonEnabled = false
    @Published var registrationPath = NavigationPath()
    @Published var user: User? = nil
      
    private var cancellables: Set<AnyCancellable> = []
    
    private let registrationValidator: FieldValidationUseCase
    private let registrationUseCase: UserRegistrationUseCase
    
    init(registrationValidator: FieldValidationUseCase, registrationUseCase: UserRegistrationUseCase) {
        self.registrationValidator = registrationValidator
        self.registrationUseCase = registrationUseCase
    }
    
    func initViewModel() {
        $username
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] value in
                guard let self = self else { return }
                self.validateField(value: value, into: \.usernameValidation, validator: self.registrationValidator.validateUsername)
            }
            .store(in: &cancellables)
        
        $email
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] value in
                guard let self = self else { return }
                self.validateField(value: value, into: \.emailValidation, validator: self.registrationValidator.validateEmail)
            }
            .store(in: &cancellables)
        
        $password
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] value in
                guard let self = self else { return }
                self.validateField(value: value, into: \.passwordValidation, validator: self.registrationValidator.validatePassword)
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest3($usernameValidation, $emailValidation, $passwordValidation)
            .dropFirst()
            .map { [weak self] usernameValidation, emailValidation, passwordValidation in
                guard let self = self else { return false }
                // Ensure that email and password fields are not empty
                let fieldNotEmpty = !self.email.isEmpty && !self.password.isEmpty && !self.username.isEmpty
                // Enable the button if email and password are valid and not empty
                return usernameValidation.isEmpty && emailValidation.isEmpty && passwordValidation.isEmpty && fieldNotEmpty
            }
            .assign(to: &$isButtonEnabled)
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
            }, receiveValue: { user in
                self.user = user
                self.navigate(route: .listView)
            })
            .store(in: &cancellables)
    }
    
    func navigate(route: RegistrationRoute) {
        registrationPath.append(route)
    }
    
    func pop() {
        registrationPath.removeLast()
    }
    
    
    func validateField<Value>(
        value: Value,
        into resultKeyPath: ReferenceWritableKeyPath<RegistrationViewModel, String>,
        validator: @escaping (Value) -> AnyPublisher<Void, Error>
    ) {
        userExistenceValidation = ""
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
