//
//  Trigger.swift
//  ColorBall
//
//  Created by Mateus Reckziegel on 7/27/15.
//  Copyright (c) 2015 Mateus Reckziegel. All rights reserved.
//

import UIKit

class Trigger: NSObject {
    
    var triggerable:NSObject?
    var active = false
    
    func activate(){
     
        if self.triggerable == nil {
            return
        }
        self.active = !self.active
        
        if self.triggerable!.isKindOfClass(Bridge) {
            let bridge = (self.triggerable as! Bridge)
            
        }
        
    }
   
}
