//
//  SettingsView.swift
//  blockapp
//
//  Created by Jan Osuský on 03.06.2025.
//

import SwiftUI
import FamilyControls
import ThemeKit

struct SettingsView: View {
    @State var appSelection = AppSelection.shared
    var monitor = LearningMonitor()
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Label("Reward Time  \(monitor.goalReached ? "00:00" : monitor.formatTime(time: monitor.rewardTimeRemaining)) min", systemImage: "clock.badge.checkmark.fill")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                        .padding(.horizontal)
                    VStack(spacing: 10) {
                        
                        Label("Required Learning Time", systemImage: "deskclock" ).font(.title2)
                            .padding()
                        HStack {
                            Button(action: {
                                appSelection.minLearningTime = max(0, appSelection.minLearningTime  - 5)
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            Text("\(appSelection.minLearningTime ) min")
                                .font(.title2)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button(action: {
                                appSelection.minLearningTime  += 5
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.cyan)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                    .padding(.horizontal)
                    
                    Button(action: {
                        
                        // Action for blocked apps
                    }) {
                        NavigationLink(destination: BlockedAppView(blockedApps: $appSelection.blockedApps)) {
                            Label("Blocked Applications", systemImage: "hand.raised.slash.fill")
                                .font(.title2)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                                .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        // Action for learning apps
                    }) {
                        NavigationLink(destination: LearningAppView(LearningApps: $appSelection.learningApps)) {
                            Label("Applications For Learning", systemImage: "graduationcap.fill")
                                .font(.title2)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                                .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    Button(action: {
                        // Action for learning apps
                        monitor.startRewardTime()
                    }) {
                        Label("Start Reward Time ", systemImage: "medal.fill")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.0, green: 0.1, blue: 0.4))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        monitor.pauseRewardTime()
                    }) {
                        Label("Pause Reward Time", systemImage: "pause.fill")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        // Action for learning apps
                    }) {
                        Label("Account settings", systemImage: "person.crop.circle.fill")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.brown)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                    }
                    .padding(.horizontal)
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    SettingsView()
}
