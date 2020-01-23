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
    
    var activity: Activity
    
    @State private var completed: Int = 0
    @State private var comments: [String] = []
    @State private var comment: String = ""
    @State private var count = 0
    
    var body: some View {
            VStack {
                Form {
                    Section(header: Text("\(activity.description)")) {
                        Stepper("Completed times: \(completed)", value: $completed)
                        TextField("Comments...", text:$comment)
                        Button(action: {
                            self.addComment()
                        }) {
                            Text("Submit")
                        }
                    }
                }
                List {
                    ForEach(comments, id: \.self) {test in
                        Text(test)
                    }
                }
                Spacer()
                .navigationBarTitle(Text("\(activity.title)"), displayMode: .inline)
            }
            

            .onAppear {
                self.completed = self.activity.completed
//                self.comments = self.activity.comments
            }
            .onDisappear {
                if let index = self.activities.items.firstIndex(where: { $0 == self.activity }) {
                    self.activities.items.remove(at: index)
                    var tempActivity = self.activity
                    tempActivity.completed = self.completed
                    tempActivity.comments = self.comments
                    self.activities.items.insert(tempActivity, at: index)
                }
            }
            
        

    }
    
    func addComment() {
        self.comments.append("COMMENT")
        self.comment = ""
        self.count += 1
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView(activities: Activities(),
                               activity: Activity(title: "Title", description: "Description"))
        }
    }
}
