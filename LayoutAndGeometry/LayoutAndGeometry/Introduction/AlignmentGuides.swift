//
//  AlignmentGuides.swift
//  LayoutAndGeometry
//
//  Created by Kevin Ngo on 2020-02-25.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct AlignmentGuides: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
            }
        }
        .background(Color.red)
        .frame(width: 400, height: 400)
        .background(Color.blue)
    }
}

struct AlignmentGuides_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentGuides()
    }
}
