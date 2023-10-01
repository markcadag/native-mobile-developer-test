//
//  Listing.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//
import Foundation
import SwiftUI
import Kingfisher

struct ListingView: View {
    
    @ObservedObject var listingViewModel: ListingViewModel
    var layoutProperties: LayoutProperties
    
    var body: some View {
        List {
            ForEach(listingViewModel.dummyUsers, id: \.id) { user in
                ListingRowView(dummyUser: user, layoutProperties: layoutProperties)
            }
            
            LoaderView(error: listingViewModel.error)
                .onAppear(perform: {
                    listingViewModel.getUsers()
                })
                .onTapGesture(perform: {
                    listingViewModel.retryGetUser()
                })
        }
        .navigationTitle("Dummy Users")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct LoaderView: View {
    
    let error: String
    
    var body: some View {
        
        Text(error.isEmpty ? "Loading.." : "Failed. Tap to retry." )
            .foregroundColor(error.isEmpty ? .green : .red )
            .padding()
    }
}

struct ListingRowView: View {
    let dummyUser: DummyUser
    
    var layoutProperties: LayoutProperties
    
    var body: some View {
        HStack (spacing: layoutProperties.dimensValues.medium) {
            
            let processor = RoundCornerImageProcessor(cornerRadius: layoutProperties.dimensValues.mediumLarge)
            
            KFImage.url(URL(string: dummyUser.picture)!)
                     .setProcessor(processor)
                     .loadDiskFileSynchronously()
                     .cacheMemoryOnly()
                     .fade(duration: 0.25)
                     .resizable()
                     .frame(width: layoutProperties.dimensValues.large * 4, height: layoutProperties.dimensValues.large * 4)
            
            Text("\(dummyUser.firstName) \(dummyUser.lastName)")
                .font(.system(size: layoutProperties.dimensValues.medium))
        }
        .padding(4)
    }
}
