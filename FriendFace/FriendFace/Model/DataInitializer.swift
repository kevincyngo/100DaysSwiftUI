//
//  DataInitializer.swift
//  FriendFace
//
//  Created by Kevin Ngo on 2020-02-03.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation
import CoreData

struct DataInitializer {
    static func loadData(moc: NSManagedObjectContext) {
        DispatchQueue.global().async {
            fetchData {users in
                DispatchQueue.main.async {
                    var tempUsers = [User]()
                    
                    for user in users {
                        let newUser = User(context: moc)
                        newUser.id = user.id
                        newUser.name = user.name
                        newUser.age = Int16(user.age)
                        newUser.email = user.email
                        newUser.address = user.address
                        newUser.about = user.about
//                        newUser.company = user.company
                        
                        tempUsers.append(newUser)
                    }
                    
                    for i in 0..<users.count {
                        for friend in users[i].friends {
                            if let newFriend = tempUsers.first(where: {$0.id == friend.id}) {
                                tempUsers[i].addToFriend(newFriend)
                            }
                        }
                    }
                    
                    do {
                        try moc.save()
                    }
                    catch let error {
                        print("Could not save data: \(error.localizedDescription)")
                    }
                    
                }
            }
        }
    }
    
    static func fetchData(completion: @escaping ([JSONUser]) -> ()) {
        print("Fetching data...")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("Invalid URL")
                return
        }

        let request = URLRequest(url: url)

        let session = URLSession.shared.dataTask(with: request) { data, _, sessionError in
            guard let data = data else {
                print("Fetch failed: \(sessionError?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decoded = try JSONDecoder().decode([JSONUser].self, from: data)

                completion(decoded)
            }
            catch let decodingError {
                print("Decoding failed: \(decodingError.localizedDescription)")
            }
        }
        session.resume()
    }
}
