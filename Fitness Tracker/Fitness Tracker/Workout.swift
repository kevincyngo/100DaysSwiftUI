//
//  Workout.swift
//  Fitness Tracker
//
//  Created by Kevin Ngo on 2020-01-21.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

struct Workout: Identifiable {
    let id = UUID()
    var name: String
//    var exercises: [Exercise]
}

struct Exercise {
    var name: String
    var sets: Int
    var reps: Int
}
