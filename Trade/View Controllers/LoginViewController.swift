//
//  ViewController.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 16/03/24.
//

import UIKit

class LoginViewController: UIViewController {

    
    private var loginView: LoginView!
    private var emailView: EmailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginView()
    }

    private func configureLoginView() {
        loginView = LoginView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        loginView.fixInView(self.view)
        loginView.loginViewDelegate = self
    }
    
    func configureEmailView() {
        emailView = EmailView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        emailView.fixInView(self.view)
        emailView.emailViewDelegate = self
    }
    
    private func removeSubViews() {
        if let view = self.view.subviews.first as? LoginView {
            view.removeFromSuperview()
        }
    }

}

extension LoginViewController: LoginViewDelegate {
    func didTapSignInEmail(view: LoginView) {
        removeSubViews()
        configureEmailView()
    }
}

extension LoginViewController: EmailViewDelegate {
    func didTapBack(view: EmailView) {
        removeSubViews()
        configureLoginView()
    }
}
