//
//  LoginViewModel.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-23.
//

import Foundation

protocol LoginViewModelType: ObservableObject {
    var username: String { get set }
    var password: String { get set }
    var loginError: String? { get set }
    var isLoading: Bool { get set }
    
    
    func login() async
    func forgotPassword()
    func createAccount()
}
class LoginViewModel: LoginViewModelType {
    
    var username: String = "" {
        didSet {
            if !username.isEmpty {
                loginError = nil
            }
        }
    }
    
    var password: String = "" {
        didSet {
            if !password.isEmpty {
                loginError = nil
            }
        }
    }
    
    @Published var loginError: String?
    @Published var isLoading: Bool = false
    
    private let loggedInHandler: () -> Void
    private let createAccountHandler: () -> Void
    private let forgotPasswordHandler: () -> Void
    private let accountNotVerifiedHandler: (_ username: String) -> Void
    
    init(
        loggedInHandler: @escaping () -> Void,
        createAccountHandler: @escaping () -> Void,
        forgotPasswordHandler: @escaping () -> Void,
        accountNotVerifiedHandler: @escaping (_ username: String) -> Void
    ) {
        self.loggedInHandler = loggedInHandler
        self.createAccountHandler = createAccountHandler
        self.forgotPasswordHandler = forgotPasswordHandler
        self.accountNotVerifiedHandler = accountNotVerifiedHandler
    }
    
    @MainActor
    func login() async {
        isLoading = true
        let status = await AppEnvironment.current.auth().signIn(username: username, password: password)
        switch status {
        case .success:
            loggedInHandler()
        case .accountNotVerified:
            accountNotVerifiedHandler(username)
            
        case .authError(let authError):
            loginError = authError.errorDescription
        case .error(let error):
            loginError = error.localizedDescription
        }
        
        self.isLoading = false

    }
    
    func forgotPassword() {
        forgotPasswordHandler()
    }
    
    func createAccount() {
        createAccountHandler()
    }
}
