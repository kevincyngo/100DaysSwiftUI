//
//  JSONUser.swift
//  FriendFace
//
//  Created by Kevin Ngo on 2020-02-03.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

struct JSONUser: Codable, Identifiable {
    var id: String
    var name: String
    var age: Int
//    var company: String
    var email: String
    var address: String
    var about: String
    var friends: [JSONFriend]
}
