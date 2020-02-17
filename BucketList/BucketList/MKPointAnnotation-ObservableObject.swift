//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Kevin Ngo on 2020-02-15.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import MapKit
//Use this b/c textfields cannot be optionals
//Used in EditView, updating this will update the title / subtitle properties
extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }
        
        set {
            subtitle = newValue
        }
    }
}
