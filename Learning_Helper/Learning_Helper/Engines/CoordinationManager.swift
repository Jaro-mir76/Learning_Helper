//
//  CoordinationManager.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 23.06.2025.
//

import Foundation

@Observable
class CoordinationManager {
    var activeTab: Int
    
    init(activeTab: Int = 1) {
        self.activeTab = activeTab
    }
}
