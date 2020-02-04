//
//  ContentView.swift
//  FriendFace
//
//  Created by Kevin Ngo on 2020-01-30.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink(destination: DetailView(user: user)) {
                        VStack(alignment: .leading) {
                            Text(user.wrappedName)
                                .font(.headline)
                            Text(user.wrappedEmail)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }.navigationBarTitle("FriendFace")
        }.onAppear(perform: checkDataLoaded)
    }

    func checkDataLoaded() {
        if users.isEmpty {
            DataInitializer.loadData(moc: moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
