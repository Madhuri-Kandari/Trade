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

class AuthenticationManager: AuthenticationProtocol {
    
    private let auth = Auth.auth()
    private var verificationID: String?
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accesToken)
        return try await signIn(credential: credential)
    }
    
    @MainActor
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
            let authDataResult = try await auth.signIn(with: credential)
            return AuthDataResultModel(user: authDataResult.user)
    }
    
    //MARK: Google Sign-In
    @MainActor
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
}

//MARK: Email Sign-In
extension AuthenticationManager {
    //MARK: server, hence async
    @MainActor
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await auth.createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    //MARK: checking locally, hence there is no async
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = auth.currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
}

//MARK: Sign-Out
extension AuthenticationManager {
    nonisolated func signOut() throws -> Bool {
        do {
            try auth.signOut()
            return true
        } catch {
            throw URLError(.badServerResponse)
        }
    }
}

extension AuthenticationManager {
    func startAuthPhoneNumer(phoneNumber: String, completion: @escaping (Bool)-> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
            guard let verificationID = verificationID, error == nil else {
                completion(false)
                return
            }
            self?.verificationID = verificationID
            completion(true)
        }
    }
    
    func verifyOTP(otp: String, completion: @escaping (Bool)-> Void) {
        guard let verificationID = verificationID else {
            completion(false)
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otp)
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else { 
                completion(false)
                return }
            completion(true)
        }
    }
}
