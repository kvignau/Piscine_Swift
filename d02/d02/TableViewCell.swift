//
//  TableViewCell.swift
//  d02
//
//  Created by Kevin VIGNAU on 10/3/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var death : (String, String, String)?{
        didSet {
            if let d = death {
                dateLabel?.text = d.1
                nameLabel?.text = d.0
                descLabel?.text = d.2
            }
        }
    }

}
