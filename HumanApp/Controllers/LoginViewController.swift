//
//  ViewController.swift
//  HumanApp
//
//  Created by Aleksey on 18/11/2019.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var animationDuration: Double = 2.0
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        enterButton.layer.cornerRadius = 5
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        progressBar.progress = 0
        errorLabel.text = " "
    }
    
    
    @IBAction func loginIn(_ sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        UIView.animate(withDuration: animationDuration) {
            self.progressBar.progress = 1
            self.progressBar.frame.size.height += 0
            self.errorLabel.text = " "
        }
        
        if email == "" || isValidateEmail(email: email) {
            checkError(message: "Введен не верный E-mail")
        } else if password == "" || password.count < 5 {
            checkError(message: "Введен не верный пароль")
        } else {
            errorLabel.text = " "
            
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                self.progressBar.progress = 0
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func checkError(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            self.progressBar.progress = 0
            self.errorLabel.text = message
        }
    }
    
    func isValidateEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return !emailPredicate.evaluate(with: email)
    }
}

// MARK: - TextField Delegation
extension ViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}



