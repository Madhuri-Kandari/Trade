//
//  AuthenticationProtocol.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 16/03/24.
//

import Foundation

protocol AuthenticationProtocol: AnyObject {
    //MARK: Google Sign-In
    func getGoogleAuthToken() async throws
    
    //MARK: Email Sign-In
    func createUser(email: String, password: String) async throws -> AuthDataResultModel
    func getAuthenticatedUser() throws -> AuthDataResultModel
    
    func startAuthPhoneNumer(phoneNumber: String, completion: @escaping (Bool)-> Void)
    func verifyOTP(otp: String, completion: @escaping (Bool)-> Void)
    func signOut() throws -> Bool
}
