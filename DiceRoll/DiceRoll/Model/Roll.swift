//
//  Roll.swift
//  DiceRoll
//
//  Created by Kevin Ngo on 2020-02-26.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

/// A roll and its result
struct Roll: Identifiable {
    var id = UUID()

    /// Number of sides of each die
    var dieSides: Int

    /// Result or the roll, as an array of side values
    var result: [Int]

    /// Sum of the roll
    var total: Int
}
