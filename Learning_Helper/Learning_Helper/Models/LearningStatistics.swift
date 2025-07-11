//
//  LearningStatistics.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 24.06.2025.
//

import Foundation
import SwiftData

struct LearningStatistics {
    var wordFormID: UUID
    var counterTests: Int
    var counterSuccess: Int
    var progressIndicator: Double
    var lastTestDate: Date?
}
