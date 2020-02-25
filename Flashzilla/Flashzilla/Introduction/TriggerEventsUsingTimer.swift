//
//  TriggerEventsUsingTimer.swift
//  Flashzilla
//
//  Created by Kevin Ngo on 2020-02-24.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
import SwiftUI
import UIKit
import CoreHaptics

struct TriggerEventsUsingTimer: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    @State private var counter = 0
    
    var body: some View {
      Text("H")
        .onReceive(timer) {time in
            if self.counter == 5 {
                self.timer.upstream.connect().cancel()
            } else {
                print("The time is now \(time)")
            }
            
            self.counter += 1
        }
    }
}


struct TriggerEventsUsingTimer_Previews: PreviewProvider {
    static var previews: some View {
        TriggerEventsUsingTimer()
    }
}
