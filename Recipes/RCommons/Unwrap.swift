//
//  Unwrap.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import SwiftUI

// Credit: John Sundell @ https://www.swiftbysundell.com/tips/optional-swiftui-views/

public struct Unwrap<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content

    public init(_ value: Value?, @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }

    public var body: some View {
        value.map(contentProvider)
    }
}
