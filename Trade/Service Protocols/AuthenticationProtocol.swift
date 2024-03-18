//
//  AuthenticationProtocol.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 16/03/24.
//

import Foundation

protocol AuthenticationProtocol: AnyObject {
    func getGoogleAuthToken() async throws
}
