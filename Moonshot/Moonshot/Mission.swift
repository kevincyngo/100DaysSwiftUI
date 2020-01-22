//
//  Mission.swift
//  Moonshot
//
//  Created by Kevin Ngo on 2020-01-20.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

//nested struct - which is one struct placed inside of another
//easier to understand b/c we call crew role as: Mission.CrewRole
struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var formattedCrewMembers: String {
        
        var list = [String]()
        
        for member in crew {
            list.append(member.name.capitalized)
        }
        
        return list.joined(separator: ", ")
    }
    
    
}



