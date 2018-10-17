//
//  AddViewController.swift
//  d02
//
//  Created by Kevin VIGNAU on 10/3/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descTextField: UITextView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveunWindSegue" {
            // TEST IF EMPTY FIELD
            if (nameTextFiled.text != nil && descTextField.text != nil)
            {
                if (!(nameTextFiled.text!.isEmpty)) {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
                    dateFormatter.locale = Locale(identifier: "FR-fr")
                    let dateTxt = dateFormatter.string(from: datePicker.date)
                    print("All data from form -> [name: \(nameTextFiled.text!), date:\(dateTxt), description:\(descTextField.text!)]")
                    Data.Death.append((nameTextFiled.text!, dateTxt, descTextField.text!))
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func backButton() {
        performSegue(withIdentifier: "saveunWindSegue", sender: self)
    }
}
