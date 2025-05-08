//
//  Item.swift
//  HabbitTracker
//
//  Created by Lina Bergsten on 2025-05-08.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
