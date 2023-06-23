//
//  Event.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import Foundation
import SwiftUI

struct Event: Identifiable {
    let id: Int
    let name: String
    let location: String
    let details: String
    let organizer: String
    let date: Date
    let imageName: String? // Optional image variable
    
    var image: Image? {
        guard let imageName = imageName else {
            return nil
        }
        return Image(imageName)
    }
}
