//
//  FileHuman.swift
//  HumanApp
//
//  Created by Aleksey on 20/11/2019.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import Foundation

class FileHuman {
    
    let filename: String = "TempFileForHumanApp"
    private(set) var people : [Human] = []
    
    public func add (_ human: Human) {
        people = loadFromFile()
        var human = human
        human.number = people.count + 1
        people.append(human)
        saveToFile()
    }
    
    public func getHuman(for number: Int) -> Human {
        people = loadFromFile()
        return people[number]
    }
    
    public func peopleCount() -> Int {
        people = loadFromFile()
        return people.count
    }
    
    public func update(_ human: Human) {
        people = loadFromFile()
        people[human.number - 1] = human
        saveToFile()
    }
    
    public func remove(with number: Int) {
        people = loadFromFile()
        people.removeAll(where: {
            $0.number == number
        })
        if number < people.count + 1 {
            for index in number...people.count {
                people[index - 1].number = index
            }
        }
        
        saveToFile()
    }
    
    // MARK: - Work with file
    
    public func saveToFile() {
        var tempArray : Array<Any> = []
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        let filePath = path!.path + "/" + "\(filename).json"
        
        if !FileManager.default.fileExists(atPath: path!.path) {
            do {
                try FileManager.default.createDirectory(at: path!, withIntermediateDirectories: true, attributes:nil)
            } catch let error {
                print("Error create directory: \(error)")
            }
        }
        
        for human in people {
            tempArray.append(human.json)
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: tempArray, options: .prettyPrinted)
            FileManager.default.createFile(atPath: filePath, contents: jsonData, attributes: nil)
        } catch let error {
            print("JSON data error: \(error)")
        }
    }
    
    public func loadFromFile() -> [Human] {
        people.removeAll()
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        let filePath = path!.path + "/" + "\(filename).json"
        if !FileManager.default.fileExists(atPath: filePath){
            print("Path error! File doesn't exist")
        } else {
            let data = FileManager.default.contents(atPath: filePath) ?? nil
            
            do {
                let decoded = try JSONSerialization.jsonObject(with: data!, options: []) as! Array<Any>
                
                for item in decoded {
                    people.append(Human.parse(json: item as! [String : Any])!)
                }
            } catch let error {
                print("JSON decoded error: \(error)")
            }
        }
        
        return people
    }
    
}
