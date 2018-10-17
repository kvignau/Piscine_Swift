//
//  APITweetDelegate.swift
//  d04
//
//  Created by Kevin VIGNAU on 10/5/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {
    func handleTweet(tweets: [Tweet])
    func errorTweet(err: Error)
}
