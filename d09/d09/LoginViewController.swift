//
//  ViewController.swift
//  d09
//
//  Created by Kevin VIGNAU on 10/12/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    let context = LAContext()
    
    @IBAction func authenticate(_ sender: UIButton) {
        authenticationWithTouchID()
    }
    
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
        
        var authError: NSError?
        let reasonString = "To access the secure data"
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
                
                if success {
                    self.performSegue(withIdentifier: "loggedIn", sender: self)
                } else {
                    //TODO: User did not authenticate successfully, look at error and take appropriate action
                    guard let error = evaluateError else {
                        return
                    }
                    print(error)
                }
            }
        } else {
            
            guard let error = authError else {
                return
            }
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authenticationWithTouchID()
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

