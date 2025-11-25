//
//  TasksView.swift
//  blockapp
//
//  Created by Jan Osuský on 24.04.2025.
//

import SwiftUI

struct TasksView: View {
    
    let tasks: [Task]
    var body: some View {
        NavigationStack {
            List(tasks) { task in
                NavigationLink(destination: DetailTaskView(task: task)){
                    CardView(task: task)
                        
                }
                .listRowBackground(task.theme.mainColor)
            }
            .navigationTitle("Scheduled Tasks")
            .toolbar {
                Button(action:{}) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    TasksView(tasks: Task.sampleData)
}
