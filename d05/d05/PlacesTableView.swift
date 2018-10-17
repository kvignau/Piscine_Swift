//
//  PlacesTableViewTableViewCell.swift
//  d05
//
//  Created by Kevin VIGNAU on 10/8/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class PlacesTableView: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    
    var place : Place?{
        didSet {
            if let p = place {
                placeLabel?.text = p.name
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
