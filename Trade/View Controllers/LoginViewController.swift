//
//  ViewController.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 16/03/24.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: Properties
    private var loginView: LoginView!
    private var emailView: EmailView!
    
    private var isAuthenticatedUserAvailable: Bool = false {
        didSet {
            configureViewOnLoading()
        }
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginView()
    }

    //MARK: Private methods
    private func removeSubViews() {
        for view in self.view.subviews {
            if view is LoginView {
                view.removeFromSuperview()
            }
            
            if view is EmailView {
                view.removeFromSuperview()
            }
        }
    }
    
    private func configureLoginView() {
        loginView = LoginView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        loginView.fixInView(self.view)
        loginView.loginViewDelegate = self
        isAuthenticatedUserAvailable = loginView.isAuthenticatedUserAvailable()
    }
    
    //MARK: Public methods
    func configureEmailView() {
        emailView = EmailView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        emailView.fixInView(self.view)
        emailView.emailViewDelegate = self
    }
}

//MARK: LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    func didTapSignInEmail(view: LoginView) {
        removeSubViews()
        configureEmailView()
    }
}

//MARK: EmailViewDelegate
extension LoginViewController: EmailViewDelegate {
    func didTapBack(view: EmailView) {
        removeSubViews()
        configureLoginView()
    }
    
    func didTapSignIn(view: EmailView, email: String, password: String) {
        loginView.didTapSignInOnEmailView(view: view, email: email, password: password)
    }
}

extension LoginViewController {
    func configureViewOnLoading() {
        removeSubViews()
        if isAuthenticatedUserAvailable {
            print("next")
        } else {
            configureLoginView()
        }
    }
}
