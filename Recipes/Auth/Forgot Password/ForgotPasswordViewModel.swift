//
//  ForgotPasswordViewModel.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-25.
//

import Foundation

protocol ForgotPasswordViewModelType: ObservableObject {
    var username: String { get set }
    var usernameError: String? { get set }
    var resetStatusMessage: String? { get set }
    var isLoading: Bool { get set }
    
    func sendForgotPasswordEmail() async
    func backButtonTapped()
}

class ForgotPasswordViewModel: ForgotPasswordViewModelType {
    var username: String = "" {
        didSet {
            if !username.isEmpty {
                usernameError = nil
            }
        }
    }
    
    @Published var usernameError: String?
    @Published var resetStatusMessage: String?
    @Published var isLoading: Bool = false
    
    private let dismissHandler: () -> Void
    
    // MARK: Init
    init(dismissHandler: @escaping () -> Void) {
        self.dismissHandler = dismissHandler
    }
    
    func backButtonTapped() {
        dismissHandler()
    }
    
    @MainActor
    func sendForgotPasswordEmail() async {
        isLoading = true
        let status = await AppEnvironment.current.auth().resetPassword(username: username)
        switch status {
        case .emailSent(let resetMessage):
            resetStatusMessage = resetMessage
        case .resetSuccess:
            dismissHandler()
        case .authError(let authError):
            usernameError = username.isEmpty ? "enter username" : authError.errorDescription
        case .error(let error):
            usernameError = username.isEmpty ? "enter username" : error.localizedDescription
        }
        isLoading = false
    }
}
