//
//  Activity.swift
//  Habit Tracker
//
//  Created by Kevin Ngo on 2020-01-22.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    var comments: [String] = []
    
    var completed: Int = 0
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.title == rhs.title
    }
}
