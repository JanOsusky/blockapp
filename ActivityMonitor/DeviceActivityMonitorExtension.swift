//
//  DeviceActivityMonitorExtension.swift
//  ActivityMonitor
//
//  Created by Jan Osuský on 15.05.2025.
//

import DeviceActivity
import FamilyControls
import ManagedSettings

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.

// Local definition to ensure decoding works if the main app file isn't shared
struct AppSelection: Codable {
    var blockedApps: FamilyActivitySelection
    var blockedWeb: [String]?
    var learningApps: FamilyActivitySelection
    var minLearningTime: Int
}

class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    let store = ManagedSettingsStore()
    
    // We need to load the selection to know what to block, but since we can't easily share the complex object
    // directly without duplicating the Codable logic or sharing the file, we will rely on the fact that
    // the main app sets up the schedule and events.
    // However, to know WHICH apps to block (the tokens), we do need access to the stored selection.
    // We'll use the AppSelection.load() method if we can access the file, or duplicate the load logic.
    // Since AppSelection is in the main app target, we might not have access to it here unless it's in a shared framework
    // or the file is added to the extension target.
    // CHECK: Is AppSelection.swift added to the Extension target?
    // If not, we should probably duplicate the load logic or move AppSelection to a shared file.
    // For now, I will assume I can instantiate AppSelection or read the defaults directly.
    
    // To avoid dependency issues if AppSelection isn't shared, I'll implement a safe loader here.
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        print("Interval Started in Extension")
        // When the interval starts (e.g. beginning of day), we want to block the distracting apps.
        blockDistractingApps()
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        print("Interval Ended in Extension")
        // When the interval ends, we unblock everything.
        store.shield.applications = nil
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        print("Event Reached Threshold in Extension")
        // The learning goal has been reached!
        
        // 1. Notify the user
        sendNotification(title: "Learning Goal Reached!", body: "You've met your goal. You can now start your reward time.")
        
        // 2. Update shared state so the main app knows
        let sharedDefaults = UserDefaults(suiteName: "group.janosusky.blockapp")
        sharedDefaults?.set(true, forKey: "goalReached")
    }
    
    // MARK: - Helpers
    
    private func blockDistractingApps() {
        // Load the blocked apps from UserDefaults
        let sharedDefaults = UserDefaults(suiteName: "group.janosusky.blockapp")
        if let data = sharedDefaults?.data(forKey: "AppSelectionData") {
            do {
                let decoder = PropertyListDecoder()
                let selection = try decoder.decode(AppSelection.self, from: data)
                
                if selection.blockedApps.applicationTokens.isEmpty {
                    store.shield.applications = nil
                } else {
                    store.shield.applications = selection.blockedApps.applicationTokens
                }
            } catch {
                print("Failed to decode AppSelection in Extension: \(error)")
            }
        }
    }
    
    private func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error sending notification from Extension: \(error)")
            }
        }
    }
}
