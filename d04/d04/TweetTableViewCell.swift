//
//  TweetTableViewCell.swift
//  d04
//
//  Created by Kevin VIGNAU on 10/5/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var tweet : Tweet?{
        didSet {
            if let t = tweet {
                descLabel?.text = t.description
                nameLabel?.text = t.name
                dateLabel?.text = t.date
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
