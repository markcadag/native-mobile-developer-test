//
//  NavigationCoordinator.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/2/23.
//

import Foundation
import SwiftUI

enum AppRoute : String , Hashable {
    case registration
    case listView
}

class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()
}
