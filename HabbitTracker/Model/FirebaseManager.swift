//
//  FirebaseManager.swift
//  HabbitTracker
//
//  Created by Lina Bergsten on 2025-05-12.
//

import Firebase
import FirebaseFirestore
import Combine
import FirebaseAuth

class FirebaseManager: NSObject, ObservableObject {
    static let shared = FirebaseManager()
    
    let auth: Auth
    let firestore: Firestore
    @Published var habits: [Habit] = []
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        super.init()
    }
    
    // MARK: - Habit Methods
    func addHabit(name: String, completion: @escaping (Error?) -> Void) {
        let habit = ["name": name, "streak": 0, "lastCompleted": Timestamp()] as [String : Any]
        
        firestore.collection("habits").addDocument(data: habit) { error in
            if let error = error {
                completion(error)
            } else {
                self.fetchHabits()
                completion(nil)
            }
        }
    }
    
    func fetchHabits() {
        firestore.collection("habits").getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching habits: \(error.localizedDescription)")
                return
            }
            
            self.habits = snapshot?.documents.compactMap { doc in
                let data = doc.data()
                return Habit(
                    id: doc.documentID,
                    name: data["name"] as? String ?? "",
                    streak: data["streak"] as? Int ?? 0,
                    lastCompleted: (data["lastCompleted"] as? Timestamp)?.dateValue() ?? Date()
                )
            } ?? []
        }
    }
    
    func updateStreak(habitId: String, newStreak: Int) {
        firestore.collection("habits").document(habitId).updateData([
            "streak": newStreak,
            "lastCompleted": Timestamp()
        ]) { error in
            if let error = error {
                print("Error updating streak: \(error.localizedDescription)")
            } else {
                self.fetchHabits()
            }
        }
    }
}
