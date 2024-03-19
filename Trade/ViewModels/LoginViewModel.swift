//
//  LoginViewModel.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 16/03/24.
//

import Foundation
@MainActor
class LoginViewModel {
    
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
    
    
    
    func createUser(email: String, password: String) {
        Task {
            do {
                let isSuccess = try await authenticationProtocol.createUser(email: email, password: password)
                print(isSuccess.email ?? "")
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
