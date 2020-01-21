//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Kevin Ngo on 2020-01-20.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

extension Bundle {
    func decode(_ file: String) -> [Astronaut] {
        //tries to locate the file in bundle, otherwise throw error
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        //tries to get contents of url, otherwise throw error
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        //tries to decode array of Astronaut from data
        guard let loaded = try? decoder.decode([Astronaut].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
