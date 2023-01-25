//
//  HiddenModifier.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import SwiftUI

public extension View {
    func isHidden(_ hidden: Bool) -> some View {
        modifier(HiddenModifier(isHidden: hidden))
    }
}

public struct HiddenModifier: ViewModifier {

    public let isHidden: Bool

    public init(isHidden: Bool) {
        self.isHidden = isHidden
    }

    public func body(content: Content) -> some View {
        Group {
            if isHidden {
                content.hidden()
            } else {
                content
            }
        }
    }
}
