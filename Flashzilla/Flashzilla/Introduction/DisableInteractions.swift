//
//  DisableInteractions.swift
//  Flashzilla
//
//  Created by Kevin Ngo on 2020-02-23.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI
import UIKit
import CoreHaptics

struct DisableInteractions: View {
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
            }
            
            Circle()
            .fill(Color.red)
            .frame(width: 300, height: 300)
            .contentShape(Rectangle())
            .onTapGesture {
                print("Circle tapped!")
            }
        }
        
        
    }
}


struct DisableInteractions_Previews: PreviewProvider {
    static var previews: some View {
        DisableInteractions()
    }
}
