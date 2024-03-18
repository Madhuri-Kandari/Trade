//
//  AuthenticationManager.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 16/03/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

@MainActor
class AuthenticationManager: AuthenticationProtocol {
    func getGoogleAuthToken() async throws {
        guard let topViewController = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topViewController)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        try await signInWithGoogle(tokens: GoogleSignInResultModel(idToken: idToken, accesToken: accessToken))
        
    
    }
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accesToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
            let authDataResult = try await Auth.auth().signIn(with: credential)
            return AuthDataResultModel(user: authDataResult.user)
    }
    
    
}
