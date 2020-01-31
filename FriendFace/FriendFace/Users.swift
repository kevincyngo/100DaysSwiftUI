//
//  Users.swift
//  FriendFace
//
//  Created by Kevin Ngo on 2020-01-30.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation


class Users: ObservableObject {
    @Published var users = [User]()
    
    init() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedUsers = try decoder.decode([User].self, from: data)
                
                //put the decoded users into self.user
                //do this on the mainthread b/c it directly effects the view
                DispatchQueue.main.async {
                    self.users = decodedUsers
                }
            } catch let error {
                print("error: \(error)")
            }
        }.resume()
    }
}
