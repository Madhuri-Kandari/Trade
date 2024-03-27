//
//  MyTextField.swift
//  Trade
//
//  Created by Chandana Sudha Madhuri Kandari on 27/03/24.
//

import UIKit

protocol MyTextFieldDelegate: AnyObject {
    func didClickBackSpace(textField: MyTextField)
}

class MyTextField: UITextField {

    weak var myTextFieldDelegate: MyTextFieldDelegate?
    override func deleteBackward() {
        super.deleteBackward()
        myTextFieldDelegate?.didClickBackSpace(textField: self)
    }

}
