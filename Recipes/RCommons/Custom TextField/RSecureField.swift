//
//  RSecureField.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import SwiftUI

public struct RSecureField: View {

    public let placeholder: String
    @Binding public var text: String
    @Binding public var isShowingSecureEntry: Bool
    public let returnKeyType: UIReturnKeyType

    public var onCommit: (() -> Void)?
    public var onToggleSecure: ((Bool) -> Void)?

    public init(_ placeholder: String,
                text: Binding<String>,
                isShowingSecureEntry: Binding<Bool>,
                returnKeyType: UIReturnKeyType = .default,
                onCommit: (() -> Void)? = nil,
                onToggleSecure: ((Bool) -> Void)? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.returnKeyType = returnKeyType
        self.onCommit = onCommit
        self.onToggleSecure = onToggleSecure
        self._isShowingSecureEntry = isShowingSecureEntry
    }

    public var body: some View {
        HStack {
            TextFieldRepresented(placeholder: placeholder,
                                 text: self.$text,
                                 keyboardType: .default,
                                 returnKeyType: returnKeyType,
                                 isShowingSecureEntry: self.$isShowingSecureEntry,
                                 onCommit: onCommit)
            EyeButtonView(isShowingSecureEntry: isShowingSecureEntry) {
                self.isShowingSecureEntry.toggle()
                self.onToggleSecure?(self.isShowingSecureEntry)
            }
            .frame(width: 30, height: 30)
        }
    }
}

private struct EyeButtonView: View {
    
    var isShowingSecureEntry: Bool
    var onTapEye: (() -> Void)?

    var body: some View {
        Button {
            onTapEye?()
        } label: {
            Image(uiImage: isShowingSecureEntry ? Asset.Assets.showPassword.image : Asset.Assets.hidePassword.image)
                .resizable()
        }
    }
}
