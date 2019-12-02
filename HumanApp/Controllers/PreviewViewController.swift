//
//  PreviewViewController.swift
//  HumanApp
//
//  Created by Aleksey on 20/11/2019.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    let reuseId = "Cell"
    var people: [Human] = []
    var fileManager = FileHuman()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        people = fileManager.loadFromFile()
        tableView.reloadData()
    }
    
}

// MARK: - Work with TableView

extension PreviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for i in 0..<people.count {
            if section == i {
                return 3 + people[i].attributes.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = #colorLiteral(red: 0.5145198703, green: 0.3922268152, blue: 0.9032761455, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont(name: "Apple SD Gothic Neo-SemiBold", size: 18.0)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for i in 0..<people.count {
            if section == i {
                return "Пользователь номер: \(people[i].number)"
            }
        }
        return "Error value"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseId)
        if cell == nil  {
            cell = UITableViewCell(style: .value1, reuseIdentifier: reuseId)
        }
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "Фамилия"
            cell?.detailTextLabel?.text = people[indexPath.section].surname
        case 1:
            cell?.textLabel?.text = "Имя"
            cell?.detailTextLabel?.text = people[indexPath.section].name
        case 2:
            cell?.textLabel?.text = "Отчество"
            cell?.detailTextLabel?.text = people[indexPath.section].patronymic
        default:
            cell?.textLabel?.text = people[indexPath.section].attributes[indexPath.row - 3].key
            cell?.detailTextLabel?.text = people[indexPath.section].attributes[indexPath.row - 3].value
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            let number = indexPath.section
                    viewController.newHuman = fileManager.getHuman(for: number)
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true, completion: nil)
                }
    }
    
}
