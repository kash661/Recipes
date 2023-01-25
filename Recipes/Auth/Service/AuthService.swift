//
//  CognitoService.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-23.
//

import Foundation
import AWSPluginsCore
import Amplify
import AWSCognitoAuthPlugin


// MARK: need to come back and adjust all print statements https://app.clickup.com/t/860ppvaj3
class AuthService {
    
    static let shared = AuthService()
    private init() {}
    
    func fetchUserSession() async {
        do {
            let session = try await Amplify.Auth.fetchAuthSession()
            AppEnvironment.updateUserSession(session.isSignedIn)
            
            // Get identity id
            if let identityProvider = session as? AuthCognitoIdentityProvider {
                let identityId = try identityProvider.getIdentityId().get()
                print("Identity id \(identityId)")
            }
            
            // Get AWS credentials
            if let awsCredentialsProvider = session as? AuthAWSCredentialsProvider {
                let credentials = try awsCredentialsProvider.getAWSCredentials().get()
                print(credentials)
            }
        } catch let error as AuthError {
            print("Fetch auth session failed with error - \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func signUp(username: String, password: String, email: String) async -> SignUpStatus {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        do {
            let signUpResult = try await Amplify.Auth.signUp(
                username: username,
                password: password,
                options: options
            )
            if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
                print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
                return .verifyEmail
            } else {
                print("SignUp Complete")
            }
        } catch let error as AuthError {
            print("An error occurred while registering a user \(error)")
            return .authError(error)
            
        } catch {
            print("Unexpected error: \(error)")
            return .error(error)
        }
        return .noResult
    }
    
    func confirmSignUp(for username: String, with confirmationCode: String) async -> Bool {
        do {
            let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(
                for: username,
                confirmationCode: confirmationCode
            )
            print("Confirm sign up result completed: \(confirmSignUpResult.isSignUpComplete)")
            return confirmSignUpResult.isSignUpComplete
        } catch let error as AuthError {
            print("An error occurred while confirming sign up \(error)")
            return true
        } catch {
            print("Unexpected error: \(error)")
            return true
        }
    }
    
    func confirmAttribute() async {
        do {
            try await Amplify.Auth.confirm(userAttribute: .email, confirmationCode: "390739")
            print("Attribute verified")
        } catch let error as AuthError {
            print("Update attribute failed with error \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func fetchAttributes() async {
        do {
            let attributes = try await Amplify.Auth.fetchUserAttributes()
            print("User attributes - \(attributes)")
        } catch let error as AuthError{
            print("Fetching user attributes failed with error \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func resendCode(for username: String) async {
        do {
            let deliveryDetails = try await Amplify.Auth.resendSignUpCode(for: username)
            print("Resend code send to - \(deliveryDetails)")
        } catch let error as AuthError {
            print("Resend code failed with error \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func signIn(username: String, password: String) async -> SignInStatus {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: username,
                password: password
            )
            switch signInResult.nextStep {
                
            case .confirmSignInWithSMSMFACode, .confirmSignInWithCustomChallenge, .confirmSignInWithNewPassword, .resetPassword:
                break
            case .confirmSignUp(let info):
                guard (info != nil) else {
                    return .accountNotVerified
                }
                break
            case .done:
                return .success
            }
            if signInResult.isSignedIn {
                print("Sign in succeeded")
                return .success
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
            return .authError(error)
        } catch {
            print("Unexpected error: \(error)")
            return .error(error)
        }
        return .success
    }
    
    func signOutLocally() async {
        let result = await Amplify.Auth.signOut()
        guard let signOutResult = result as? AWSCognitoSignOutResult
        else {
            print("Signout failed")
            return
        }
        
        print("Local signout successful: \(signOutResult.signedOutLocally)")
        switch signOutResult {
        case .complete:
            // Sign Out completed fully and without errors.
            print("Signed out successfully")
            
        case let .partial(revokeTokenError, globalSignOutError, hostedUIError):
            // Sign Out completed with some errors. User is signed out of the device.
            
            if let hostedUIError = hostedUIError {
                print("HostedUI error  \(String(describing: hostedUIError))")
            }
            
            if let globalSignOutError = globalSignOutError {
                // Optional: Use escape hatch to retry revocation of globalSignOutError.accessToken.
                print("GlobalSignOut error  \(String(describing: globalSignOutError))")
            }
            
            if let revokeTokenError = revokeTokenError {
                // Optional: Use escape hatch to retry revocation of revokeTokenError.accessToken.
                print("Revoke token error  \(String(describing: revokeTokenError))")
            }
            
        case .failed(let error):
            // Sign Out failed with an exception, leaving the user signed in.
            print("SignOut failed with \(error)")
        }
    }
    
    func resetPassword(username: String) async -> ResetPasswordStatus {
        do {
            let resetResult = try await Amplify.Auth.resetPassword(for: username)
            switch resetResult.nextStep {
            case .confirmResetPasswordWithCode(let deliveryDetails, let info):
                print("Confirm reset password with code send to - \(deliveryDetails) \(String(describing: info))")
                return .emailSent("Email sent to \(deliveryDetails) \(String(describing: info))")
            case .done:
                print("Reset completed")
                return .resetSuccess
            }
        } catch let error as AuthError {
            print("Reset password failed with error \(error)")
            return .authError(error)
        } catch {
            print("Unexpected error: \(error)")
            return .error(error)
        }
    }
    
}
