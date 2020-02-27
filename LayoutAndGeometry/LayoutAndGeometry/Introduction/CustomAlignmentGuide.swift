//
//  CustomAlignmentGuide.swift
//  LayoutAndGeometry
//
//  Created by Kevin Ngo on 2020-02-25.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentGuide: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Text("@twostraws")
                .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("paul-hudson")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

struct CustomAlignmentGuide_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentGuide()
    }
}
