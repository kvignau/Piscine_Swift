//
//  ViewController.swift
//  d02
//
//  Created by Kevin VIGNAU on 10/3/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var deathNoteTableView: UITableView!
    @IBOutlet weak var tableViewAllInfo: UITableView!
    
    @IBAction func myUnWindSegue(segue: UIStoryboardSegue) {
        if let segueId = segue.identifier
        {
            if (segueId == "saveunWindSegue")
            {
                tableViewAllInfo.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.Death.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deathCell") as! TableViewCell
        cell.death = Data.Death[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

