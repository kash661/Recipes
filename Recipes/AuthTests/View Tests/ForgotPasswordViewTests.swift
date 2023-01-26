//
//  ForgotPasswordViewTests.swift
//  AuthTests
//
//  Created by Akash Desai on 2023-01-25.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest
@testable import Recipes

class ForgotPasswordViewTests: XCTestCase {
    override class func setUp() {
        super.setUp()
    }
    
    func testForgotPasswordView_lightMode() {
        let traitLightMode = UITraitCollection(userInterfaceStyle: .light)
        let viewModel = MockForgotPasswordViewModel()
        let createAccountView = ForgotPasswordView(viewModel: viewModel)
        let vc = UIHostingController(rootView: createAccountView)
        assertSnapshot(matching: vc, as: .image(on: .iPhone13, traits: traitLightMode), testName: "ForgotPasswordView_light_mode")
    }
    
    func testForgotPasswordView_darkMode() {
        let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)

        let viewModel = MockForgotPasswordViewModel()
        let createAccountView = ForgotPasswordView(viewModel: viewModel)
        let vc = UIHostingController(rootView: createAccountView)
        assertSnapshot(matching: vc, as: .image(on: .iPhone13, traits: traitDarkMode), testName: "ForgotPasswordView_dark_mode")
    }
}

class MockForgotPasswordViewModel: ForgotPasswordViewModelType {
    var username: String = ""
    var usernameError: String?
    var resetStatusMessage: String?
    var isLoading: Bool = false
    func sendForgotPasswordEmail() async { }
    func backButtonTapped() { }
}
