//
//  TextFieldRepresented.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import Foundation
import SwiftUI
import UIKit

struct TextFieldRepresented: UIViewRepresentable {
    let placeholder: String
    @Binding var text: String
    @Binding var isShowingSecureEntry: Bool
    let keyboardType: UIKeyboardType
    let returnKeyType: UIReturnKeyType
    var onCommit: (() -> Void)?

    init(placeholder: String,
         text: Binding<String>,
         keyboardType: UIKeyboardType = .default,
         returnKeyType: UIReturnKeyType = .default,
         isShowingSecureEntry: Binding<Bool> = .constant(false),
         onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self._isShowingSecureEntry = isShowingSecureEntry
        self.onCommit = onCommit
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.delegate = context.coordinator
        textField.autocorrectionType = .no
        textField.placeholder = placeholder
        textField.textColor = Asset.Colors.textColor.color
        textField.font = .systemFont(ofSize: 20)
        textField.autocapitalizationType = keyboardType == .emailAddress ? .none : .sentences
        textField.isSecureTextEntry = isShowingSecureEntry
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textChanged), for: .editingChanged)
        textField.addTarget(context.coordinator, action: #selector(Coordinator.editingDidEndOnExit), for: .editingDidEndOnExit)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        return textField
    }

    func updateUIView(_ textField: UITextField, context: Context) {
        textField.text = text
        textField.isSecureTextEntry = isShowingSecureEntry
    }

    func makeCoordinator() -> TextFieldCoordinator {
        TextFieldCoordinator(self, onCommit: onCommit)
    }
}
