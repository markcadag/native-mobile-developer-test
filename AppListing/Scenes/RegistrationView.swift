//
//  RegistrationView.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/27/23.
//
import Foundation
import SwiftUI

struct RegistrationView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("Username", text: $firstName)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .padding(.horizontal, 20)
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .padding(.horizontal, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .padding(.horizontal, 20)
            
            Button(action: {
                // Add your registration logic here
                // You can create a new user account using the provided information
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .navigationBarTitle("Registration")
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
