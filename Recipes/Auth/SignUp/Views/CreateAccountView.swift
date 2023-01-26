//
//  CreateAccountView.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-23.
//

import Foundation

import SwiftUI

struct CreateAccountView<ViewModel>: View where ViewModel: CreateAccountViewModelType {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            AuthGradientBackgroundView()
            containerView
        }
    }
}

private extension CreateAccountView {
    var containerView: some View {
        VStack {
            AuthHeaderView(title: "REGISTER")
                .padding(.leading)
            Spacer()
            
            Group {
                emailTextField
                usernameTextField
                passwordTextField
            }
            .padding(.leading)
            .padding(.trailing)
            
            Spacer()
            
            HStack {
                Spacer()
                signUpButton
            }
        }
        .padding()
        .navigationBarItems(trailing: Button(action: {
            self.viewModel.backButtonTapped()
        }, label: {
            Image(uiImage: Asset.Assets.closeX.image)
                .resizable()
                .frame(width: 20, height: 20)
        }))
    }
    
    var emailTextField : RTextField {
        RTextField(
            placeholder: "Email",
            text: $viewModel.email,
            error: $viewModel.emailError,
            keyboardType: .emailAddress,
            textContentType: .emailAddress
        )
    }
    
    var usernameTextField: RTextField {
        RTextField(
            placeholder: "Username",
            text: $viewModel.username,
            error: $viewModel.usernameError,
            textContentType: .emailAddress
        )
    }
    
    var passwordTextField: RTextField {
        RTextField(
            placeholder: "Password",
            text: $viewModel.password,
            error: $viewModel.passwordError,
            textContentType: .password,
            returnKeyType: .done,
            isSecureTextEntry: true
        )
    }
    
    var signUpButton: some View {
        Button(action: {
            Task {
                await viewModel.signUp()
            }
        }, label: {
            HStack {
                Text("NEXT")
                    .foregroundColor(.white)
                    .font(.headline.bold())
                Image(uiImage: Asset.Assets.forwardArrow.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 30)
            }
        })
        .frame(width: 110)
        .buttonStyle(AuthButtonStyle(isEnabled: true))
    }
}
