//
//  CoreDataPersons.swift
//  Part1-PhotoLibrary
//
//  Created by Kevin Ngo on 2020-02-18.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import CoreData
import Foundation

class CoreDataPersons: ObservableObject {

    // maintain and keep in sync 2 arrays:
    // one with actual data from Core Data and one for publication
    private var items = [CoreDataPerson]() {
        didSet {
            saveContext()
        }
    }

    // Use add, update and remove functions for modification.
    @Published private(set) var all = [Person]()

    private var container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }

        loadSavedData()
    }

    func add(person: Person) {
        let cdPerson = CoreDataPerson(context: container.viewContext)
        cdPerson.id = person.id
        cdPerson.name = person.name
        cdPerson.imagePath = person.imagePath

        if let index = items.firstIndex(where: { $0.name > person.name }) {
            items.insert(cdPerson, at: index)
            all.insert(person, at: index)
        }
        else {
            items.append(cdPerson)
            all.append(person)
        }
    }

    func remove(persons: [Person]) {
        for (index, item) in items.enumerated() {
            for person in persons {
                if person.id == item.id {
                    all[index].deleteImage()
                    container.viewContext.delete(item)
                    items.remove(at: index)
                    all.remove(at: index)
                }
            }
        }
    }
    private func loadSavedData() {
        let request = CoreDataPerson.createFetchRequest()
        let sort = NSSortDescriptor(key: "internalName", ascending: true)
        request.sortDescriptors = [sort]

        do {
            items = try container.viewContext.fetch(request)

            // fill in "all" array
            for item in items {
                let person = buildPerson(cdPerson: item)
                all.append(person)
            }
        } catch {
            print("Fetch failed")
        }
    }

    private func buildPerson(cdPerson: CoreDataPerson) -> Person {
        let id = cdPerson.id ?? UUID()

        // in case there is corrupted data
        if cdPerson.id == nil {
            cdPerson.id = id
            saveContext()
        }

        let person = Person(id: id,
                            name: cdPerson.name,
                            imagePath: cdPerson.imagePath,
                            locationRecorded: cdPerson.locationRecorded,
                            latitude: cdPerson.latitude,
                            longitude: cdPerson.longitude)

        return person
    }

    private func buildCoreDataPerson(person: Person) -> CoreDataPerson {
        let cdPerson = CoreDataPerson(context: container.viewContext)
        cdPerson.id = person.id
        copyPersonAttributes(from: person, to: cdPerson)

        return cdPerson
    }

    private func copyPersonAttributes(from person: Person, to cdPerson: CoreDataPerson) {
        cdPerson.name = person.name
        cdPerson.imagePath = person.imagePath
        cdPerson.locationRecorded = person.locationRecorded
        cdPerson.latitude = person.latitude
        cdPerson.longitude = person.longitude
    }


    private func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }

    private func sort() {
        items.sort(by: { $0.name < $1.name } )
        all.sort(by: { $0.name < $1.name } )
    }
}
