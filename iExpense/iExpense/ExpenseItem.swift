//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Kevin Ngo on 2020-01-20.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation


struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

