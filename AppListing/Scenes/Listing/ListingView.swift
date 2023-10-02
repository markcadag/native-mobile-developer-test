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
        ZStack {
            List {
                ForEach(listingViewModel.dummyUsers, id: \.id) { user in
                    ListingRowView(dummyUser: user, layoutProperties: layoutProperties)
                }
                
                LoaderView(error: listingViewModel.error, layoutProperties: layoutProperties)
                    .onAppear(perform: {
                        listingViewModel.getUsers()
                    })
                    .onTapGesture(perform: {
                        listingViewModel.retryGetUser()
                    })
            }.scrollContentBackground(.hidden)
            .background(Color.clear)
            .sheet(isPresented: $listingViewModel.openCameraRoll) {
                VStack {
                    ImagePicker(completionHandler: { value in
                        listingViewModel.savePhoto(image: value)
                    }, sourceType: .camera)
                }.background(.black)
            }.alert(listingViewModel.message, isPresented: $listingViewModel.showAlertMessage) {
                Button("OK", role: .cancel) { }
            }.background(.clear)
                .navigationTitle("Dummy Users")
                .navigationBarTitleDisplayMode(.automatic)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        listingViewModel.openCameraRoll = true
                    }, label: {
                        ZStack {
                            Circle()
                                .frame(width: layoutProperties.dimensValues.extraLarge * 2.5, height: layoutProperties.dimensValues.extraLarge * 2.5)
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                            
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .frame(width: layoutProperties.dimensValues.extraLarge * 2.5, height: layoutProperties.dimensValues.extraLarge * 2.5) // Adjust the size as needed
                                .foregroundColor(.blue)
                        }
                        
                    }).padding(.trailing, layoutProperties.dimensValues.mediumLarge)
                        .padding(.bottom, layoutProperties.dimensValues.medium)
                }
            }
        }
    }
}

struct LoaderView: View {
    
    let error: String
    let layoutProperties: LayoutProperties
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            if(error.isEmpty) {
                ActivityIndicator()
                    .frame(width: layoutProperties.dimensValues.large * 2, height: layoutProperties.dimensValues.large * 2, alignment: .center)
                    .foregroundColor(.gray)
              
            } else {
                Text(error)
                    .foregroundColor(.gray)
                    .font(.system(size: layoutProperties.customFontSize.medium))
                    .padding()
            }
            Spacer()
        }

    }
}
