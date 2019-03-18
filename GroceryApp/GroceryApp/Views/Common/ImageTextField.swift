//
//  imageTextField.swift
//  GroceryApp
//
//  Created by Jonathan on 10/27/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit

protocol ImageTextFieldDelegate: class {
    func imageTextField(_ imageTextField: ImageTextField, textChanged text: String)
    func imageTextFieldShouldReturn(_ imageTextField: ImageTextField) -> Bool
}

class ImageTextField: UITextField {

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }

    var leftPadding: CGFloat = 8

    var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }

    weak var imageTextFieldDelegate: ImageTextFieldDelegate? {
        didSet {
            super.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            self.delegate = self
        }
    }

    private func updateView() {
        if let image = leftImage {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            leftView = imageView
        } else {
            leftViewMode = .never
            leftView = nil
        }
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        self.imageTextFieldDelegate?.imageTextField(self, textChanged: textField.text ?? "")
    }

}

extension ImageTextField: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.imageTextFieldDelegate?.imageTextFieldShouldReturn(self) ?? true
    }

}
