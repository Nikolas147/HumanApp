//
//  StandardTableCell.swift
//  HumanApp
//
//  Created by Aleksey on 19/11/2019.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import UIKit

class StandardTableCell: UITableViewCell {
    
    static let reuseId = "StandardTableCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
