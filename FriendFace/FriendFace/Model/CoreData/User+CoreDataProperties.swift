//
//  User+CoreDataProperties.swift
//  FriendFace
//
//  Created by Kevin Ngo on 2020-02-02.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
//    @NSManaged public var isActive: Bool
    @NSManaged public var about: String?
//    @NSManaged public var tags: NSObject?
    @NSManaged public var friend: NSSet?

    public var wrappedName: String {
        name ?? "John Doe"
    }
    
    public var wrappedEmail: String {
        email ?? "John.Doe@gmail.com"
    }
    
    public var wrappedAddress: String {
        address ?? "123 Fake Street"
    }
    
    public var wrappedAbout: String {
        about ?? "I am a person"
    }
    
    public var friendsArray: [User] {
        let set = friend as? Set<User> ?? []
        
        return set.sorted {$0.wrappedName < $1.wrappedName}
    }
    
//    public var tagsArray: [String] {
//        let set = tags as? Set<String> ?? []
//
//        return set.sorted {$0 < $1}
//    }
    
}

// MARK: Generated accessors for friend
extension User {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: User)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: User)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}
