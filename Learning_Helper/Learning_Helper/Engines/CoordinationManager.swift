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
    var defaultLanguage: Language?
    var defaultCategory: Category?
    var defaultTense: Tense?
    var navigationPathDictionary: NavigationPath
    
    init(activeTab: Int = 1,
         selectedWord: Word? = nil,
         defaultLanguage: Language? = nil,
         defaultCategory: Category? = nil,
         defaultTense: Tense? = nil,
         navigationPathDictionary: NavigationPath = NavigationPath()) {
        
        self.activeTab = activeTab
        self.selectedWord = selectedWord
        self.defaultLanguage = defaultLanguage
        self.defaultCategory = defaultCategory
        self.defaultTense = defaultTense
        self.navigationPathDictionary = navigationPathDictionary
    }
}
