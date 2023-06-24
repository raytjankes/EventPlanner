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
                .environmentObject(AuthViewModel())
                // Force light mode
                .preferredColorScheme(.light)
                .environment(\.colorScheme, .light)
                .onAppear {
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                }
        }
    }
}
