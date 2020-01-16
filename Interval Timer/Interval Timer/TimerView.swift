//
//  TimerView.swift
//  Interval Timer
//
//  Created by Kevin Ngo on 2020-01-10.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @State var timeRemaining = ""
let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
        var body: some View {
            
            VStack {
                    TextField("Enter time", text: $timeRemaining)
                    
                    
                    Text("\(timeRemaining)")
                        .onReceive(timer) { _ in
                            if let Int(self.timeRemaining) > 0 {
                                self.timeRemaining = String(Int(self.timeRemaining) - 1)
                            } else {
                                
                            }
                        }
                    .font(.title)
            }

            
            

        }
    }

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
