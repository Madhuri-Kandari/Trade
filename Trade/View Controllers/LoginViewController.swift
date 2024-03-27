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
    private var phoneNumberView: PhoneNumberView!
    private var otpView: OTPView!
    
    private var isLoggedInUser: Bool = false {
        didSet {
            removeSubViews()
            print("Home")
        }
    }
    
    private var phoneNumber: String = ""
    
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
            
            if view is PhoneNumberView {
                view.removeFromSuperview()
            }
            
            if view is OTPView {
                view.removeFromSuperview()
            }
        }
    }
    
    private func configureLoginView() {
        loginView = LoginView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        loginView.fixInView(self.view)
        loginView.loginViewDelegate = self
        
        isLoggedInUser = loginView.isAuthenticatedUserAvailable()
    }

    private func configureEmailView() {
        emailView = EmailView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        emailView.fixInView(self.view)
        emailView.emailViewDelegate = self
    }
    
    private func configurePhoneNumberView() {
        phoneNumberView = PhoneNumberView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        phoneNumberView.fixInView(self.view)
        phoneNumberView.phoneNumberViewDelegate = self
    }
    
    private func configureOTPView() {
        otpView = OTPView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        otpView.fixInView(self.view)
        otpView.otpViewDelegate = self
        otpView.phoneNumber = phoneNumber
    }
}

//MARK: LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    func didTapSignInEmail(view: LoginView) {
        removeSubViews()
        configureEmailView()
    }
    
    func didTapSignInPhoneNumber(view: LoginView) {
        removeSubViews()
        configurePhoneNumberView()
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

extension LoginViewController: PhoneNumberViewDelegate {
    
    func didTapBack(view: PhoneNumberView) {
        removeSubViews()
        configureLoginView()
    }
    
    func didTapSignInOnPhoneNumberView(view: PhoneNumberView, phoneNumber: String) {
        loginView.didTapGetOTPView(phoneNumber: phoneNumber) { [weak self] isSuccess in
            guard isSuccess else {
                return
            }
            self?.removeSubViews()
            self?.phoneNumber = phoneNumber
            self?.configureOTPView()
        }
    }
}

extension LoginViewController: OTPViewDelegate {
    func didClickLoginInOTPView(view: OTPView, smsCode: String) {
        loginView.verifyOTP(otp: smsCode) { [weak self] isSuccess in
            guard isSuccess else {
                return
            }
            self?.isLoggedInUser = true
            self?.removeSubViews()
        }
    }
    
   
    func didClickEditPhoneNumber(view: OTPView) {
        removeSubViews()
        configurePhoneNumberView()
    }
}
