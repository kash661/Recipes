//
//  LoginViewModelTests.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-25.
//

import Foundation
import XCTest
@testable import Recipes

class LoginViewModelTests: XCTestCase {
    var sut: LoginViewModelMock!
    
    override func setUp() {
        sut = LoginViewModelMock()
    }
    
    func testLoginError() async {
        sut.username = "user01"
        sut.password = "password"
        await sut.login()
        XCTAssertNil(sut.loginError)
    }
    
    func testLoginError_notNil() async {
        sut.username = ""
        sut.password = ""
        await sut.login()
        XCTAssertNotNil(sut.loginError)
    }
}

class LoginViewModelMock: LoginViewModelType {
    var username: String = ""
    
    var password: String = ""
    
    var loginError: String?
    
    var isLoading: Bool = false
    
    func login() async {
        if username.isEmpty || password.isEmpty {
            loginError = "Error"
        } else {
            loginError = nil
        }
    }
    
    func forgotPassword() { }
    func createAccount() { }
}
