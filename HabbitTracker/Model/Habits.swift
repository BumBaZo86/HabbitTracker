//
//  Habits.swift
//  HabbitTracker
//
//  Created by Lina Bergsten on 2025-05-12.
//

import FirebaseFirestore

struct Habit: Identifiable {
    var id: String
    var name: String
    var streak: Int
    var lastCompleted: Date
    
    var shouldResetStreak: Bool {
        let calendar = Calendar.current
        return !calendar.isDateInToday(lastCompleted) &&
               !calendar.isDateInYesterday(lastCompleted)
    }
}
