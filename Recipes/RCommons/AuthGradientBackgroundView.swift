//
//  AuthGradientBackgroundView.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-25.
//

import Foundation
import SwiftUI

struct AuthGradientBackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [Asset.Colors.zuccini.swiftUIColor, Asset.Colors.tusk.swiftUIColor, Asset.Colors.textColor.swiftUIColor],
            startPoint: .top,
            endPoint: .bottom
        )
        .opacity(0.3)
        .ignoresSafeArea()
    }
}
