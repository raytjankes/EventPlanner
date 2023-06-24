//
//  EDTSEventPlannerApp.swift
//  EDTSEventPlanner
//
//  Created by Ray on 23/06/23.
//

import SwiftUI
import FirebaseCore

@main
struct EDTSEventPlannerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(EventViewModel())
                .environmentObject(LanguageViewModel())
                .preferredColorScheme(.light) // Force light mode
                .environment(\.colorScheme, .light) // Optional: Set environment color scheme to light
                .onAppear {
                    // Optional: Override the user interface style at the app level
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                }
        }
    }
}
