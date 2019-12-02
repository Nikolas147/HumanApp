//
//  ModifyViewController.swift
//  HumanApp
//
//  Created by Aleksey on 19/11/2019.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import UIKit

class ModifyViewController: UIViewController {
    
    var fileManager = FileHuman()
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonsView()
    }
    
    func setupButtonsView() {
        addButton.layer.cornerRadius = 15
        deleteButton.layer.cornerRadius = 15
        editButton.layer.cornerRadius = 15
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countLabel.text = String(fileManager.peopleCount())
    }

    @IBAction func showAdd(_ sender: Any) {
        if let viewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func showDelete(_ sender: Any) {
        if let viewController = self.storyboard!.instantiateViewController(withIdentifier: "DeleteViewController") as? DeleteViewController {
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func showEdit(_ sender: Any) {
        if let viewController = self.storyboard!.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController {
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    

}
