//
//  ActivityIndicator.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//
import UIKit
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    var isAnimating: Bool
    var style: UIActivityIndicatorView.Style = .medium
    var color: UIColor = .white

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.color = color
        uiView.style = style
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
