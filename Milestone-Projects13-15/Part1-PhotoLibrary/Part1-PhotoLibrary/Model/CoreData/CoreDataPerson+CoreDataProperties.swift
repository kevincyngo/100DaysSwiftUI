//
//  CoreDataPerson+CoreDataProperties.swift
//  Part1-PhotoLibrary
//
//  Created by Kevin Ngo on 2020-02-18.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataPerson {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CoreDataPerson> {
        return NSFetchRequest<CoreDataPerson>(entityName: "CoreDataPerson")
    }

    
    

    @NSManaged public var id: UUID?
    @NSManaged public var imagePath: String?
    @NSManaged public var internalName: String?
    
    public var name: String {
        get {
            internalName ?? "Unknown name"
        }
        
        set {
            internalName = newValue
        }
    }

}
