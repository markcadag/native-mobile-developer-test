//
//  RegistrationView.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/27/23.
//
import Foundation
import SwiftUI

struct RegistrationView: View {
    
    let layoutProperties: LayoutProperties
    
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                EntryField(placeHolder: "Enter UserName", layoutProperties: layoutProperties, field: $viewModel.username, value: $viewModel.usernameValidation)
                
                EntryField(placeHolder: "Enter Email Address", layoutProperties: layoutProperties, field: $viewModel.email, value: $viewModel.emailValidation)
                
                SecureEntryField(placeHolder: "Enter Password", layoutProperties: layoutProperties, field: $viewModel.password, value: $viewModel.passwordValidation)
                
                Text(viewModel.userExistenceValidation)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                
                Button("Register") {
                    viewModel.registerUser()
                }.padding()
                    .disabled(!viewModel.isButtonEnabled)
                    .background(viewModel.isButtonEnabled ? Color.blue : Color.gray)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: layoutProperties.dimensValues.medium))
                    .cornerRadius(10)
                
            }.onAppear() {
                viewModel.initViewModel()
            }
            .padding()
        }
    }
}
