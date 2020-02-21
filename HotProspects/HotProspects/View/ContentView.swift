//
//  ContentView.swift
//  HotProspects
//
//  Created by Kevin Ngo on 2020-02-20.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI
import UserNotifications
import SamplePackage


struct ContentView: View {
    var prospects = Prospects()
    var body: some View {
        TabView {
            //show every person you've met
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            
            //show people you have contacted
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            
            //show people you haven't contacted
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }.environmentObject(prospects)

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
