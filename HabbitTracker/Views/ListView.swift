//
//  CalenderView.swift
//  HabbitTracker
//
//  Created by Lina Bergsten on 2025-05-12.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    @State private var newHabitName: String = ""

    var body: some View {
        VStack {
            // Lista över vanor
            List {
                ForEach(firebaseManager.habits) { habit in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(habit.name)
                                .font(.headline)
                            Text("Streak: \(habit.streak)")
                                .font(.subheadline)
                        }

                        Spacer()

                        Button(action: {
                            firebaseManager.markHabitCompleted(habit)
                        }) {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }

            Divider()

            // Lägg till ny vana
            HStack {
                TextField("Ny vana", text: $newHabitName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    guard !newHabitName.isEmpty else { return }
                    firebaseManager.addHabit(name: newHabitName)
                    newHabitName = ""
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
}
#Preview {
    ContentView()
        .environmentObject(FirebaseManager()) // om du använder en EnvironmentObject
}
