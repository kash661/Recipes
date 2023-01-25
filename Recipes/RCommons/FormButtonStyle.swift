//
//  FormButtonStyle.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import SwiftUI

struct FormButtonStyle: ButtonStyle {
    var isEnabled: Bool
    func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .frame(maxWidth: .infinity, minHeight: 45.0)
        .background(
            isEnabled ?
            SwiftUI.Color(Asset.Colors.darkGreen.color)
                : SwiftUI.Color(Asset.Colors.zuccini.color.withAlphaComponent(0.7))
        )
        .cornerRadius(12.0)
    }
}
