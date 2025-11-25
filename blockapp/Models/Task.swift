//
//  Task.swift
//  blockapp
//
//  Created by Jan Osuský on 14.04.2025.
//

import Foundation
import ThemeKit
import FamilyControls


struct Task: Identifiable {
    var id: UUID
    var title: String
    var deadline: Date
    var schedule: Date? // Assigned by Task Scheduler
    var lengthInMinutes: Int
    var description: String?
    var theme: Theme
    var isCompleted: Bool = false
    
    
    init(id: UUID = UUID(), title: String, deadline: Date, lengthInMinutes: Int, description: String? = nil, theme: Theme) //TODO: will have to be changed for actuall blocked apps
    {
        self.id = id
        self.title = title
        self.deadline = deadline
        self.lengthInMinutes = lengthInMinutes
        self.description = description
        self.theme = theme
    }
}
