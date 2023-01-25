//
//  Environment.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-23.
//

import Foundation
import AWSPluginsCore

struct Environment {
    var user: AWSCredentials?
    var isUserSignedIn: Bool
    var auth: () -> AuthService
    
    static let main = Environment(
        user: nil,
        isUserSignedIn: false,
        auth: { AuthService.shared }
    )
}
