//
//  LearningMonitor.swift
//  blockapp
//
//  Created by Jan Osuský on 01.08.2025.
//

import DeviceActivity
import ManagedSettings
import SwiftUI
import Combine
import FamilyControls




class LearningMonitor: ObservableObject {
    @Published var goalReached: Bool = false
    @Published var rewardTimeRemaining: TimeInterval = 0
    
    private var timer: Timer?
    private let defaults = UserDefaults(suiteName: "group.janosusky.blockapp")
    
    init() {
        // Initialize state from defaults
        self.goalReached = defaults?.bool(forKey: "goalReached") ?? false
        
        // Start a timer to poll for changes from the extension (since UserDefaults KVO can be tricky with App Groups sometimes, but polling is safe/easy for this prototype)
        // Or better, just check on appear. But for "live" updates while app is open, polling or NotificationCenter is needed.
        // We'll use a simple timer to check for the "goalReached" state.
        
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.checkState()
        }
    }
    
    func checkState() {
        let newGoalReached = defaults?.bool(forKey: "goalReached") ?? false
        if newGoalReached != self.goalReached {
            DispatchQueue.main.async {
                self.goalReached = newGoalReached
            }
        }
    }
    
    // Helper for UI
    func formatTime(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Reward Logic (Client side)
    // The extension handles the "unblock" when goal is reached?
    // Actually, the extension unblocks when the interval ends or we explicitly tell it to.
    // In the plan, we said: "Extension implements eventDidReachThreshold... Send notification... Update shared state".
    // The extension does NOT automatically unblock in eventDidReachThreshold in my previous code?
    // Let's check DeviceActivityMonitorExtension.swift.
    // It sends notification and updates defaults. It does NOT unblock.
    // So the USER must click "Start Reward" in the UI.
    // When "Start Reward" is clicked, we need to tell the system to unblock.
    // BUT, the main app cannot easily control the shield if the shield is managed by the store in the extension?
    // Actually, ManagedSettingsStore can be used from the main app too if it has the right entitlements.
    // Let's assume main app can also write to ManagedSettingsStore.
    
    let store = ManagedSettingsStore()
    
    func startRewardTime() {
        // Unblock apps
        store.shield.applications = nil
        
        // Start local countdown for UI
        rewardTimeRemaining = 15 * 60 // Example: 15 mins reward
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.rewardTimeRemaining > 0 {
                self.rewardTimeRemaining -= 1
            } else {
                timer.invalidate()
                self.endRewardTime()
            }
        }
    }
    
    func pauseRewardTime() {
        timer?.invalidate()
        // Re-block apps?
        // If we pause, we should probably re-apply the shield.
        // We need to know WHICH apps to block.
        // We can get them from AppSelection.shared
        let selection = AppSelection.shared
        if selection.blockedApps.applicationTokens.isEmpty {
             store.shield.applications = nil
        } else {
             store.shield.applications = selection.blockedApps.applicationTokens
        }
    }
    
    func endRewardTime() {
        pauseRewardTime()
        // Reset goal?
        // defaults?.set(false, forKey: "goalReached")
        // goalReached = false
    }
}

