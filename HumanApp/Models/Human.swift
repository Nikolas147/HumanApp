//
//  HumanModel.swift
//  HumanApp
//
//  Created by Aleksey on 19/11/2019.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import Foundation

struct Human {
    
    var number: Int = 0
    var surname: String = ""
    var name: String = ""
    var patronymic: String = ""
    var attributes: [String: String] = ["":""]

}

// MARK: - Work with JSON
extension Human {
    
    var json : [String: Any] {
         get {
             var dict : [String: Any] = [:]
             dict["number"] = self.number
             dict["surname"] = self.surname
             dict["name"] = self.name
             dict["patronymic"] = self.patronymic
             dict["attributes"] = self.attributes
             return dict
         }
     }
     
     static func parse (json: [String: Any]) -> Human? {
         guard
             let number = json["number"] as? Int,
             let surname = json["surname"] as? String,
             let name = json["name"] as? String,
             let patronymic = json["patronymic"] as? String,
             let attributes = json["attributes"] as? [String: String] else {
                 return nil
         }
         
         return Human(number: number,
                     surname: surname,
                     name: name,
                     patronymic: patronymic,
                     attributes: attributes
        )
     }
}
