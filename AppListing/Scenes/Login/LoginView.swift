//
//  LoginView.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    let layoutProperties: LayoutProperties
    
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        GeometryReader { gp in
            NavigationStack {
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
                        
                        NavigationLink(value: 2) {
                            Text("Create an account")
                                .font(.system(size: layoutProperties.customFontSize.medium))
                                .foregroundColor(.blue)
                                .padding(.top, layoutProperties.dimensValues.medium)
                        }
                    }.onAppear() {
                        viewModel.initViewModel()
                    }.frame(maxWidth: .infinity, minHeight: gp.size.height)
                }
                .navigationTitle("Login")
                .navigationTitle("AppListing")
                .navigationDestination(for: Int.self, destination: { value in
                    RegistrationView(layoutProperties: layoutProperties)
                })
                .navigationDestination(for: User.self, destination: { value in
                    
                    lazy var viewModel: ListingViewModel = {
                        let apiManager = APIManager<UserAPIResponse>()
                        let dataSource = APIDatasource(apiManager: apiManager)
                        let userRepository  = UserRepositoryAPIImpl(userDataSource: dataSource)
                        let listDummyUseCase = ListDummyUserUseCaseInteractor(userRepository: userRepository)
                        return ListingViewModel(listDummyUseCase: listDummyUseCase)
                    }()
                    
                    ListingView(listingViewModel: viewModel, user: value, layoutProperties: layoutProperties)
                })
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        
        lazy var viewModel: LoginViewModel = {
            let keyChainManager = KeychainManager(service: "com.example.myApp")
            let dataSource = SecureStorageDatasource(keychainManager: keyChainManager)
            let userRepo = UserRepositoryImpl(userDataSource: dataSource)
            let validator = FieldValidator(userRepository: userRepo)
            let userLoginUseCase  = UserLoginUseCaseInteractor(userRepository: userRepo)
            return LoginViewModel(fieldValidator: validator, userLoginUseCase: userLoginUseCase)
        }()
        
        LoginView(layoutProperties: getPreviewLayoutProperties(landscape: false, height: 844, width: 390), viewModel: viewModel)
            .previewDevice("iPhone 11")
    }
}
