//
//  AuthServiceEnums.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-25.
//

import Foundation
import Amplify

enum SignInStatus {
    case success
    case accountNotVerified
    case authError(AuthError)
    case error(Error)
}

enum SignUpStatus {
    case verifyEmail
    case authError(AuthError)
    case error(Error)
    case noResult
}

enum ResetPasswordStatus {
    case emailSent(String)
    case resetSuccess
    case authError(AuthError)
    case error(Error)
}
