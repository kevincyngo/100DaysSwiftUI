//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Kevin Ngo on 2020-02-27.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var selectedFacility: Facility?
    @EnvironmentObject var favorites: Favorites

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                Text("Photo Credits: \(resort.imageCredit)")
                    .font(.caption)
                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailsView(resort: resort) }
                            VStack { SkiDetailsView(resort: resort) }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    // Text(resort.facilities.joined(separator: ", "))
//                    Text(ListFormatter.localizedString(byJoining: resort.facilities))
//                        .padding(.vertical)
//                        .padding(.vertical)
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if self.favorites.contains(self.resort) {
                    self.favorites.remove(self.resort)
                } else {
                    self.favorites.add(self.resort)
                }
            }
            .padding()
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
