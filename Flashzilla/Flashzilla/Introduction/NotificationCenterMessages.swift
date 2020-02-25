//
//  NotificationCenter.swift
//  Flashzilla
//
//  Created by Kevin Ngo on 2020-02-24.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI
import UIKit
import CoreHaptics

struct NotificationCenterMessages: View {

    
    var body: some View {
        Text("Hello, World!")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                print("Moving to the background!")
        }
    }
}


struct NotificationCenterMessages_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCenterMessages()
    }
}
