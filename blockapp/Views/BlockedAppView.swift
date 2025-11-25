//
//  BlockedAppView.swift
//  blockapp
//
//  Created by Jan Osuský on 22.07.2025.
//

import SwiftUI
import FamilyControls

struct BlockedAppView: View {
    
    @Binding var blockedApps: FamilyActivitySelection
    
    var body: some View {
        FamilyActivityPicker(selection: $blockedApps)
    }
}

#Preview {
    BlockedAppView(blockedApps: .constant(FamilyActivitySelection()))
}
