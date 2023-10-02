//
//  Configuration.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation

class ConfigurationManager {
    static func getValue<T>(forKey key: String) -> T? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? T
    }
}
