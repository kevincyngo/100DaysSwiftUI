//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Kevin Ngo on 2020-01-22.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activities = Activities()
    
    @State private var showingAddActivity = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    NavigationLink(destination: DetailsView(activities: self.activities, activity: item)) {
                        HStack{
                            VStack{
                                Text(item.title)
                                    .font(.headline)
                                Text(item.description)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("\(item.completed)")
                            
                        }


                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Activities")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showingAddActivity = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                    }
            )
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(activities: self.activities)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
