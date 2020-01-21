//
//  ContentView.swift
//  iExpense
//
//  Created by Kevin Ngo on 2020-01-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    struct StyledAmount: ViewModifier {
        let amount: Int
        
        func body(content: Content) -> some View {
            return content
                        .foregroundColor(getColor())
                        .font(getFont())
        }
        
        func getColor() -> Color {
            if amount < 10 {
                return Color.green
            } else {
                return Color.red
            }
        }
        
        func getFont() -> Font {
            if amount < 10 {
                return Font.subheadline
            } else {
                return Font.title
            }
        }
    }
    
        var body: some View {
            NavigationView {
                List {
                    ForEach(expenses.items) {item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text("$\(item.amount)")
                                .modifier(StyledAmount(amount: item.amount))
                        }
                        
                    }
                    .onDelete(perform: removeItems)
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
                }
            .navigationBarTitle("iExpense")
                .navigationBarItems(trailing:
                    HStack {
                        Button(action: {
                            self.showingAddExpense = true
                        }) {
                            Image(systemName: "plus")
                        }
                        
                        EditButton()
                    }
                    
                    
                    
                )
            }
            

        }
    
    func removeItems (at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
