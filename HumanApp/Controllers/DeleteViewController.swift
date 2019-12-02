//
//  DeleteViewController.swift
//  HumanApp
//
//  Created by Aleksey on 22/11/2019.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import UIKit

class DeleteViewController: UIViewController {
    
    var fileManager = FileHuman()
    
    @IBOutlet weak var textField: CustomTextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.layer.cornerRadius = 10
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        guard let number = Int(textField.text!) else {
            showAlert(message: "Введите номер пользователя")
            return
        }
        
        guard number <= fileManager.peopleCount() && number > 0 else {
            showAlert(message: "Такого пользователя нет")
            return
        }
        
        dismiss(animated: true, completion: nil)
        fileManager.remove(with: number)
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
