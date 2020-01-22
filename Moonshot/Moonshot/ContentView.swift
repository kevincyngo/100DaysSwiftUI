//
//  ContentView.swift
//  Moonshot
//
//  Created by Kevin Ngo on 2020-01-20.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var isShowingDate = true
    
    var body: some View {
        NavigationView {
            List(missions) {mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        
                        //button to toggle this
                        if self.isShowingDate {
                            Text(mission.formattedLaunchDate)
                                .font(.subheadline)
                        } else {
                            Text(mission.formattedCrewMembers)
                                .font(.subheadline)
                        }
                        
                    }
                }
            }
        .navigationBarItems(trailing:
            Button(isShowingDate ? "Crew Names" : "Launch Dates") {
                self.isShowingDate.toggle()
            }
            .accessibility(hidden: true)
            
        )
        .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
