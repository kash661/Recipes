//
//  LoginView.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-23.
//

import SwiftUI

struct LoginView<ViewModel>: View where ViewModel: LoginViewModelType {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            AuthGradientBackgroundView()
            containerView
        }
    }
}

private extension LoginView {
    var containerView: some View {
        VStack {
            Spacer()
            AuthHeaderView(title: "LOG IN")
                .padding(.leading)
            
            Spacer()
            errorMessageText
            Group {
                usernameTextField
                passwordTextField
                HStack {
                    Spacer()
                    forgotPasswordButton
                }
            }
            .padding(.leading)
            .padding(.trailing)
            
            HStack {
                Spacer()
                loginButton
            }.padding(.top, 36)
            
            Spacer()
            
            AuthDivider()
            signUpButton
        }.padding()
    }
    
    var errorMessageText: some View {
        HStack {
            Text(viewModel.loginError?.uppercased() ?? "")
                .fieldErrorStyle()
            Spacer()
        }
        .padding(.bottom, 24)
        .padding(.leading)
    }
    
    var usernameTextField: RTextField {
        RTextField(
            placeholder: "Username",
            text: $viewModel.username,
            error: .constant(nil),
            textContentType: .username
        )
    }
    
    var passwordTextField: RTextField {
        RTextField(
            placeholder: "Password",
            text: $viewModel.password,
            error: .constant(nil),
            textContentType: .password,
            returnKeyType: .done,
            isSecureTextEntry: true
        )
    }
    
    var forgotPasswordButton: some View {
        Button {
            self.viewModel.forgotPassword()
        } label: {
            Text("Forgot password?")
                .font(.callout.bold())
                .foregroundColor(Asset.Colors.textColor.swiftUIColor)
        }
        
    }
    
    var loginButton: some View {
        Button(action: {
            Task {
                await viewModel.login()
            }
        }) {
            LoadingLabel(isLoading: viewModel.isLoading) {
                HStack {
                    Text("LOG IN")
                        .foregroundColor(.white)
                        .font(.headline.bold())
                    Image(uiImage: Asset.Assets.forwardArrow.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 30)
                }
            }
        }
        .frame(width: 120)
        .buttonStyle(AuthButtonStyle(isEnabled: true))
    }
    
    var signUpButton: some View {
        Button(action: {
            self.viewModel.createAccount()
        }) {
            Text("CREATE ACCOUNT")
                .foregroundColor(Asset.Colors.textColor.swiftUIColor)
                .font(.title3)
        }.padding(12)
    }
}

