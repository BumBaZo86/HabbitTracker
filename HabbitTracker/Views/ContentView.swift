//
//  ContentView.swift
//  HabbitTracker
//
//  Created by Lina Bergsten on 2025-05-12.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: FirebaseManager

    var body: some View {
        NavigationStack {
            ListView()
                .navigationTitle("Mina Vanor")
        }
    }
}
#Preview {
    ContentView()
        .environmentObject(FirebaseManager()) // om du använder en EnvironmentObject
}
