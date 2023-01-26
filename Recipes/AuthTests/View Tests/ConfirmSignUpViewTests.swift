//
//  ConfirmSignUpViewTests.swift
//  AuthTests
//
//  Created by Akash Desai on 2023-01-25.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest
@testable import Recipes

class ConfirmSignUpViewTests: XCTestCase {
    override class func setUp() {
        super.setUp()
    }
    
    func testConfirmSignUpView_lightMode() {
        let traitLightMode = UITraitCollection(userInterfaceStyle: .light)
        let viewModel = MockConfirmSignUpViewModel()
        let createAccountView = ConfirmSignUpView(viewModel: viewModel)
        let vc = UIHostingController(rootView: createAccountView)
        assertSnapshot(matching: vc, as: .image(on: .iPhone13, traits: traitLightMode), testName: "ConfirmSignUpView_light_mode")
    }
    
    func testConfirmSignUpView_darkMode() {
        let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)

        let viewModel = MockConfirmSignUpViewModel()
        let createAccountView = ConfirmSignUpView(viewModel: viewModel)
        let vc = UIHostingController(rootView: createAccountView)
        assertSnapshot(matching: vc, as: .image(on: .iPhone13, traits: traitDarkMode), testName: "ConfirmSignUpView_dark_mode")
    }
}

class MockConfirmSignUpViewModel: ConfirmSignUpViewModelType {
    var username: String = ""
    var code: String = ""
    var codeError: String?
    var isVerifyCodeLoading: Bool = false
    var isResendCodeLoading: Bool = false
    var dismissKeyBoard: Bool = false
    func confirmSignUpTapped() async { }
    func resendVerificationCodeTapped() async { }
}
