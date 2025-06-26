//
//  CoordinationManager.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 23.06.2025.
//

import Foundation
import SwiftUI

@Observable
class CoordinationManager {
    var activeTab: Int
    var selectedWord: Word?
    var navigationPathDictionary: NavigationPath
    
    init(activeTab: Int = 1, selectedWord: Word? = nil, navigationPathDictionary: NavigationPath = NavigationPath()) {
        self.activeTab = activeTab
        self.selectedWord = selectedWord
        self.navigationPathDictionary = navigationPathDictionary
    }
}
