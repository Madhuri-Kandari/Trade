//
//  AuthDataResultModel.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 17/03/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let userId: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.userId = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}
