//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Kevin Ngo on 2020-01-29.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

enum Predicate: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
}

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    var sortingOptions: [NSSortDescriptor] = [
        NSSortDescriptor(keyPath: \Singer.firstName, ascending: true),
        NSSortDescriptor(keyPath: \Singer.lastName, ascending: true)
    ]
    
    
    init(filter: String, predicate: Predicate) {
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: sortingOptions, predicate: NSPredicate(format: "lastName \(predicate) %@", filter))
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(filter: "A", predicate: Predicate.contains)
    }
}
