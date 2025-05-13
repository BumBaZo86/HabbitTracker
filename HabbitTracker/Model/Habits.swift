//
//  Habits.swift
//  HabbitTracker
//
//  Created by Lina Bergsten on 2025-05-12.
//

import Foundation
import FirebaseFirestore

struct Habit: Identifiable, Codable {
    @DocumentID var id: String?  // Firestore document ID
    var name: String
    var lastCompleted: Date?
    var streak: Int
    var datesCompleted: [Date]  // För att hålla koll på vilka datum vanan har genomförts

    // Initialiserare för Habit
    init(id: String? = nil, name: String, lastCompleted: Date? = nil, streak: Int = 0, datesCompleted: [Date] = []) {
        self.id = id
        self.name = name
        self.lastCompleted = lastCompleted
        self.streak = streak
        self.datesCompleted = datesCompleted
    }

    // Funktion för att uppdatera streak och hålla koll på dagens datum
    mutating func updateStreak() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        guard let last = lastCompleted else {
            // Första gången vanan markeras som klar
            lastCompleted = today
            streak = 1
            datesCompleted.append(today)  // Lägg till dagens datum
            return
        }

        let lastDay = calendar.startOfDay(for: last)
        let daysBetween = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0

        if daysBetween == 1 {
            // Nästa dag i rad
            streak += 1
            lastCompleted = today
            datesCompleted.append(today)  // Lägg till dagens datum
        } else if daysBetween > 1 {
            // Missat minst en dag, nollställ streak
            streak = 1
            lastCompleted = today
            datesCompleted.append(today)  // Lägg till dagens datum
        } else {
            // Samma dag eller bakåt i tiden – gör inget
        }
    }
}
