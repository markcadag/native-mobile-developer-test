//
//  RegistrationView.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/27/23.
//
import Foundation
import SwiftUI
import Factory

struct RegistrationView: View {
    
    let layoutProperties: LayoutProperties
    
    @ObservedObject var viewModel: RegistrationViewModel
    let listingViewModel = Container.shared.listingViewModel()
    
    @EnvironmentObject var navigationPath: NavigationCoordinator
   
    var body: some View {
        GeometryReader { gp in
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
                }.onChange(of: viewModel.user) { oldValue, newValue in
                    guard let user = newValue else { return }
                    self.navigationPath.path.removeLast()
                    self.navigationPath.path.append(user)
                }.frame(maxWidth: .infinity, minHeight: gp.size.height)
                    .padding()
            }.navigationTitle("Registration")
              
        }
    }
}
