//
//  FirstViewController.swift
//  d05
//
//  Created by Kevin VIGNAU on 10/8/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var places: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        places = (tabBarController  as! TabBarViewController).places
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placesCell")
        cell?.textLabel?.text = places[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (tabBarController  as! TabBarViewController).myBool = true
        (tabBarController  as! TabBarViewController).index = indexPath.row
    }
}

