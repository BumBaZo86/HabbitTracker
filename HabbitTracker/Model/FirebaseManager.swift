//
//  FirebaseManager.swift
//  HabbitTracker
//
//  Created by Lina Bergsten on 2025-05-12.
//

import FirebaseFirestore
import Foundation

class FirebaseManager: ObservableObject {
    private let db = Firestore.firestore()
    @Published var habits: [Habit] = []

    init() {
        fetchHabits()
    }

    func fetchHabits() {
        db.collection("habits").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Fel vid hämtning av vanor: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else { return }

            self.habits = documents.compactMap { doc in
                try? doc.data(as: Habit.self)
            }
        }
    }

    func addHabit(name: String) {
        let habit = Habit(name: name, lastCompleted: nil, streak: 0)

        do {
            _ = try db.collection("habits").addDocument(from: habit)
        } catch {
            print("Fel vid sparande av vana: \(error.localizedDescription)")
        }
    }

    func markHabitCompleted(_ habit: Habit) {
        guard let id = habit.id else { return }

        var updatedHabit = habit
        updatedHabit.updateStreak()

        do {
            try db.collection("habits").document(id).setData(from: updatedHabit)
        } catch {
            print("Fel vid uppdatering av vana: \(error.localizedDescription)")
        }
    }
}
