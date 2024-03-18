//
//  LoginViewModel.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 16/03/24.
//

import Foundation

class LoginViewModel {
    var authenticationProtocol: AuthenticationProtocol!
    
    init(authenticationProtocol: AuthenticationProtocol) {
        self.authenticationProtocol = authenticationProtocol
    }
    
    func getGoogleAuthToken() {
        Task {
            try await authenticationProtocol.getGoogleAuthToken()
        }
    }
}
