//
//  ConfirmSignUpViewModel.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import Foundation

protocol ConfirmSignUpViewModelType: ObservableObject {
    var username: String { get }
    var code: String { get set }
    var codeError: String? { get set }
    var isVerifyCodeLoading: Bool { get set }
    var isResendCodeLoading: Bool { get set }
    var dismissKeyBoard: Bool { get set }
    
    func confirmSignUpTapped() async
    func resendVerificationCodeTapped() async
}

class ConfirmSignUpViewModel: ConfirmSignUpViewModelType {
    
    var code: String = "" {
        didSet {
            if !code.isEmpty {
                codeError = nil
            }
        }
    }
    
    @Published var codeError: String?
    @Published var isVerifyCodeLoading: Bool = false
    @Published var isResendCodeLoading: Bool = false
    @Published var dismissKeyBoard: Bool = false
    @Published var status: Bool = false
    
    let username: String
    private let confirmSignUpHandler: () -> Void
    
    
    // MARK: Init
    init(username: String, confirmSignUpHandler: @escaping () -> Void) {
        self.username = username
        self.confirmSignUpHandler = confirmSignUpHandler
    }
    
    @MainActor
    func confirmSignUpTapped() async {
        isVerifyCodeLoading = true
        codeError = code.isEmpty ? "Enter code" : nil
        isVerifyCodeLoading = false
        guard codeError == nil else { return }
        isVerifyCodeLoading = true
        self.status = await AppEnvironment.current.auth().confirmSignUp(for: username, with: code)
        if status {
            self.isVerifyCodeLoading = false
            self.dismissKeyBoard = true
            self.confirmSignUpHandler()
        } else {
            self.codeError = "Try again"
            self.isVerifyCodeLoading = false
            self.dismissKeyBoard = false
        }
    }
    
    @MainActor
    func resendVerificationCodeTapped() async {
        isResendCodeLoading = true
        await AppEnvironment.current.auth().resendCode(for: username)
        isResendCodeLoading = false
        dismissKeyBoard = true
    }
}
