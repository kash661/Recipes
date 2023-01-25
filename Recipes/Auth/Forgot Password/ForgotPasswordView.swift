//
//  ForgotPasswordView.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-25.
//

import Foundation
import SwiftUI

struct ForgotPasswordView<ViewModel>: View where ViewModel: ForgotPasswordViewModelType {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            AuthGradientBackgroundView()
            containerView
        }
    }
}

private extension ForgotPasswordView {
    var containerView: some View {
        VStack {
            Spacer()
            AuthHeaderView(title: "RESET")
                .padding(.leading)
            Spacer()
            
            emailStatusMessageText
            emailTextField
                .padding(.leading)
                .padding(.trailing)
            
            HStack {
                Spacer()
                sendEmailButton
            }.padding(.top, 24)
            Spacer()
        }
        .padding()
        .navigationBarItems(trailing: Button(action: {
            viewModel.backButtonTapped()
        }, label: {
            Image(uiImage: Asset.Assets.closeX.image)
                .resizable()
                .frame(width: 20, height: 20)
        }))
    }
    
    var emailTextField: RTextField {
        RTextField(placeholder: "Username", text: $viewModel.username, error: $viewModel.usernameError)
    }
    
    var emailStatusMessageText: some View {
        HStack {
            Text(viewModel.resetStatusMessage ?? "")
                .foregroundColor(Asset.Colors.textColor.swiftUIColor)
                .font(.callout.bold())
            Spacer()
        }
        .padding(.bottom, 24)
        .padding(.leading)
    }
    
    var sendEmailButton: some View {
        Button(action: {
            Task {
                await viewModel.sendForgotPasswordEmail()
            }
        }, label: {
            LoadingLabel(isLoading: viewModel.isLoading) {
                Text("SEND EMAIL")
                    .font(.callout.bold())
                    .foregroundColor(Asset.Colors.textColor.swiftUIColor)
            }
        })
        .frame(width: 120)
        .buttonStyle(FormButtonStyle(isEnabled: true))
    }
}
