//
//  EmailView.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 18/03/24.
//

import UIKit

protocol EmailViewDelegate: AnyObject {
    func didTapBack(view: EmailView)
}

class EmailView: UIView {
    
    weak var emailViewDelegate: EmailViewDelegate?

    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var backOutlet: UIButton! {
        didSet {
            backOutlet.layer.cornerRadius = 20
        }
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        emailViewDelegate?.didTapBack(view: self)
    }
    
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
    }
}
