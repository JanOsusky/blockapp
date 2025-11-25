//
//  LearningAppView.swift
//  blockapp
//
//  Created by Jan Osuský on 22.07.2025.
//

import SwiftUI
import FamilyControls

struct LearningAppView: View {
    @Binding var LearningApps: FamilyActivitySelection
    var body: some View {
        FamilyActivityPicker(selection: $LearningApps)
    }
}

#Preview {
    LearningAppView(LearningApps: .constant(FamilyActivitySelection()))
}
