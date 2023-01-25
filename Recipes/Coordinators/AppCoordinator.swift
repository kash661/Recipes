//
//  ViewController.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-23.
//

import UIKit
import SwiftUI

class AppCoordinator: UIViewController {
    private var homeCoordinator: HomeTabsCoordinator?
    private var appNavigator: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: remove this signout once implemented
        Task {
            await AppEnvironment.current.auth().signOutLocally()
        }
        showApp()
    }
    
}

private extension AppCoordinator {
    func showApp() {
        children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        
        if AppEnvironment.current.isUserSignedIn {
            let homeCoordinator = HomeTabsCoordinator()
            addChild(homeCoordinator)
            homeCoordinator.didMove(toParent: self)
            homeCoordinator.view.embed(in: view)
        } else {
            let loginViewModel = LoginViewModel(
                loggedInHandler: { [unowned self] in
                    self.didLoginHandler()
                }, createAccountHandler: { [unowned self] in
                    self.createAccountCoordinatorHandler()
                }, forgotPasswordHandler: { [unowned self] in
                    self.showForgotPassword()
                }, accountNotVerifiedHandler: { [unowned self] username in
                    self.showAccountVerification(username: username)
                })
            let loginView = LoginView(viewModel: loginViewModel)
            let hostingController = UIHostingController(rootView: loginView)
            addChild(hostingController)
            hostingController.didMove(toParent: self)
            hostingController.view.embed(in: view)
        }
    }
    
    
    // MARK: CreateAccountCoordinator
    func createAccountCoordinatorHandler() {
        children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        let createAccountCoordinator = CreateAccountCoordinator(
            dismissHandler: { [unowned self] in
                self.showApp()
            }, signedUpHandler: { [unowned self] in
                self.showApp()
            })
        addChild(createAccountCoordinator)
        createAccountCoordinator.didMove(toParent: self)
        createAccountCoordinator.view.embed(in: view)
    }
    
    
    func showAccountVerification(username: String) {
        let confirmSignUpViewModel = ConfirmSignUpViewModel(
            username: username,
            confirmSignUpHandler: { [unowned self] in
                if let confirmSignUpVC = appNavigator?.topViewController as? UIHostingController<ConfirmSignUpView<ConfirmSignUpViewModel>> {
                    confirmSignUpVC.dismiss(animated: true)
                    showApp()
                }
            })
        let navigationViewController = UINavigationController()
        appNavigator = navigationViewController
        let confimSignUpView = ConfirmSignUpView(viewModel: confirmSignUpViewModel)
        let hostingController = UIHostingController(rootView: confimSignUpView)
        navigationViewController.pushViewController(hostingController, animated: true)
        present(navigationViewController, animated: true, completion: nil)
    }
    
    func showForgotPassword() {
        let forgotPasswordViewModel = ForgotPasswordViewModel(dismissHandler: { [unowned self] in
            if let forgotPasswordVC = appNavigator?.topViewController as? UIHostingController<ForgotPasswordView<ForgotPasswordViewModel>> {
                forgotPasswordVC.dismiss(animated: true)
            }
        })
        let navigationViewController = UINavigationController()
        appNavigator = navigationViewController
        let forgotPasswordView = ForgotPasswordView(viewModel: forgotPasswordViewModel)
        let hostingController = UIHostingController(rootView: forgotPasswordView)
        navigationViewController.pushViewController(hostingController, animated: true)
        navigationViewController.modalPresentationStyle = .fullScreen
        present(navigationViewController, animated: true, completion: nil)
    }
    
    func didLoginHandler() {
        fetchUserProfile()
    }
    
}

// MARK: Tasks
private extension AppCoordinator {
    
    func fetchUserProfile() {
        Task {
            await AppEnvironment.current.auth().fetchUserSession()
            showApp()
        }
    }
}
