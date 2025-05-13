//
//  HabbitTrackerApp.swift
//  HabbitTracker
//
//  Created by Lina Bergsten on 2025-05-12.
//

import SwiftUI
import FirebaseCore

@main
struct HabbitTrackerApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
#Preview {
    ContentView()
        .environmentObject(FirebaseManager()) // om du använder en EnvironmentObject
}
