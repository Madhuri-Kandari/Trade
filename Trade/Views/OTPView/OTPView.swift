//
//  OTPView.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 26/03/24.
//

import UIKit

protocol OTPViewDelegate: AnyObject {
    func didClickEditPhoneNumber(view: OTPView)
    func didClickLoginInOTPView(view: OTPView, smsCode: String)
}

class OTPView: UIView {

    weak var otpViewDelegate: OTPViewDelegate?
    var phoneNumber: String = "" {
        didSet {
            showPhoneNumberOutlet.text = "Edit? \(phoneNumber)"
        }
    }
    
    @IBOutlet weak var showPhoneNumberOutlet: UILabel!
    
    @IBOutlet weak var loginButtonOutlet: UIButton! {
        didSet {
            loginButtonOutlet.layer.cornerRadius = 20
        }
    }
    
    
    @IBOutlet weak var firstDigitOutlet: MyTextField!
    @IBOutlet weak var secondDigitOutlet: MyTextField!
    @IBOutlet weak var thirdDigitOutlet: MyTextField!
    @IBOutlet weak var fourthDigitOutlet: MyTextField!
    @IBOutlet weak var fifthDigitOutlet: MyTextField!
    @IBOutlet weak var sixthDigitOutlet: MyTextField!
    
    @IBAction func editPhoneNumberAction(_ sender: UIButton) {
        otpViewDelegate?.didClickEditPhoneNumber(view: self)
    }
    
    @IBAction func firstDigitAction(_ sender: MyTextField) {
        secondDigitOutlet.becomeFirstResponder()
    }
    
    @IBAction func secondDigitAction(_ sender: MyTextField) {
        thirdDigitOutlet.becomeFirstResponder()
    }
    @IBAction func thirdDigitAction(_ sender: MyTextField) {
        fourthDigitOutlet.becomeFirstResponder()
    }
    @IBAction func fourthDigitAction(_ sender: MyTextField) {
        fifthDigitOutlet.becomeFirstResponder()
    }
    @IBAction func fifthDigitAction(_ sender: MyTextField) {
        sixthDigitOutlet.becomeFirstResponder()
    }
    @IBAction func sixthDigitAction(_ sender: MyTextField) {
        sixthDigitOutlet.resignFirstResponder()
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        var smsCode = (firstDigitOutlet.text ?? "") + (secondDigitOutlet.text ?? "") + (thirdDigitOutlet.text ?? "") + (fourthDigitOutlet.text ?? "")
        smsCode += (fifthDigitOutlet.text ?? "")
        smsCode += (sixthDigitOutlet.text ?? "")
        if smsCode.count == 6 {
            otpViewDelegate?.didClickLoginInOTPView(view: self, smsCode: smsCode)
        }
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
        guard let view = Bundle.main.loadNibNamed("OTPView", owner: self, options: nil)?.first as? UIView else { fatalError() }
        view.fixInView(self)
        firstDigitOutlet.becomeFirstResponder()
        firstDigitOutlet.myTextFieldDelegate = self
        secondDigitOutlet.myTextFieldDelegate = self
        thirdDigitOutlet.myTextFieldDelegate = self
        fourthDigitOutlet.myTextFieldDelegate = self
        fifthDigitOutlet.myTextFieldDelegate = self
        sixthDigitOutlet.myTextFieldDelegate = self
    }
}

extension OTPView: MyTextFieldDelegate {
    func didClickBackSpace(textField: MyTextField) {
        switch textField {
        case sixthDigitOutlet:
            fifthDigitOutlet.becomeFirstResponder()
        case fifthDigitOutlet:
            fourthDigitOutlet.becomeFirstResponder()
        case fourthDigitOutlet:
            thirdDigitOutlet.becomeFirstResponder()
        case thirdDigitOutlet:
            secondDigitOutlet.becomeFirstResponder()
        case secondDigitOutlet, firstDigitOutlet:
            firstDigitOutlet.becomeFirstResponder()
        default:
            break
        }
    }
}
