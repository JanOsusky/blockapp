//
//  ContentView.swift
//  blockapp
//
//  Created by Jan Osuský on 12.04.2025.
//

import SwiftUI
// 
struct ActivityTimerView: View {
    var body: some View {
        VStack {
            ProgressView(value: 5, total:  15)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.bottomhalf.fill")
                }
            }
            Circle()
                .strokeBorder(lineWidth: 25)
            HStack {
                Button(action: {}) {
                    
                    VStack {
                        Image(systemName: "checkmark.circle")
                        Text("Task Finished")
                    }
                }
                .buttonStyle(.bordered)
                
                Button(action: {}) {
                    
                    VStack {
                        Image(systemName: "hourglass.badge.plus")
                        Text("Add 30 Minutes")
                    }
                }
                .buttonStyle(.bordered)
            }
                
                Button(action: {}) {
                    
                    VStack {
                        Image(systemName: "calendar.badge.clock.rtl")
                        Text("Reschedule")
                    }
                }
                .buttonStyle(.bordered)
            
        }.padding()
    }
}

#Preview {
    ActivityTimerView()
}
