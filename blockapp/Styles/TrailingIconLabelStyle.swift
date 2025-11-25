//
//  TrailingIconLabelStyle.swift
//  blockapp
//
//  Created by Jan Osuský on 22.04.2025.
//

import Foundation
import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon

        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var traillingIcon: Self { Self()}
}
