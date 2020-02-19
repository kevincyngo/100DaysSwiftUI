//
//  DetailView.swift
//  Part1-PhotoLibrary
//
//  Created by Kevin Ngo on 2020-02-18.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var person: Person
    
    var body: some View {
        getImage(for: person)
            .resizable()
            .scaledToFit()
            .foregroundColor(Color.gray)
            .navigationBarTitle(Text(person.name), displayMode: .inline)
    }
    
    func getImage(for person: Person) -> Image {
        if let imageData = person.getImage() {
            if let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
        }
        return Image(systemName: "person.crop.square")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: Person(name: "TIM COOK"))
    }
}
