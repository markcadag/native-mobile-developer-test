//
//  SecureEntryField.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import SwiftUI

struct SecureEntryField: View {
    var placeHolder: String
    var layoutProperties: LayoutProperties
    @Binding var field: String
    @Binding var value: String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            SecureField(placeHolder, text: $field)
                .font(.system(size: layoutProperties.customFontSize.medium))
            Divider()
            Text(value)
                .font(.system(size: layoutProperties.customFontSize.smallMedium))
               .foregroundColor(.red)
        }
    }
}
