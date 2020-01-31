//
//  ContentView.swift
//  FriendFace
//
//  Created by Kevin Ngo on 2020-01-30.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var users = Users()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users.users) { user in
                    NavigationLink(destination: UserDetailsView(user: user)) {
                        UserCellView(user: user)
                    }

                }
            }
        .navigationBarTitle(Text("FriendFace"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
