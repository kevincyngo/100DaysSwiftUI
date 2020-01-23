//
//  AddActivityView.swift
//  Habit Tracker
//
//  Created by Kevin Ngo on 2020-01-22.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var activities: Activities
    
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text:$title)
                TextField("Description",text:$description)
            }
        .navigationBarTitle("Add new activity")
        .navigationBarItems(trailing:
            Button("Submit") {
                let item = Activity(title: self.title, description: self.description)
                self.activities.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
        })
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
