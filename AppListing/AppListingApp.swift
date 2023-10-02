//
//  AppListingApp.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/27/23.
//

import SwiftUI
import SwiftData
import Factory

@main
struct AppListingApp: App {
    
    let loginViewModel = Container.shared.loginViewModel()
    
    var body: some Scene {
        WindowGroup {
                NavigationStack {
                    ResponsiveView {properties in
                        LoginView(layoutProperties: properties, viewModel: self.loginViewModel)
                    }
                }
        }
    }
}
