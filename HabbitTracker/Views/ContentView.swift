//
//  ContentView.swift
//  HabbitTracker
//
//  Created by Lina Bergsten on 2025-05-12.
//
import FirebaseAuth
import Foundation
import SwiftUICore
import SwiftUI



struct ContentView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(firebaseManager.habits) { habit in
                    HStack {
                        Text(habit.name)
                        Spacer()
                        Text("\(habit.streak) dagar")
                        Button(action: {
                            let newStreak = habit.shouldResetStreak ? 1 : habit.streak + 1
                            firebaseManager.updateStreak(habitId: habit.id, newStreak: newStreak)
                        }) {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                }
            }
            .navigationTitle("Mina Vanor")
            .toolbar {
                Button(action: { showingAddHabit = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView()
            }
            .onAppear {
                firebaseManager.fetchHabits()
            }
        }
    }
}
