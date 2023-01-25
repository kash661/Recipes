//
//  CreateAccountCoordinator.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-24.
//

import Foundation
import UIKit
import SwiftUI

class CreateAccountCoordinator: UIViewController {
    private let dismissHandler: () -> Void
    private let signedUpHandler: () -> Void
    
    private var createAccountNavigator: UINavigationController?
    
    init(dismissHandler: @escaping () -> Void, signedUpHandler: @escaping () -> Void) {
        self.dismissHandler = dismissHandler
        self.signedUpHandler = signedUpHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("☠️ CreateAccountCoordinator")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCreateAccountViewController()
        print("✅ CreateAccountCoordinator")
        view.backgroundColor = .clear
    }
}

private extension CreateAccountCoordinator {
    func showCreateAccountViewController() {
        let navigationViewController = UINavigationController()
        createAccountNavigator = navigationViewController
        let createAccountViewModel = CreateAccountViewModel(signedUpHandler: { [unowned self] username in
            self.showConfirmSignUpViewController(username)
        }, backButtonHandler: { [unowned self] in
            self.dismiss(animated: true)
            self.dismissHandler()
        })
        let createAccountView = CreateAccountView(viewModel: createAccountViewModel)
        let hostingController = UIHostingController(rootView: createAccountView)
        navigationViewController.pushViewController(hostingController, animated: true)
        
        navigationViewController.modalPresentationStyle = .fullScreen
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    
    func showConfirmSignUpViewController(_ username: String) {
        let confirmSignUpViewModel = ConfirmSignUpViewModel(username: username, confirmSignUpHandler: { [unowned self] in
            self.dismiss(animated: true)
            self.signedUpHandler()
        })
        let confirmSignUpView = ConfirmSignUpView(viewModel: confirmSignUpViewModel)
        let hostingController = UIHostingController(rootView: confirmSignUpView)
        self.createAccountNavigator?.pushViewController(hostingController, animated: true)
    }
}
