//
//  blockappApp.swift
//  blockapp
//
//  Created by Jan Osuský on 12.04.2025.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import ManagedSettings

// You should define your DeviceActivityName and DeviceActivityEvent.Name in a separate file or extension

@main
struct blockappApp: App {
    // Loading selection from storage
    @StateObject var selection = AppSelection.load()
    let center = AuthorizationCenter.shared
    let activityCenter = DeviceActivityCenter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    // Request authorizations first
                    do {
                        try await center.requestAuthorization(for: .individual)
                    } catch {
                        print("Failed to get FamilyControls authorization: \(error)")
                    }
                    
                    do {
                        try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
                    } catch {
                        print("Failed to get UNUserNotificationCenter authorization: \(error)")
                    }
                    
                    // Now that 'selection' is available, you can use it to set up monitoring.
                    // This is the key change to fix the error.
                    let schedule = DeviceActivitySchedule(
                        intervalStart: DateComponents(hour: 0, minute: 0),
                        intervalEnd: DateComponents(hour: 23, minute: 59),
                        repeats: true
                    )
                    
                    // Fix: minLearningTime is in minutes.
                    // We want the threshold to be in minutes.
                    let learningGoalMinutes = selection.minLearningTime
                    
                    let learningAppEvent = DeviceActivityEvent(
                        applications: selection.learningApps.applicationTokens,
                        threshold: DateComponents(minute: learningGoalMinutes)
                    )
                    
                    // Start monitoring the activity
                    do {
                        try activityCenter.startMonitoring(.learningAppActivity, during: schedule, events: [ .learningAppEvent : learningAppEvent])
                        print("Successfully started monitoring daily activity.")
                    } catch {
                        print("Failed to start activity schedule: \(error)")
                    }
                }
        }
    }
}
