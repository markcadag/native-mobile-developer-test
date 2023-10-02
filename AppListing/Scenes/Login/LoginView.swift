//
//  LoginView.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import SwiftUI
import Factory

struct LoginView: View {
    
    let layoutProperties: LayoutProperties
    let registrationViewModel = Container.shared.registrationViewModel()
    let listingViewModel = Container.shared.listingViewModel()
    
    @ObservedObject var viewModel: LoginViewModel
    
    @StateObject var navigation = NavigationCoordinator()

    var body: some View {
        GeometryReader { gp in
            NavigationStack(path: $navigation.path) {
                ScrollView {
                    VStack {
                        EntryField(placeHolder: "Enter Email Address", layoutProperties: layoutProperties, field: $viewModel.email, value: $viewModel.emailValidation)
                        
                        SecureEntryField(placeHolder: "Enter Password", layoutProperties: layoutProperties, field: $viewModel.password, value: $viewModel.passwordValidation)
                        
                        Text(viewModel.userExistenceValidation)
                            .font(.system(size: layoutProperties.customFontSize.medium))
                            .foregroundColor(.red)
                        
                        Button("Login") {
                            viewModel.loginUser()
                        }.disabled(!viewModel
                            .isButtonEnabled)
                        .padding()
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .background(viewModel.isButtonEnabled ? Color.blue : Color.gray)
                            .font(.system(size: layoutProperties.dimensValues.medium))
                            .cornerRadius(10)
                            .ignoresSafeArea(.keyboard)
                        
                        NavigationLink(value: AppRoute.registration) {
                            Text("Create an account")
                                .font(.system(size: layoutProperties.customFontSize.medium))
                                .foregroundColor(.blue)
                                .padding(.top, layoutProperties.dimensValues.medium)
                        }
                    }.onAppear() {
                        viewModel.initViewModel()
                    }.onChange(of: viewModel.user, { oldValue, newValue in
                        guard let user = newValue else { return }
                        navigation.path.append(user)
                    })
                    .frame(maxWidth: .infinity, minHeight: gp.size.height)
                    .navigationTitle("Login")
                    .navigationTitle("AppListing")
                    .navigationDestination(for: AppRoute.self, destination: { route in
                        switch route {
                        case .listView:
                            ListingView(listingViewModel: self.listingViewModel, user: self.viewModel.user!, layoutProperties: layoutProperties)
                                .environmentObject(navigation)
                        case .registration:
                            RegistrationView(layoutProperties: layoutProperties, viewModel: self.registrationViewModel)
                                .environmentObject(navigation)
                        }
                    })
                    .navigationDestination(for: User.self, destination: { value in
                        ListingView(listingViewModel: self.listingViewModel, user: value, layoutProperties: layoutProperties)
                            .environmentObject(navigation)
                    })
                    .padding()
                }
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(layoutProperties: getPreviewLayoutProperties(landscape: false, height: 844, width: 390), viewModel: Container.shared.loginViewModel())
            .previewDevice("iPhone 11")
    }
}
