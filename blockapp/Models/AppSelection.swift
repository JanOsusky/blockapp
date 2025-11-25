//
//  AppSelection.swift
//  blockapp
//
//  Created by Jan Osuský on 29.05.2025.
//

import SwiftUI
import FamilyControls

class AppSelection: ObservableObject, Codable {
    static let shared = AppSelection()
    @Published var blockedApps = FamilyActivitySelection()
    @Published var blockedWeb: [String]? = nil
    @Published var learningApps = FamilyActivitySelection()
    @Published var minLearningTime: Int = 25 // In minutes
    
    private let sharedDefaults = UserDefaults(suiteName: "group.janosusky.blockapp")!
    
    private init() {}
    
    // Used to encode codable to UserDefaults
    private let encoder = PropertyListEncoder()

    // Used to decode codable from UserDefaults
    private let decoder = PropertyListDecoder()
    
    // Codable requires custom implementation because of @Published
    enum CodingKeys: CodingKey {
        case blockedApps, blockedWeb, learningApps, minLearningTime
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        blockedApps = try container.decode(FamilyActivitySelection.self, forKey: .blockedApps)
        blockedWeb = try container.decodeIfPresent([String].self, forKey: .blockedWeb)
        learningApps = try container.decode(FamilyActivitySelection.self, forKey: .learningApps)
        minLearningTime = try container.decode(Int.self, forKey: .minLearningTime)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(blockedApps, forKey: .blockedApps)
        try container.encode(blockedWeb, forKey: .blockedWeb)
        try container.encode(learningApps, forKey: .learningApps)
        try container.encode(minLearningTime, forKey: .minLearningTime)
    }
    
    
    func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil // Immediate
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error sending notification: \(error)")
            }
        }
    }
    
    func save() {
            do {
                let data = try encoder.encode(self)
                sharedDefaults.set(data, forKey: "AppSelectionData")
                sharedDefaults.synchronize()
                print("AppSelection saved to shared storage")
            } catch {
                print("Error encoding AppSelection: \(error)")
            }
        }
        
        static func load() -> AppSelection {
            let sharedDefaults = UserDefaults(suiteName: "group.com.yourname.blockapp")!
            if let data = sharedDefaults.data(forKey: "AppSelectionData") {
                do {
                    let decoded = try PropertyListDecoder().decode(AppSelection.self, from: data)
                    return decoded
                } catch {
                    print("Error decoding AppSelection: \(error)")
                }
            }
            return AppSelection.shared
        }
}
