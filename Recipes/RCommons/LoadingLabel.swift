//
//  LoadingLabel.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import SwiftUI

struct LoadingLabel<Label: View>: View {
    var isLoading: Bool
    var label: Label
    var color: UIColor

    init(isLoading: Bool, color: UIColor = .white, label: () -> Label) {
        self.isLoading = isLoading
        self.color = color
        self.label = label()
    }

    var body: some View {
        ZStack {
            ActivityIndicator(isAnimating: isLoading, color: color)
            label.isHidden(isLoading)
        }
    }
}
