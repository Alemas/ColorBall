//
//  Ball.swift
//  ColorBall
//
//  Created by Mateus Reckziegel on 7/22/15.
//  Copyright (c) 2015 Mateus Reckziegel. All rights reserved.
//

import UIKit
import SpriteKit

class Ball: NSObject {
   
    let node:SKShapeNode
    var lastLine:Line?
    var currentPoint:Point?
    var isMoving:Bool
    
    init(startPoint:Point) {
        
        self.currentPoint = startPoint
        self.node = SKShapeNode(circleOfRadius: 8.0)
        self.node.zPosition = 0.1
        self.node.position = startPoint.point
        self.isMoving = false
//        self.node.blendMode = SKBlendMode.Add
        self.node.name = "Ball"
        self.node.lineWidth = 1.0
        self.node.fillColor = Layout.colorSet[Layout.colorIndex][1]
        self.node.strokeColor = Layout.colorSet[Layout.colorIndex][0]
        
    }
    
    func move() {
        
        if !self.isMoving {
            
            self.isMoving = true
            
            var lineToFollow:Line?
            
            if self.lastLine == nil {
                lineToFollow = currentPoint!.l1!
            } else {
                lineToFollow = currentPoint!.nextLine(self.lastLine!)
            }
            
            let moveAction = SKAction.followPath(lineToFollow!.pathToFollow(self.currentPoint!), asOffset: false, orientToPath: false, speed: 50.0)
            self.node.runAction(moveAction, completion: {
            
                self.currentPoint = lineToFollow!.adjacentPoint(self.currentPoint!)
                self.lastLine = lineToFollow!
                self.isMoving = false
                self.move()
                
            })
            
        }
        
    }
    
}
