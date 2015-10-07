//
//  Bridge.swift
//  ColorBall
//
//  Created by Mateus Reckziegel on 8/4/15.
//  Copyright (c) 2015 Mateus Reckziegel. All rights reserved.
//

import UIKit
import SpriteKit

class Bridge: Line {
    
//    var bridgeNode = SKShapeNode()
    var active = false {
        willSet{
            if newValue != self.active {
                self.active = newValue
                self.updateBridge()
                self.updateNodeAppearance(true)
            }
        }
    }
    
    override init(p1:Point, p2:Point){
        super.init(p1: p1, p2: p2)
    }
    
    private func updateBridge(){
        
        if self.active {
            self.p1!.l2 = self
            self.p2!.l1 = self
        } else {
            self.p1!.l2 = nil
            self.p2!.l1 = nil
        }
        
    }
    
    override func updateNodeAppearance(animated: Bool) {
        super.updateNodeAppearance(animated)
        if self.active {
            
        }
    }
   
}
