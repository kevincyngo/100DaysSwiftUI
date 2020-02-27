//
//  CoreDataRoll+CoreDataProperties.swift
//  DiceRoll
//
//  Created by Kevin Ngo on 2020-02-26.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataRoll {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CoreDataRoll> {
        return NSFetchRequest<CoreDataRoll>(entityName: "CoreDataRoll")
    }

    @NSManaged public var date: Date?
    @NSManaged public var dieSides: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var result: [Int16]?
    @NSManaged public var total: Int16

}
