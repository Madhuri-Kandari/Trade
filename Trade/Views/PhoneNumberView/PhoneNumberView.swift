//
//  PhoneNumberView.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 26/03/24.
//

import UIKit

protocol PhoneNumberViewDelegate: AnyObject {
    func didTapSignInOnPhoneNumberView(view: PhoneNumberView, phoneNumber: String)
    func didTapBack(view: PhoneNumberView)
}

class PhoneNumberView: UIView {
    
    weak var phoneNumberViewDelegate: PhoneNumberViewDelegate?

    @IBOutlet weak var backButtonOutlet: UIButton! {
        didSet {
            backButtonOutlet.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var getOTPOutlet: UIButton! {
        didSet {
            getOTPOutlet.layer.cornerRadius = 20
            getOTPOutlet.isEnabled = false
        }
    }
    
    @IBOutlet weak var phoneNumberTextfieldOutlet: UITextField!
    
    
    @IBAction func getOTPAction(_ sender: UIButton) {
        guard let text = phoneNumberTextfieldOutlet.text else {
            return
        }
        getOTPOutlet.isEnabled = true
        phoneNumberViewDelegate?.didTapSignInOnPhoneNumberView(view: self, phoneNumber: text)
    }
    @IBAction func backAction(_ sender: UIButton) {
        phoneNumberViewDelegate?.didTapBack(view: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = Bundle.main.loadNibNamed("PhoneNumberView", owner: self, options: nil)?.first as? UIView else {
            fatalError()
        }
        view.fixInView(self)
        phoneNumberTextfieldOutlet.delegate = self
    }
    
    private func validatePhoneNumber() {
        guard let text = phoneNumberTextfieldOutlet.text, !text.isEmpty else {
            getOTPOutlet.isEnabled = false
            return
        }
        getOTPOutlet.isEnabled = true
    }

}

extension PhoneNumberView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validatePhoneNumber()
        return true
    }
}
