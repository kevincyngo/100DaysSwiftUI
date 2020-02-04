//
//  DetailView.swift
//  FriendFace
//
//  Created by Kevin Ngo on 2020-02-03.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var user: User

    var body: some View {
        List {
            Section(header: Text("Name")) {
                Text(user.wrappedName)
            }
            Section(header: Text("Age")) {
                Text(String(user.age))
            }
            Section(header: Text("Email")) {
                Text(user.wrappedEmail)
            }
            Section(header: Text("Address")) {
                Text(user.wrappedAddress)
            }
            Section(header: Text("Friends")) {
                ForEach(user.friendsArray, id: \.id) { friend in
                    NavigationLink(destination: DetailView(user: friend)) {
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text(friend.wrappedName)
                                .font(.headline)
                            Text(friend.wrappedEmail)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("\(user.wrappedName)", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {

    static var john: User {
        let user = User()
        user.name = "John Smith"
        user.age = 54
        user.email = "john.smith@apple.com"
        user.address = "Cupertino"
        return user
    }

    static var previews: some View {
        DetailView(user: john)
    }
}
