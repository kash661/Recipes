//
//  CreateAccountViewModel.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-23.
//

import Foundation
import Amplify

protocol CreateAccountViewModelType: ObservableObject {
    var email: String { get set }
    var username: String { get set }
    var password: String { get set }
    var emailError: String? { get set }
    var usernameError: String? { get set }
    var passwordError: String? { get set }
    
    func signUp() async
    func backButtonTapped()
}

class CreateAccountViewModel: CreateAccountViewModelType {
    
    var email: String = "" {
        didSet {
            if !email.isEmpty {
                emailError = nil
            }
        }
    }
    
    var username: String = "" {
        didSet {
            if !username.isEmpty {
                usernameError = nil
            }
        }
    }
    
    var password: String = "" {
        didSet {
            if !password.isEmpty {
                passwordError = nil
            }
        }
    }
    
    @Published var usernameError: String?
    @Published var passwordError: String?
    @Published var emailError: String?
    
    private let signedUpHandler: (_ :String) -> Void
    private let backButtonHandler: () -> Void
    
    
    // MARK: Init
    init(signedUpHandler: @escaping (_ :String) -> Void, backButtonHandler: @escaping () -> Void) {
        self.signedUpHandler = signedUpHandler
        self.backButtonHandler = backButtonHandler
    }
    
    func backButtonTapped() {
        backButtonHandler()
    }
    
    @MainActor
    func signUp() async {
        emailError = email.isEmpty ? "Enter email" : nil
        usernameError = username.isEmpty ? "Enter username" : nil
        passwordError = password.isEmpty ? "Enter password" : nil
        guard emailError == nil, usernameError == nil, passwordError == nil else { return }
        
        let status = await AppEnvironment.current.auth().signUp(username: username, password: password, email: email)
        switch status {
        case .verifyEmail:
            signedUpHandler(username)
        case .authError(let authError):
            setError(authError)
            break
        case .error(_):
            //TODO: handle error
            break
        case .noResult:
            //TODO: handle error
            break
        }
    }
}

private extension CreateAccountViewModel {
    func setError(_ error: AuthError) {
        if error.errorDescription.contains("email") {
            emailError = error.errorDescription
        }
        if error.errorDescription.lowercased().contains("password") {
            passwordError = error.errorDescription
        }
        if error.errorDescription.contains("already") {
            usernameError = error.errorDescription
        }
    }
}
