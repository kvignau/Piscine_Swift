//
//  ModelTweet.swift
//  d04
//
//  Created by Kevin VIGNAU on 10/5/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import Foundation


struct Tweet {
    let name: String
    let date: String
    let text: String
}

extension Tweet: CustomStringConvertible {
    var description: String {
        return "\(name) + \(text)"
    }
}
