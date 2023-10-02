//
//  ListingRow.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/2/23.
//

import Foundation
import SwiftUI
import Kingfisher

struct ListingRowView: View {
    let dummyUser: DummyUser
    
    var layoutProperties: LayoutProperties
    
    var body: some View {
        HStack (spacing: layoutProperties.dimensValues.medium) {
            
            let processor = RoundCornerImageProcessor(cornerRadius: layoutProperties.dimensValues.mediumLarge)
            
            KFImage.url(URL(string: dummyUser.picture))
                     .setProcessor(processor)
                     .loadDiskFileSynchronously()
                     .cacheMemoryOnly()
                     .fade(duration: 0.25)
                     .resizable()
                     .frame(width: layoutProperties.dimensValues.large * 4, height: layoutProperties.dimensValues.large * 4)
            
            VStack(alignment: .leading, spacing: layoutProperties.dimensValues.small) {
                Text("\(dummyUser.firstName) \(dummyUser.lastName)")
                    .font(.system(size: layoutProperties.customFontSize.medium))
                Text("ID: \(dummyUser.id)")
                    .foregroundStyle(.gray)
                    .font(.system(size: layoutProperties.customFontSize.smallMedium))
            }
        }
        .padding(4)
    }
}
