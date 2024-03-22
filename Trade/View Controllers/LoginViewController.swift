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
        
        if loginView.isAuthenticatedUserAvailable() {
            removeSubViews()
            print("Settings screen")
        }
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
