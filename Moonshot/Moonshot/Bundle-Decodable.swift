//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Kevin Ngo on 2020-01-20.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

extension Bundle {
//    func decode(_ file: String) -> [Astronaut] {
//        //tries to locate the file in bundle, otherwise throw error
//        guard let url = self.url(forResource: file, withExtension: nil) else {
//            fatalError("Failed to locate \(file) in bundle.")
//        }
//
//        //tries to get contents of url, otherwise throw error
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to load \(file) from bundle.")
//        }
//
//        let decoder = JSONDecoder()
//
//        //tries to decode array of Astronautµ from data
//        guard let loaded = try? decoder.decode([Astronaut].self, from: data) else {
//            fatalError("Failed to decode \(file) from bundle.")
//        }
//
//        return loaded
//    }
    
    
    // load missions.json into array of mission structs using generics
    // Generics allow us to write code that is capable of working with a variety
    // of different types. In this project we wrote the Bundle extension to work with
    // arrays of astronauts, but really we want to be able to handle arrays of
    // any type.
    // To make methods generic, we give it a placeholder for certain types, using < >
    // So instead of using Astronaut, we use the generic T
    
    // Be careful. Remember that T is a palceholder for WHATEVER type we ask for
    // If we say "decode an array of astronauts" then T becomes [Astronaut]
    // So [T] becomes [[Astronaut]]
    
    // func decode<T>(_ file: String) -> T produces an error
    // because it does not know if type T will conform to codable
    // Thus, we fix this with a constraint <T: Codable>
    // That is, T can be anything as long as it conforms to Codable
    
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        //tries to get contents of url, otherwise throw error
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        //decoding date
        //Below tells decoder to parse dates in the exact format we expect.
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        //tries to decode array of Astronautµ from data
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }

}
