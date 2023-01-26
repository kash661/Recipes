//
//  ConfirmSignUpView.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-23.
//

import SwiftUI

struct ConfirmSignUpView<ViewModel>: View where ViewModel: ConfirmSignUpViewModelType {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            AuthGradientBackgroundView()
            containerView
        }
    }
}

private extension ConfirmSignUpView {
    var containerView: some View {
        VStack {
            AuthHeaderView(title: "VERIFY EMAIL")
            
            Spacer()
            
            codeTextField
            
            HStack {
                Spacer()
                verfiyButton
            }
            
            Spacer()
            
            AuthDivider()
            resendCodeButton
        }.padding(24)
    }
    
    var codeTextField: RTextField {
        RTextField(
            placeholder: "Code",
            text: $viewModel.code,
            error: $viewModel.codeError,
            keyboardType: .numberPad,
            returnKeyType: .continue
        )
    }
    
    var verfiyButton: some View {
        Button(action: {
            Task {
                await viewModel.confirmSignUpTapped()
            }
            if viewModel.dismissKeyBoard {
                hideKeyboard()
            }
        }) {
            LoadingLabel(isLoading: viewModel.isVerifyCodeLoading) {
                Text("Verify")
                    .foregroundColor(.white)
                    .font(.headline.bold())
            }
        }
        .frame(width: 80)
        .buttonStyle(AuthButtonStyle(isEnabled: true))
    }
    
    var resendCodeButton: some View {
        Button(action: {
            Task {
                await viewModel.resendVerificationCodeTapped()
            }
        }) {
            LoadingLabel(isLoading: viewModel.isResendCodeLoading, color: .black) {
                Text("RESEND CODE")
                    .foregroundColor(Asset.Colors.textColor.swiftUIColor)
                    .font(.title3)
            }.padding(12)
        }
    }
}
