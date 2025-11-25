//
//  CardView.swift
//  blockapp
//
//  Created by Jan Osuský on 14.04.2025.
//

import SwiftUI

struct CardView: View {
    let task: Task
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(task.description ?? "...")", systemImage: "note.text.badge.plus")
                Spacer()
                Label("\(task.lengthInMinutes)", systemImage: "clock")
                    .labelStyle(.traillingIcon)
            }.font(.caption)
        }
        .padding()
        .foregroundStyle(task.theme.accentColor)
    }
}

#Preview(traits: .fixedLayout(width: 400, height: 60)) {
    let task = Task.sampleData[0]
    return CardView(task: task)
        .background(task.theme.mainColor)
}
