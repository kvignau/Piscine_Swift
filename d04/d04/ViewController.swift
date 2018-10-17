//
//  ViewController.swift
//  d04
//
//  Created by Kevin VIGNAU on 10/5/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APITwitterDelegate, UISearchBarDelegate {

    // connect to api
    let CUSTOMER_KEY: String = ""
    let CUSTOMER_SECRET: String = ""
    var token: String?
    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as? TweetTableViewCell
        cell?.tweet = tweets[indexPath.row]
        return cell!
    }
    
    func handleTweet(tweets: [Tweet]) {
        self.tweets = tweets
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func errorTweet(err: Error) {
        let error = UIAlertController(title: "Oula !", message: err.localizedDescription, preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(error, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getToken()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text {
            searchBar.endEditing(true)
            if let token = self.token {
                let apiController = APIController(delegate: self, token: token)
                apiController.searchTweet(search: search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            }
            else {
                let error = UIAlertController(title: "Not authenticate", message: "Token not available", preferredStyle: UIAlertControllerStyle.alert)
                error.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(error, animated: true, completion: nil)
            }
        }
    }

    func getToken()
    {
        let BEARER: String = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        let url = URL(string: "https://api.twitter.com/oauth2/token")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                let error = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                error.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(error, animated: true, completion: nil)
            }
            else if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        self.token = dic["access_token"] as? String
                    }
                }
                catch (let err) {
                    let error = UIAlertController(title: "Token not found", message: err.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    error.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(error, animated: true, completion: nil)
                }
            }
        }
        task.resume()
    }
}

