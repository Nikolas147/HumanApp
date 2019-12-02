//
//  EditViewController.swift
//  HumanApp
//
//  Created by Aleksey on 22/11/2019.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    var fileManager = FileHuman()
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var textField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.layer.cornerRadius = 10
    }
    
    @IBAction func editItem(_ sender: Any) {
        guard let number = Int(textField.text!) else {
            showAlert(message: "Введите номер пользователя")
            return
        }
        
        guard number <= fileManager.peopleCount() && number > 0 else {
            showAlert(message: "Такого пользователя нет")
            return
        }
        
        if let viewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            viewController.newHuman = fileManager.getHuman(for: number - 1)
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Внимание!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Исправить", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
