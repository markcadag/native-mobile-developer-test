//
//  DTOConvertible.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 9/29/23.
//

import Foundation

protocol DomainConvertible {
    associatedtype DomainType
    
    func toDomain() -> DomainType
}
