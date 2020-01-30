//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Kevin Ngo on 2020-01-29.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
    
}
