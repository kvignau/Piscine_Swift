//
//  ViewController.swift
//  d00
//
//  Created by Kevin VIGNAU on 10/1/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen:Double = 0
    var previousNumber:Double = 0
    var operand:Int = 0
    var operation:Bool = false
    @IBOutlet weak var labelHello: UILabel!
    
    @IBAction func clickButton(_ sender: UIButton) {
        if (operation == true)
        {
            labelHello.text = ""
            previousNumber = numberOnScreen
            labelHello.text = labelHello.text! + sender.currentTitle!
            numberOnScreen = Double(labelHello.text!)!
            operation = false
        }
        else
        {
            if (labelHello.text == "0")
            {
                labelHello.text = sender.currentTitle!
            }
            else
            {
                labelHello.text = labelHello.text! + sender.currentTitle!
            }
            numberOnScreen = Double(labelHello.text!)!
        }
    }
    
    @IBAction func operands(_ sender: UIButton) {
        if (sender.tag == 12)
        {
            numberOnScreen = numberOnScreen * -1
            labelHello.text = String(numberOnScreen)
            let test = labelHello.text!.split(separator: ".", maxSplits: 1)
            if (test.count >= 2 && String(test[1]) == "0")
            {
                labelHello.text = String(test[0])
            }
        }
        else if (sender.tag == 11)
        {
            labelHello.text = "0"
            operand = 0
            numberOnScreen = 0
            previousNumber = 0
            operation = false
        }
        else
        {
            if (sender.tag == 17 || (previousNumber != 0 && numberOnScreen != 0))
            {
                if (operand == 13)
                {
                    labelHello.text = String(previousNumber + numberOnScreen)
                }
                else if (operand == 14)
                {
                    labelHello.text = String(previousNumber * numberOnScreen)
                }
                else if (operand == 15)
                {
                    labelHello.text = String(previousNumber - numberOnScreen)
                }
                else if (operand == 16)
                {
                    if (numberOnScreen != 0)
                    {
                        labelHello.text = String(previousNumber / numberOnScreen)
                    }
                    else
                    {
                        numberOnScreen = 0
                        previousNumber = 0
                        labelHello.text = "0"
                    }
                }
                numberOnScreen = Double(labelHello.text!)!
                previousNumber = 0
                let test = labelHello.text!.split(separator: ".", maxSplits: 1)
                if (test.count >= 2 && String(test[1]) == "0")
                {
                    labelHello.text = String(test[0])
                }
            }
            if (sender.tag == 17)
            {
                numberOnScreen = Double(labelHello.text!)!
                operation = true
                operand = 0
            }
            else
            {
                operand = sender.tag
                operation = true
            }
        }
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

