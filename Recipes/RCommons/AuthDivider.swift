//
//  AuthDivider.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-25.
//

import Foundation
import SwiftUI

struct AuthDivider: View {
    
    var body: some View {
        Rectangle()
            .foregroundColor(Asset.Colors.textColor.swiftUIColor.opacity(0.15))
            .frame(height: 1.0)
            .ignoresSafeArea(.all)
            .padding(.leading, -20)
            .padding(.trailing, -20)
    }
}
