//
//  RTextField.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import SwiftUI

public struct RTextField: View {

    public enum Style {
        // placeholder disappears when it has text
        case noHeader
        // placeholder moves to be field header when it has text
        case floatingHeader

        public var isFloatingHeader: Bool {
            guard case .floatingHeader = self else { return false }
            return true
        }
    }

    public let style: Style
    public let keyboardType: UIKeyboardType
    public let textContentType: UITextContentType?
    public let returnKeyType: UIReturnKeyType
    public let isSecureTextEntry: Bool
    public var placeholder: String
    @Binding public var text: String
    @Binding public var error: String?
    @State private var isShowingHeader: Bool
    @State private var isShowingSecureEntry: Bool = true

    public var onEditingChanged: ((Bool) -> Void)?
    public var onCommit: (() -> Void)?
    public var onToggleSecure: ((Bool) -> Void)?

    public init(style: Style = .floatingHeader,
                placeholder: String,
                text: Binding<String>,
                error: Binding<String?>,
                keyboardType: UIKeyboardType = .default,
                textContentType: UITextContentType? = nil,
                returnKeyType: UIReturnKeyType = .default,
                isSecureTextEntry: Bool = false,
                onEditingChanged: ((Bool) -> Void)? = nil,
                onCommit: (() -> Void)? = nil,
                onToggleSecure: ((Bool) -> Void)? = nil) {
        self.style = style
        self.placeholder = placeholder
        self._text = text
        self._error = error
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.returnKeyType = returnKeyType
        self.isSecureTextEntry = isSecureTextEntry
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        self.onToggleSecure = onToggleSecure
        self._isShowingHeader = State(initialValue: !text.wrappedValue.isEmpty)
    }

    public var body: some View {
        // Intercept our binding text so we can show/hide header label when we have text
        let textIntercept = Binding<String>(get: {
            self.text
        }, set: {
            self.text = $0
            self.error = nil
            withAnimation {
                self.isShowingHeader = !self.text.isEmpty
            }
        })
        return VStack {
            Spacer()
            VStack {
                if isShowingHeader && style.isFloatingHeader {
                    Text(self.placeholder)
                        .fieldHeaderStyle()
                        .textAnimationStyle(isShowingHeader: self.isShowingHeader)
                }
                if isSecureTextEntry {
                    RSecureField(self.placeholder,
                                          text: textIntercept,
                                          isShowingSecureEntry: self.$isShowingSecureEntry,
                                          returnKeyType: self.returnKeyType,
                                          onEditingChanged: self.onEditingChanged,
                                          onCommit: self.onCommit,
                                          onToggleSecure: self.onToggleSecure)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    TextFieldRepresented(placeholder: self.placeholder,
                                         text: textIntercept,
                                         textContentType: self.textContentType,
                                         keyboardType: self.keyboardType,
                                         returnKeyType: self.returnKeyType,
                                         onEditingChanged: self.onEditingChanged,
                                         onCommit: self.onCommit)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            Spacer()
                .frame(height: 20)
                .layoutPriority(-1)
            if error != nil {
                Asset.Colors.error.swiftUIColor
                    .frame(height: 1)
            } else {
                Asset.Colors.textColor.swiftUIColor
                    .frame(height: 1)
            }
            Spacer()
                .frame(height: 10)
                .layoutPriority(-1)
            Unwrap(self._error.wrappedValue) { error in
                Text(error.uppercased())
                    .fieldErrorStyle()
                    .transition(.moveAndFade)
            }
            Spacer()
        }
            .fixedSize(horizontal: false, vertical: true)
    }
}

private struct FieldHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.callout.bold())
            .foregroundColor(Asset.Colors.textColorSecondary.swiftUIColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

fileprivate extension View {
    /// Applied to header label
    func fieldHeaderStyle() -> some View {
        self.modifier(FieldHeader())
    }
}

struct FieldError: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.callout.bold())
            .foregroundColor(Asset.Colors.error.swiftUIColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

fileprivate extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.opacity.combined(with: .move(edge: .bottom))
    }
}

private struct TextAnimation: ViewModifier {

    var isShowingHeader: Bool

    func body(content: Content) -> some View {
        content
            .animation(.easeInOut.speed(0.75), value: isShowingHeader)
            .opacity(isShowingHeader ? 1 : 0)
            .transition(.moveAndFade)
    }
}

fileprivate extension View {
    /// Applied to error label
    func textAnimationStyle(isShowingHeader: Bool) -> some View {
        self.modifier(TextAnimation(isShowingHeader: isShowingHeader))
    }
}
