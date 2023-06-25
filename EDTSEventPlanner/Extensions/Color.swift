//
//  Color.swift
//  EDTSEventPlanner
//
//  Created by Ray on 24/06/23.
//

import SwiftUI


extension Color {
    
    static let customPrimary = Color(hex: "0xFFFFFF")
    static let customSecondary = Color(hex: "0x6D6E70")
    static let customBackground = Color(hex: "0x152852")
    static let customDarkBackground = Color(hex: "0x060D21")
    static let customButton = Color(hex: "0xE71D4D")
    static let customDisabledButton = Color(hex: "0x986B77")
    
    
    // Function to convert hexcode to Color
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
    
}
