//
//  APIController.swift
//  d04
//
//  Created by Kevin VIGNAU on 10/5/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class APIController {
    weak var delegate: APITwitterDelegate?
    let token: String
    var tweets: [Tweet] = []
    
    init(delegate: APITwitterDelegate?, token: String)
    {
        self.delegate = delegate
        self.token = token
    }
    
    func searchTweet(search: String)
    {
        let url = URL(string : "https://api.twitter.com/1.1/search/tweets.json?q=" + search + "&lang=fr&count=100&result_type=recent")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset-UTF-8", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let err = error {
                DispatchQueue.main.async() {
                    let error = NSError(domain:"Error: \(err.localizedDescription)", code: 400, userInfo:nil)
                    self.delegate?.errorTweet(err: error)
                }
            }
            else if let d = data {
                do {
                    if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
                        if let allTweet: [[String:AnyObject]] = dic["statuses"] as? [[String:AnyObject]] {
                            if allTweet.count == 0
                            {
                                DispatchQueue.main.async() {
                                    let noData = NSError(domain:"No data for your research: \(String(describing: search.removingPercentEncoding!))", code: 204, userInfo:nil)
                                    self.delegate?.errorTweet(err: noData)
                                }
                            }
                            for elem in allTweet {
                                let name = elem["user"]!["screen_name"] as! String
                                let tmpDate = allTweet[0]["created_at"] as! String
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
                                let dateDate = dateFormatter.date(from: tmpDate)
                                dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
                                dateFormatter.locale = Locale(identifier: "FR-fr")
                                let date = dateFormatter.string(from: dateDate!)
                                
                                let text = elem["text"] as! String
                                self.tweets.append(Tweet(name: name, date: date, text: text))
                            }
                            self.delegate?.handleTweet(tweets: self.tweets)
                        }
                    }
                }
                catch (let err) {
                    DispatchQueue.main.async() {
                        let error = NSError(domain:"Error: \(err.localizedDescription)", code: 500, userInfo:nil)
                        self.delegate?.errorTweet(err: error)
                    }
                }
            }
        }
        task.resume()
    }
}
