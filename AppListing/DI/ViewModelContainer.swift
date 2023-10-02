//
//  ViewModelContainer.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/2/23.
//

import Foundation
import Factory

/**
 Bootstrap Shared Resource
 */

extension Container {
    var keyChainManager: Factory<KeychainManager> {
        Factory(self) { KeychainManager(service: "com.markcadag.Applisting") }
    }
    var secureDataSource: Factory<UserDataSource> {
        Factory(self) { SecureStorageDatasource(keychainManager: self.keyChainManager()) }
    }
    
    var userLocalRepo: Factory<UserRepository> {
        Factory(self) { UserRepositoryImpl(userDataSource: self.secureDataSource()) }
    }
    
    var fieldValidatorUseCase: Factory<FieldValidationUseCase> {
        Factory(self) { FieldValidator(userRepository: self.userLocalRepo()) }
    }
    
}


/**
 Bootstrap RegistrationViewModel
 */


extension Container {

    var userLoginUseCase: Factory<UserLoginUseCase> {
        Factory(self) { UserLoginUseCaseInteractor(userRepository: self.userLocalRepo()) }
    }
    
    var loginViewModel: Factory<LoginViewModel> {
        Factory(self) { LoginViewModel(fieldValidator: self.fieldValidatorUseCase(), userLoginUseCase: self.userLoginUseCase()) }
    }
}
/**
 Bootstrap RegistrationViewModel
 */
extension Container {
    var userRegistraitonUseCase: Factory<UserRegistrationUseCase> {
        Factory(self) { UserRegistrationInteractor(userRepository: self.userLocalRepo()) }
    }
    
    var registrationViewModel: Factory<RegistrationViewModel> {
        Factory(self) {
            RegistrationViewModel(registrationValidator: self.fieldValidatorUseCase(), registrationUseCase: self.userRegistraitonUseCase())
        }
    }
}

/**
 Bootstrap ListingViewModel
 */
extension Container {
    var apiMangerUserAPI: Factory<APIManager<UserAPIResponse>> {
        Factory(self) {
            APIManager<UserAPIResponse>()
        }
    }
    
    var apiDataSource: Factory<APIDatasource> {
        Factory(self) {
            APIDatasource(apiManager: self.apiMangerUserAPI())
        }
    }
    
    var apiUserRepo: Factory<UserAPIRepository> {
        Factory(self) {
            UserRepositoryAPIImpl(userDataSource: self.apiDataSource())
        }
    }
    
    var useCaseListDummyUsers: Factory<ListDummyUserUseCase> {
        Factory(self) {
            ListDummyUserUseCaseInteractor(userRepository: self.apiUserRepo())
        }
    }
    
    var listingViewModel: Factory<ListingViewModel> {
        Factory(self) {
            ListingViewModel(listDummyUseCase: self.useCaseListDummyUsers() )
        }
    }
    
}
