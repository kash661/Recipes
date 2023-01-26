//
//  TextFieldCoordinator.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-26.
//

import Foundation
import UIKit

class TextFieldCoordinator: NSObject, UITextFieldDelegate {
    var parent: TextFieldRepresented
    var onEditingChanged: ((Bool) -> Void)?
    var onCommit: (() -> Void)?

    init(_ textField: TextFieldRepresented, onCommit: (() -> Void)?) {
        self.parent = textField
        self.onCommit = onCommit
    }

    @objc func textChanged(_ textField: UITextField) {
        parent.text = textField.text ?? ""
    }

    @objc func editingDidEndOnExit() {
        onCommit?()
    }
}
