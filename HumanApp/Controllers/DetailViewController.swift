//
//  AddViewController.swift
//  HumanApp
//
//  Created by Aleksey on 19/11/2019.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var fileManager = FileHuman()
    var newHuman = Human()
    var numberOfAttributes = 0
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 20
        numberOfAttributes = newHuman.attributes.count
        
        setuTableView()
    }
    
    func setuTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: StandardTableCell.reuseId, bundle: nil), forCellReuseIdentifier: StandardTableCell.reuseId)
        tableView.register(UINib(nibName: AttributeTableCell.reuseId, bundle: nil), forCellReuseIdentifier: AttributeTableCell.reuseId)
    }
    

    @IBAction func save(_ sender: Any) {
        let surname = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! StandardTableCell).valueTextField.text!
        
        let name = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! StandardTableCell).valueTextField!.text!
        
        let patronymic = (tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! StandardTableCell).valueTextField!.text!
        
        guard
            surname != "",
            name != "",
            patronymic != "" else {
                showAlert(message: "Заполните все стандартные поля")
                return
        }
                
        var attributes: [String: String] = [:]
        
        for counter in 0..<tableView.numberOfRows(inSection: 1) {
            let attName = (tableView.cellForRow(at: IndexPath(row: counter, section: 1)) as! AttributeTableCell).nameTextField.text!
            
            let attValue = (tableView.cellForRow(at: IndexPath(row: counter, section: 1)) as! AttributeTableCell).valueTextField.text!
            
            guard
                attName != "",
                attValue != "" else {
                    showAlert(message: "У вас остались пустые атрибуты. Заполните или удалите их")
                    return
            }
            
            attributes.updateValue(attValue, forKey: attName)
        }
        
        newHuman = Human(number: newHuman.number, surname: surname, name: name, patronymic: patronymic, attributes: attributes)
        
        if newHuman.number == 0{
            fileManager.add(newHuman)
        } else {
            fileManager.update(newHuman)
        }
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func abbButton(_ sender: Any) {
        numberOfAttributes += 1
        tableView.reloadData()
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

// MARK: - Work with TableView

extension DetailViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        } else {
            return numberOfAttributes
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = #colorLiteral(red: 0.5145198703, green: 0.3922268152, blue: 0.9032761455, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont(name: "Apple SD Gothic Neo-SemiBold", size: 18.0)
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if newHuman.number != 0 {
            // редактирование пользователя
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: StandardTableCell.reuseId) as! StandardTableCell
                
                switch indexPath.row {
                case 0:
                    cell.nameLabel.text = "Фамилия"
                    cell.valueTextField?.text = newHuman.surname
                case 1:
                    cell.nameLabel.text = "Имя"
                    cell.valueTextField?.text = newHuman.name
                case 2:
                    cell.nameLabel.text = "Отчество"
                    cell.valueTextField?.text = newHuman.patronymic
                default:
                    cell.nameLabel.text = "Error"
                }
                
                return cell
            } else if indexPath.row < newHuman.attributes.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: AttributeTableCell.reuseId) as! AttributeTableCell
                
                cell.nameTextField.text = newHuman.attributes[indexPath.row].key
                cell.valueTextField.text = newHuman.attributes[indexPath.row].value
                
                return cell
            } else {
                return tableView.dequeueReusableCell(withIdentifier: AttributeTableCell.reuseId) as! AttributeTableCell
            }
            
        } else {
            // создание нового
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: StandardTableCell.reuseId) as! StandardTableCell
                
                switch indexPath.row {
                case 0:
                    cell.nameLabel.text = "Фамилия"
                case 1:
                    cell.nameLabel.text = "Имя"
                case 2:
                    cell.nameLabel.text = "Отчество"
                default:
                    cell.nameLabel.text = "Error"
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AttributeTableCell.reuseId) as! AttributeTableCell
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Стандратные параметры"
        } else {
            return "Атрибуты"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if editingStyle == .delete {
                tableView.beginUpdates()
                self.numberOfAttributes -= 1
                tableView.deleteRows(at: [indexPath], with: .left)
                tableView.endUpdates()
                if indexPath.row < self.newHuman.attributes.count {
                    let key = self.newHuman.attributes[indexPath.row].key
                    self.newHuman.attributes.removeValue(forKey: key)
                }
            }
        }
    }
}
