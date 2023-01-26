//
//  LoginViewTests.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-25.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest
@testable import Recipes

class LoginViewTests: XCTestCase {
    override class func setUp() {
        super.setUp()
    }
    
    func testLoginView_lightMode() {
        let traitLightMode = UITraitCollection(userInterfaceStyle: .light)
        let viewModel = MockLoginViewModel()
        let loginView = LoginView(viewModel: viewModel)
        let vc = UIHostingController(rootView: loginView)
        assertSnapshot(matching: vc, as: .image(on: .iPhone13, traits: traitLightMode), testName: "LoginView_light_mode")
    }
    
    func testLoginView_darkMode() {
        let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)

        let viewModel = MockLoginViewModel()
        let loginView = LoginView(viewModel: viewModel)
        let vc = UIHostingController(rootView: loginView)
        assertSnapshot(matching: vc, as: .image(on: .iPhone13, traits: traitDarkMode), testName: "LoginView_dark_mode")
    }
}

class MockLoginViewModel: LoginViewModelType {
    var username: String = ""
    var password: String = ""
    var loginError: String?
    var isLoading: Bool = false
    func login() async { }
    func forgotPassword() { }
    func createAccount() { }
}
