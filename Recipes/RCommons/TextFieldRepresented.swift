//
//  TextFieldRepresented.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import Foundation
import SwiftUI
import UIKit

internal struct TextFieldRepresented: UIViewRepresentable {
    let placeholder: String
    @Binding var text: String
    let textContentType: UITextContentType?
    let keyboardType: UIKeyboardType
    let returnKeyType: UIReturnKeyType
    @Binding var isShowingSecureEntry: Bool
    var onEditingChanged: ((Bool) -> Void)?
    var onCommit: (() -> Void)?

    init(placeholder: String,
         text: Binding<String>,
         textContentType: UITextContentType?,
         keyboardType: UIKeyboardType = .default,
         returnKeyType: UIReturnKeyType = .default,
         isShowingSecureEntry: Binding<Bool> = .constant(false),
         onEditingChanged: ((Bool) -> Void)? = nil,
         onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.textContentType = textContentType
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self._isShowingSecureEntry = isShowingSecureEntry
        self.onEditingChanged = onEditingChanged
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
        textField.textContentType = textContentType
        textField.autocapitalizationType = keyboardType == .emailAddress ? .none : .sentences
        textField.isSecureTextEntry = isShowingSecureEntry
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textChanged), for: .editingChanged)
        textField.addTarget(context.coordinator, action: #selector(Coordinator.editingDidBegin), for: .editingDidBegin)
        textField.addTarget(context.coordinator, action: #selector(Coordinator.editingDidEnd), for: .editingDidEnd)
        textField.addTarget(context.coordinator, action: #selector(Coordinator.editingDidEndOnExit), for: .editingDidEndOnExit)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        return textField
    }

    func updateUIView(_ textField: UITextField, context: Context) {
        textField.text = text
        textField.isSecureTextEntry = isShowingSecureEntry
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, onEditingChanged: onEditingChanged, onCommit: onCommit)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldRepresented
        var onEditingChanged: ((Bool) -> Void)?
        var onCommit: (() -> Void)?

        init(_ textField: TextFieldRepresented, onEditingChanged: ((Bool) -> Void)?, onCommit: (() -> Void)?) {
            self.parent = textField
            self.onEditingChanged = onEditingChanged
            self.onCommit = onCommit
        }

        @objc func textChanged(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }

        @objc func editingDidBegin() {
            onEditingChanged?(true)
        }

        @objc func editingDidEnd() {
            onEditingChanged?(false)
        }

        @objc func editingDidEndOnExit() {
            onCommit?()
        }
    }
}
