//
//  CreateAccountViewTests.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-25.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest
@testable import Recipes

class CreateAccountViewTests: XCTestCase {
    override class func setUp() {
        super.setUp()
    }
    
    func testCreateAccountView_lightMode() {
        let traitLightMode = UITraitCollection(userInterfaceStyle: .light)
        let viewModel = MockCreateAccountViewModel()
        let createAccountView = CreateAccountView(viewModel: viewModel)
        let vc = UIHostingController(rootView: createAccountView)
        assertSnapshot(matching: vc, as: .image(on: .iPhone13, traits: traitLightMode), testName: "CreateAccountView_light_mode")
    }
    
    func testCreateAccountView_darkMode() {
        let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)

        let viewModel = MockCreateAccountViewModel()
        let createAccountView = CreateAccountView(viewModel: viewModel)
        let vc = UIHostingController(rootView: createAccountView)
        assertSnapshot(matching: vc, as: .image(on: .iPhone13, traits: traitDarkMode), testName: "CreateAccountView_dark_mode")
    }
}

class MockCreateAccountViewModel: CreateAccountViewModelType {
    var email: String = ""
    var username: String = ""
    var password: String = ""
    var emailError: String?
    var usernameError: String?
    var passwordError: String?
    func signUp() async { }
    func backButtonTapped() { }
}
