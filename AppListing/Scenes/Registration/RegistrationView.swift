//
//  RegistrationView.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/27/23.
//
import Foundation
import SwiftUI

struct RegistrationView: View {
    
    @ObservedObject private var viewModel: RegistrationViewModel = {
        let keyChainManager = KeychainManager(service: "com.example.myApp")
        let dataSource = SecureStorageDatasource(keychainManager: keyChainManager)
        let userRepo = UserRepositoryImpl(userDataSource: dataSource)
        let validator = RegistrationValidator(userRepository: userRepo)
        let userRegUseCase  = UserRegistrationInteractor(userRepository: userRepo)
        return RegistrationViewModel(registrationValidator: validator, registrationUseCase: userRegUseCase)
    }()
    
    var body: some View {
        VStack {
                
            EntryField(placeHolder: "Enter UserName", field: $viewModel.username, value: $viewModel.usernameValidation)
            
            EntryField(placeHolder: "Enter Email Address", field: $viewModel.email, value: $viewModel.emailValidation)
            
            SecureEntryField(placeHolder: "Enter Password", field: $viewModel.password, value: $viewModel.passwordValidation)
            
            Text(viewModel.userExistenceValidation)
                .font(.system(size: 12))
                .foregroundColor(.red)
            
            Button("Register") {
                    viewModel.registerUser()
                }.padding()
                .background(Color.blue)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.system(size: 14))
                .cornerRadius(10)
            
        }.onAppear() {
            viewModel.initViewModel()
        }
        .padding()
    }
}

struct EntryField: View {
    var placeHolder: String
    
    @Binding var field: String
    @Binding var value: String
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeHolder, text: $field).autocapitalization(.none)
                           .font(.system(size: 14))
            Divider()
            Text(value)
               .font(.system(size: 12))
               .foregroundColor(.red)
        }
    }
}

struct SecureEntryField: View {
    var placeHolder: String
    
    @Binding var field: String
    @Binding var value: String
    var body: some View {
        VStack(alignment: .leading) {
            SecureField(placeHolder, text: $field)
                           .font(.system(size: 14))
            Divider()
            Text(value)
               .font(.system(size: 12))
               .foregroundColor(.red)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}


