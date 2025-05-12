//
//  AddHabitView.swift
//  HabbitTracker
//
//  Created by Lina Bergsten on 2025-05-12.
//

import StoreKit
import SwiftUICore
import CoreLocation
import AVFoundation
import Network
import GameController
import SwiftUI

struct AddHabitView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    @Environment(\.dismiss) var dismiss
    @State private var habitName = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Vana namn", text: $habitName)
            }
            .navigationTitle("Lägg till vana")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Spara") {
                        firebaseManager.addHabit(name: habitName) { _ in
                            dismiss()
                        }
                    }
                    .disabled(habitName.isEmpty)
                }
            }
        }
    }
}
