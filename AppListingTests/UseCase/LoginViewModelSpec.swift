//
//  LoginUSerTEst.swift
//  AppListingTests
//
//  Created by Mark Anthony Cadag on 10/2/23.
//

import Foundation

import Quick
import Nimble
import Combine

@testable import AppListing // Replace with your actual app module name

class LoginViewModelSpec: QuickSpec {
    
    override class func spec() {
        describe("LoginViewModel") {
            
            var viewModel: LoginViewModel!
            var cancellables: Set<AnyCancellable> = []
            
            beforeEach {
                // Initialize the ViewModel with mock dependencies
                viewModel = LoginViewModel(
                    fieldValidator: MockFieldValidator(),
                    userLoginUseCase: MockUserLoginUseCase()
                )
                
                // Call the initViewModel() method to set up Combine publishers
                viewModel.initViewModel()
            }
            
            afterEach {
                viewModel = nil
                cancellables.removeAll()
            }
            
            // Create a mock FieldValidator for testing
          
            context("when email is valid") {
                it("should have empty email validation") {
                    viewModel.email = "test@example.com"
                    
                    // Expect empty email validation message
                    expect(viewModel.emailValidation).toEventually(beEmpty())
                }
            }
            
            context("when password is valid") {
                it("should have empty password validation") {
                    viewModel.password = "securePassword"
                    
                    // Expect empty password validation message
                    expect(viewModel.passwordValidation).toEventually(beEmpty())
                }
            }
            
            context("when both email and password are valid") {
                it("should enable the button") {
                    viewModel.email = "test@example.com"
                    viewModel.password = "securePassword1"
                    
                    // Expect the button to be enabled
                    expect(!viewModel.isButtonEnabled).toEventually(beTrue())
                }
            }
        }
    }
}
    
class MockFieldValidator: FieldValidationUseCase {
    func validatePassword(password: String) -> AnyPublisher<Void, Error> {
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func validateEmail(email: String) -> AnyPublisher<Void, Error> {
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func validateUsername(username: String) -> AnyPublisher<Void, Error> {
        return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
   
    }

}

// Create a mock UserLoginUseCase for testing
class MockUserLoginUseCase: UserLoginUseCase {
    func execute(email: String, password: String) -> AnyPublisher<User, LoginError> {
        return Fail(error: LoginError.emailDoesNotExist)
            .eraseToAnyPublisher()
  
    }
}
