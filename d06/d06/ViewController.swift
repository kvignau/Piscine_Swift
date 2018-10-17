//
//  ViewController.swift
//  d06
//
//  Created by Kevin VIGNAU on 10/9/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var dynamicAnimator: UIDynamicAnimator!
    let gravityBehavior = UIGravityBehavior()
    let collisionBehavior = UICollisionBehavior()
    let elasticityBehavior = UIDynamicItemBehavior()
    
    let motionManager = CMMotionManager()
    
    func addConstraint(newObj: Object) {
        gravityBehavior.addItem(newObj)
        elasticityBehavior.addItem(newObj)
        collisionBehavior.addItem(newObj)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(recognizer:)))
        newObj.addGestureRecognizer(panGesture)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureHandler(recognizer:)))
        newObj.addGestureRecognizer(pinchGesture)
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateGestureHandler(recognizer:)))
        newObj.addGestureRecognizer(rotateGesture)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        let myObject = Object(x: sender.location(in: view).x, y: sender.location(in: view).y)
        view.addSubview(myObject)
        addConstraint(newObj: myObject)
    }
    
    @objc func panGestureHandler(recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .began:
            gravityBehavior.removeItem(recognizer.view!)
            elasticityBehavior.removeItem(recognizer.view!)
        case .changed:
            collisionBehavior.removeItem(recognizer.view!)
            recognizer.view?.center = CGPoint(x: recognizer.location(in: view).x, y: recognizer.location(in: view).y)
            collisionBehavior.addItem(recognizer.view!)
        case .ended:
            gravityBehavior.addItem(recognizer.view!)
            elasticityBehavior.addItem(recognizer.view!)
        default:
            return
        }
    }
    
    @objc func pinchGestureHandler(recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            guard let gesture = recognizer.view else { return }
            let newObject = Object(x: recognizer.location(in: view).x, y: recognizer.location(in: view).y, frame: CGRect(x: 0, y: 0, width: gesture.frame.width * recognizer.scale, height: gesture.frame.height * recognizer.scale), obj: gesture)
            gravityBehavior.removeItem(gesture)
            elasticityBehavior.removeItem(gesture)
            collisionBehavior.removeItem(gesture)
            gesture.removeFromSuperview()
            view.addSubview(newObject)
            addConstraint(newObj: newObject)
        default:
            return
        }
    }
    
    @objc func rotateGestureHandler(recognizer: UIRotationGestureRecognizer) {
        switch recognizer.state {
        case .began:
            gravityBehavior.removeItem(recognizer.view!)
            elasticityBehavior.removeItem(recognizer.view!)
        case .changed:
            collisionBehavior.removeItem(recognizer.view!)
            recognizer.view?.transform = (recognizer.view?.transform.rotated(by: recognizer.rotation))!
            recognizer.rotation = 0
            collisionBehavior.addItem(recognizer.view!)
        case .ended:
            gravityBehavior.addItem(recognizer.view!)
            elasticityBehavior.addItem(recognizer.view!)
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (motionManager.isAccelerometerAvailable) {
            motionManager.accelerometerUpdateInterval = 0.2
            let queue = OperationQueue.main
            motionManager.startAccelerometerUpdates(to: queue, withHandler: accelerometerHandler)
        }
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: view)
        self.gravityBehavior.magnitude = 5
        self.elasticityBehavior.elasticity = 0.6
        self.collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        self.dynamicAnimator.addBehavior(self.gravityBehavior)
        self.dynamicAnimator.addBehavior(self.elasticityBehavior)
        self.dynamicAnimator.addBehavior(self.collisionBehavior)
    }
    
    func accelerometerHandler(data: CMAccelerometerData?, error: Error?) {
        if let err = error {
            print("An error append on accelerometer \(err)")
            return
        }
        gravityBehavior.gravityDirection = CGVector(dx: data!.acceleration.x * 10, dy: -data!.acceleration.y * 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

