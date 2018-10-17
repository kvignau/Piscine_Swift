//
//  ViewController.swift
//  d07
//
//  Created by Kevin VIGNAU on 10/10/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit
import ForecastIO
import RecastAI

class ViewController: UIViewController, UITextFieldDelegate {

    var bot : RecastAIClient?
    var foreCast: DarkSkyClient?
    var location: Location?

    let token = ""
    let apiKey = ""
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBAction func snedQuestion(_ sender: UIButton?) {
        guard let question = questionTextField.text, !question.isEmpty else { return }
        self.questionTextField.endEditing(true)
        guard let bot = self.bot else { return }
        bot.textRequest(question, successHandler: { (response) in
            guard let resp = response.entities!["location"] as? [NSDictionary], let myLat = resp[0]["lat"], let myLng = resp[0]["lng"] else { self.weatherLabel.text = "No Result"; return }
            
            self.foreCast!.getForecast(latitude: myLat as! Double, longitude: myLng as! Double) { result in
                switch result {
                case .success(let currentForecast, _):
                    guard let weather = currentForecast.currently?.summary else { print("weather undifined"); return }
                    DispatchQueue.main.async {
                        self.weatherLabel.text = weather
                    }
                case .failure(_):
                    if let error = result.error {
                        print(error.localizedDescription)
                    }
                }
            }
        }, failureHandle: { (error) in
            print(error.localizedDescription)
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        snedQuestion(nil)
        textField.endEditing(true)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bot = RecastAIClient(token : token, language: "fr")
        self.foreCast = DarkSkyClient(apiKey: apiKey)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

