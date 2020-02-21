//
//  Prospect.swift
//  HotProspects
//
//  Created by Kevin Ngo on 2020-02-20.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    
    //fileprivate - means this property can only be used by code inside of the current file
    //fileprivate(set) - means this property can be read from anywhere, but only written from the current file
    //this makes this property safer and can only be set by this file (i.e. by toggle() function)
    fileprivate(set) var isContacted = false

}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"
    init() {
        // Challenge 2
        self.people = []
        if let data = loadFile() {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                self.people = decoded
//                return
//            }
//        }
//
//        self.people = []
    }
    
    // Challenge 2
    func loadFile() -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(Self.saveKey)
        
        if let data = try? Data(contentsOf: url) {
            return data
        }
        
        return nil
    }
    
    // Challenge 2
    func saveFile(data: Data) {
        let url = getDocumentDirectory().appendingPathComponent(Self.saveKey)
        
        do {
            try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
        }
        catch let error {
            print("Could not write data: " + error.localizedDescription)
        }
    }
    
    // Challenge 2
    private func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
            // Challenge 2
            saveFile(data: encoded)
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
}
