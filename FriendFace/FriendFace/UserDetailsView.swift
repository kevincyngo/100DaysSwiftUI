//
//  UserDetailsView.swift
//  FriendFace
//
//  Created by Kevin Ngo on 2020-01-30.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct UserDetailsView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Section(header: Text("User information").font(.title)) {
                    Text("Name: \(user.name)")
                        .padding(.leading)
                    Text("Age: \(user.age)")
                        .padding(.leading)
                    Text("Email: \(user.email)")
                        .padding(.leading)
                    Text("Company: \(user.company)")
                        .padding(.leading)
                    Text("Address: \(user.address)")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading)
                    Text("Registered date: \(user.formattedRegisteredDate)")
                        .padding(.leading)
                }
                
                Section(header: Text("Tags").font(.title).padding(.top)) {
                    Text("\(getTags())")
                        .padding(.leading)
                        .padding(.trailing)
                }
                
                Section(header: Text("Friends").font(.title).padding(.top)) {
                    ForEach(user.friends) {friend in
                        Text("\(friend.name)")
                            .padding(.leading)
                    }
                    
                }
                
                
            }
            Spacer()
        }
        
        
        //        Spacer()
    }
    
    func getTags() -> String {
        return self.user.tags.joined(separator: ", ")
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(user: User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.", registered: Date(), tags: ["one", "two", "three"], friends: [Friend(id: "", name: "asd"), Friend(id: "", name: "asd")]))
    }
}
