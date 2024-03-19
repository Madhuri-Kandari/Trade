//
//  LoginView.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 16/03/24.
//

import UIKit
import GoogleSignIn

//MARK: LoginViewDelegate
protocol LoginViewDelegate: AnyObject {
    func didTapSignInEmail(view: LoginView)
}

class LoginView: UIView {
    
    //MARK: Properties
    weak var loginViewDelegate: LoginViewDelegate?
    
    var viewModel: LoginViewModel!
    
    //MARK: IBOutlets
    @IBOutlet weak var signInGoogleOutlet: GIDSignInButton! {
        didSet {
            signInGoogleOutlet.colorScheme = .dark
            signInGoogleOutlet.style = .wide
        }
    }
    @IBOutlet weak var signInEmailOutlet: UIButton!
    @IBOutlet weak var signInPhoneNumber: UIButton!
    
    //MARK: IBActions
    @IBAction func signInGoogleAction(_ sender: GIDSignInButton) {
        viewModel.getGoogleAuthToken()
    }
    @IBAction func signInEmailAction(_ sender: UIButton) {
        loginViewDelegate?.didTapSignInEmail(view: self)
    }
    
    //MARK: Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    //MARK: private methods
    private func commonInit() {
        guard let subView = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)?.first as? UIView else { return }
        subView.fixInView(self)
        viewModel = LoginViewModel(authenticationProtocol: AuthenticationManager())
    }
}

extension LoginView {
    func didTapSignInOnEmailView(view: EmailView, email: String, password: String) {
        viewModel.createUser(email: email, password: password)
    }
    
    func isAuthenticatedUserAvailable() -> Bool {
        return viewModel.isAuthenticatedUserAvailable()
    }
}

