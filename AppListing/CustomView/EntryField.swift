//
//  EntryField.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import SwiftUI

struct EntryField: View {
    var placeHolder: String
    var layoutProperties: LayoutProperties
    
    @Binding var field: String
    @Binding var value: String
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeHolder, text: $field).autocapitalization(.none)
                .autocorrectionDisabled()
                .font(.system(size: layoutProperties.customFontSize.medium))
            
            Divider()
            Text(value)
                .font(.system(size: layoutProperties.customFontSize.smallMedium))
               .foregroundColor(.red)
        }
    }
}
