//
//  LoginViewModel.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 16/03/24.
//

import Foundation
@MainActor
class LoginViewModel {
    
    var displayName: String?
    var authenticationProtocol: AuthenticationProtocol!
    
    init(authenticationProtocol: AuthenticationProtocol) {
        self.authenticationProtocol = authenticationProtocol
    }
    
    func getGoogleAuthToken() {
        Task {
            do {
                try await authenticationProtocol.getGoogleAuthToken()
            } catch {
                throw URLError(.badURL)
            }
        }
    }
}

extension LoginViewModel {
    func createUser(email: String, password: String) {
        Task {
            do {
                let result = try await authenticationProtocol.createUser(email: email, password: password)
                guard let displayName = result.displayName else { return }
                print(displayName)
            } catch {
                throw URLError(.badURL)
            }
        }
    }
    
    func isAuthenticatedUserAvailable() -> Bool {
        let user = try? authenticationProtocol.getAuthenticatedUser()
        return user == nil ? false : true
    }
}

extension LoginViewModel {
    func startAuth(phoneNumber: String, completion: @escaping (Bool)-> Void) {
        authenticationProtocol.startAuthPhoneNumer(phoneNumber: phoneNumber, completion: completion)
    }
    
    func verifyOTP(otp: String, completion: @escaping (Bool)-> Void) {
        authenticationProtocol.verifyOTP(otp: otp, completion: completion)
    }
}

extension LoginViewModel {
    func signOut() -> Bool {
        let result = try? authenticationProtocol.signOut()
        guard let result = result else { return false }
        return result
    }
}
