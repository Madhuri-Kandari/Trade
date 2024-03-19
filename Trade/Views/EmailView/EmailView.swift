//
//  EmailView.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 18/03/24.
//

import UIKit

//MARK: EmailViewDelegate
protocol EmailViewDelegate: AnyObject {
    func didTapBack(view: EmailView)
    func didTapSignIn(view: EmailView, email: String, password: String)
}

class EmailView: UIView {
    //MARK: Properties
    weak var emailViewDelegate: EmailViewDelegate?

    //MARK: IBOutlets
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var signInOutlet: UIButton! {
        didSet {
            signInOutlet.isEnabled = false
        }
    }
    @IBOutlet weak var backOutlet: UIButton! {
        didSet {
            backOutlet.layer.cornerRadius = 20
        }
    }
    
    //MARK: IBActions
    @IBAction func signInAction(_ sender: UIButton) {
        guard let email = emailTextFieldOutlet.text else { return }
        guard let password = passwordTextFieldOutlet.text else { return }
        emailViewDelegate?.didTapSignIn(view: self, email: email, password: password)
    }
    @IBAction func backAction(_ sender: UIButton) {
        emailViewDelegate?.didTapBack(view: self)
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
        guard let subView = Bundle.main.loadNibNamed("EmailView", owner: self, options: nil)?.first as? UIView else { return }
        subView.fixInView(self)
        emailTextFieldOutlet.delegate = self
        passwordTextFieldOutlet.delegate = self
    }
    
    private func validateEmail() {
        guard let text = emailTextFieldOutlet.text else {
            signInOutlet.isEnabled = false
            return
        }
        signInOutlet.isEnabled = true
    }
    
    private func validatePassword() {
        guard let text = passwordTextFieldOutlet.text else {
            signInOutlet.isEnabled = false
            return
        }
        signInOutlet.isEnabled = true
    }
}

extension EmailView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateEmail()
        validatePassword()
    }
}
