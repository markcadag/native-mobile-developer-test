//
//  Item.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/27/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
