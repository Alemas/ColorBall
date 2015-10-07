//
//  ButtonPoint.swift
//  ColorBall
//
//  Created by Mateus Reckziegel on 8/5/15.
//  Copyright (c) 2015 Mateus Reckziegel. All rights reserved.
//

import UIKit
import SpriteKit

class ButtonPoint: Point {
    
    var buttonNode = SKShapeNode()
    var pressed = false {
        willSet{
            if newValue != self.pressed{
                self.updateNodeAppearance(true)
                self.pressed = newValue
            }
        }
    }
    private var trigger = Trigger()
    
    override init(point: CGPoint) {
        super.init(point: point)
                
        let path = UIBezierPath(ovalInRect: CGRectMake(-2.5, -2.5, 5, 5))
        path.addArcWithCenter(CGPointMake(0, 0), radius: 3, startAngle: 0, endAngle: 6.28318531, clockwise: false)
        
        self.buttonNode.path = path.CGPath
    }
    
    func connectToObject(triggerable:NSObject) {
        self.trigger.triggerable = triggerable
    }
    
    private func findPathToTriggerable () {
        
    }
    
    override func updateNodeAppearance(animated: Bool) {
        super.updateNodeAppearance(animated)
        
        
        
    }
    
}
