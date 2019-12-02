//
//  CustomTextField.swift
//  HumanApp
//
//  Created by Aleksey on 18/11/2019.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import UIKit
class CustomTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

}
