//
//  Task+sample.swift
//  blockapp
//
//  Created by Jan Osuský on 14.04.2025.
//

import Foundation
import ThemeKit


extension Task {
    static let sampleData: [Task] =
    [
        Task(
            title: "Design",
             deadline: Calendar.current.date(from: DateComponents(year: 2025, month: 8, day: 22))!,
             lengthInMinutes: 120,
            theme: Theme.yellow
            
        ),
        Task( title: "App Dev",
                    deadline: Calendar.current.date(from: DateComponents(year: 2025, month: 8, day: 23))!,
                    lengthInMinutes: 50,
                    description: "iOS development planning",
                    theme: Theme.orange
                
                ),
                Task(
                    title: "Web Dev",
                    deadline: Calendar.current.date(from: DateComponents(year: 2025, month: 8, day: 24))!,
                    lengthInMinutes: 20,
                    description: "Frontend sprint sync",
                    theme: Theme.poppy
                )
    ]
}
