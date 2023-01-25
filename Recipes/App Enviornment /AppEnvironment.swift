//
//  AppEnvironment.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-23.
//

import Foundation
import AWSPluginsCore

struct AppEnvironment {
    fileprivate static var stack: [Environment] = [Environment.main]
    
    static var current: Environment {
        stack.last!
    }
    
    static func updateUser(_ user: AWSCredentials?) {
        pushEnvironment(Environment(user: user, isUserSignedIn: current.isUserSignedIn, auth: { AuthService.shared }))
    }
    
    static func updateUserSession(_ isUserSignedIn: Bool) {
        pushEnvironment(Environment(user: current.user, isUserSignedIn: isUserSignedIn, auth: { AuthService.shared }))
    }
    
    private static func pushEnvironment(_ environment: Environment) {
        stack.append(environment)
    }
}
