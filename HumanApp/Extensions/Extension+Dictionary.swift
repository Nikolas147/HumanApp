//
//  Extension+Dictionary.swift
//  HumanApp
//
//  Created by Aleksey on 24/11/2019.
//  Copyright © 2019 Aleksey. All rights reserved.
//

extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}
