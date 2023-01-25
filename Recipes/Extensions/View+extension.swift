//
//  View+extension.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension View {
    func fieldErrorStyle() -> some View {
        self.modifier(FieldError())
    }
}
