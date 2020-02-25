//
//  SupprtoingAccessibility.swift
//  Flashzilla
//
//  Created by Kevin Ngo on 2020-02-24.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
import SwiftUI
import UIKit
import CoreHaptics

//Reduce motion - apps should limit amount of animations that cause movement on screen
//For exaple, iOS app switcher makes views fade in and out rather than scale up and down
struct SupprtingAccessibility: View {
    @State private var scale: CGFloat = 1
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
    var body: some View {
        
        
        
        Text("Hello, World!")
            .scaleEffect(scale)
            .onTapGesture {
                self.withOptionalAnimation {
                    self.scale *= 1.5
                }
            }
    }
}

struct SupprtingAccessibility_Previews: PreviewProvider {
    static var previews: some View {
        SupprtingAccessibility()
    }
}
