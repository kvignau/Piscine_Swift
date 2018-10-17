//
//  Object.swift
//  d06
//
//  Created by Kevin VIGNAU on 10/9/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit

class Object: UIView {
    
    var rand = arc4random() % 2
    
    init(x: CGFloat, y: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        backgroundColor = .random()
        if (rand == 0) {
            layer.cornerRadius = frame.size.width/2
        }
        center = CGPoint(x: x, y: y)
        layer.masksToBounds = true
    }
    
    init(x: CGFloat, y: CGFloat, frame: CGRect, obj: UIView) {
        super.init(frame: frame)
        backgroundColor = obj.backgroundColor
        rand = 1
        if (obj.layer.cornerRadius != 0) {
            rand = 0
            layer.cornerRadius = frame.size.width/2
        }
        center = CGPoint(x: x, y: y)
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override public var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return rand == 0 ? .ellipse : .rectangle
    }

}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
