//
//  DetailTaskView.swift
//  blockapp
//
//  Created by Jan Osuský on 25.04.2025.
//

import SwiftUI

struct DetailTaskView: View {
    let task: Task
    
    var body: some View {
        List {
            Section(header: Text("Task Information")) {
                Label("Open Timer", systemImage: "timer")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                HStack {
                    Label("Length", systemImage: "clock" )
                    Spacer()
                    Text("\(task.lengthInMinutes) minutes")
                }
                HStack {
                    Label("Deadline", systemImage: "calendar.badge.exclamationmark")
                    Spacer()
                    Text("\(task.deadline.formatted())")
                }
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(task.theme.name)
                        .padding(4)
                        .foregroundColor(task.theme.accentColor)
                        .background(task.theme.mainColor)
                        .cornerRadius(4)
                }
                VStack(alignment: .leading) {
                        Label("Description:", systemImage: "text.quote")
                        Spacer()
                    
                        Text(task.description ?? "Add description")
                        .padding(.leading)
                        .padding(.bottom, 15)
                    
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailTaskView(task: Task.sampleData[0])
    }
}
