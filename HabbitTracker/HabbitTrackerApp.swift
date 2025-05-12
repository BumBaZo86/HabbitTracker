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
    @StateObject private var firebaseManager = FirebaseManager.shared
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firebaseManager)
        }
    }
}
