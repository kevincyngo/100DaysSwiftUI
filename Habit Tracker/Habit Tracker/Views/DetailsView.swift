//
//  DetailsView.swift
//  Habit Tracker
//
//  Created by Kevin Ngo on 2020-01-22.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var activities: Activities
    
    @State var activity: Activity
    
    @State var comments: [String]
    @State private var comment: String = ""
    
    var body: some View {
            VStack {
                Form {
                    Section(header: Text("\(activity.description)")) {
                        TextField("Comments...", text:$comment)
                        Button(action: {
                            self.comments.append(self.comment)
                            self.comment = ""
                        }) {
                            Text("Submit")
                        }
                    }
                    List {
                        ForEach(comments, id: \.self) {test in
                            Text(test)
                        }
                    }
                    Spacer()
                }

                Spacer()
                .navigationBarTitle(Text("\(activity.title)"), displayMode: .inline)
            }
            .onDisappear {
                if let index = self.activities.items.firstIndex(where: { $0 == self.activity }) {
                    self.activities.items.remove(at: index)
                    var tempActivity = self.activity
                    tempActivity.comments = self.comments
                    self.activities.items.insert(tempActivity, at: index)
                }
            }
            
        

    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView(activities: Activities(),
                               activity: Activity(title: "Title", description: "Description"),
                               comments: [])
        }
    }
}
