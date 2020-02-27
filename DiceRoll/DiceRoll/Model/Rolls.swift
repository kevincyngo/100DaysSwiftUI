//
//  Rolls.swift
//  DiceRoll
//
//  Created by Kevin Ngo on 2020-02-26.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

// ObservableObject as a protocol inspired from https://stackoverflow.com/a/57657870

/// History of rolls
///
/// Usage (not implementation) suggestion:
/// struct SomeView<GenericRolls>: View where GenericRolls: Rolls {
///     @ObservedObject var rolls: GenericRolls
/// }
protocol Rolls: ObservableObject {
    // cannot simply declare @Published var all: [Roll] { get }
    // because of the wrapped property. Use no wrapper but add
    // allPublished and allPublisher instead.

    /// Conformance suggestion: @Published private(set) var all = ...
    var all: [Roll] { get }

    /// Conformance suggestion: var allPublished: Published<[Roll]> { _all }
    var allPublished: Published<[Roll]> { get }

    /// Conformance suggestion: var allPublisher: Published<[Roll]>.Publisher { $all }
    var allPublisher: Published<[Roll]>.Publisher { get }

    /// Insert a roll at position 0
    func insert(roll: Roll)

    /// Remove all rolls
    func removeAll()
}
