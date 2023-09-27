//
//  LoginView.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/27/23.
//
import Foundation
import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("your_logo") // Replace "your_logo" with your logo image name
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 30)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15) // Make the TextField rounded
                    .padding(.horizontal, 20)
                
                TextField("Email", text: $username)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15) // Make the TextField rounded
                    .padding(.horizontal, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15) // Make the TextField rounded
                    .padding(.horizontal, 20)
                
                Button(action: {
                    // Add your login logic here
                    // You can perform authentication and navigate to the next screen upon successful login
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                
                Spacer()
                
                NavigationLink(destination: RegistrationView()) {
                                    Text("Create an Account")
                                        .foregroundColor(.blue)
                                        .padding(.bottom, 20)
                                }
            }
            .navigationBarTitle("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
