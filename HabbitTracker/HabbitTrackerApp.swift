//
//  HabbitTrackerApp.swift
//  HabbitTracker
//
//  Created by Lina Bergsten on 2025-05-12.
//

import SwiftUI
import FirebaseCore

@main
struct HabitTrackerApp: App {
    init() {
        FirebaseApp.configure()  // Firebase-init här
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
