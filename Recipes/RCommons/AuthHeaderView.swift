//
//  AuthHeaderView.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-25.
//

import Foundation
import SwiftUI

struct AuthHeaderView: View {
    let title: String
    
    var body: some View {
        //logo
        HStack {
            Text(title)
                .font(.largeTitle.bold())
            Spacer()
        }
    }
}
