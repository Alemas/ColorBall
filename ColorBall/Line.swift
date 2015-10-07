//
//  Line.swift
//  ColorBall
//
//  Created by Mateus Reckziegel on 7/20/15.
//  Copyright (c) 2015 Mateus Reckziegel. All rights reserved.
//

import UIKit
import SpriteKit

class Line: NSObject {

    var p1, p2:Point?
    var node = SKShapeNode()
    private var activeNode = SKShapeNode()
    var path:CGPath?
    var highlighted:Bool = false {
        willSet {
            if newValue != self.highlighted {
                self.highlighted = newValue
                updateNodeAppearance(true)
            }
        }
    }
    
    let color1 = (Layout.colorSet[Layout.colorIndex][0] as UIColor)
    let color2 = (Layout.colorSet[Layout.colorIndex][1] as UIColor)
    
    private func baseInit(p1:Point, p2:Point) {
        self.p1 = p1
        self.p2 = p2
        
        self.node.zPosition = 0.01
        self.node.name = "Line"
        self.activeNode.zPosition = 0.02
        self.node.addChild(self.activeNode)
        self.highlighted = false
    }
    
    init(p1:Point, p2:Point){
        super.init()
        self.baseInit(p1, p2: p2)
        
        let path = UIBezierPath()
        path.moveToPoint(self.p1!.point)
        path.addLineToPoint(self.p2!.point)
        
//        node.path = CGPathCreateCopyByDashingPath(self.path!, nil, 0, [5.0, 5.0], 2)
        
        self.path = path.CGPath
        self.node.path = self.path!
        self.activeNode.path = self.path!
        self.updateNodeAppearance(false)
    }
    
    init(p1:Point, p2:Point, path:CGPathRef){
        super.init()
        self.baseInit(p1, p2: p2)
        
        self.path = path
        self.node.path = self.path!
        self.activeNode.path = self.path!
        self.updateNodeAppearance(false)
        
    }
    
    func updateNodeAppearance(animated:Bool) {
        
        self.node.strokeColor = color1
        self.node.lineWidth = Layout.lineWidth
        
        if self.highlighted {
            self.activeNode.lineWidth = Layout.lineWidth*0.25
            self.activeNode.strokeColor = color2
            self.activeNode.hidden = false
        } else {
            self.activeNode.hidden = true
        }
        
    }
    
    func adjacentPoint(root:Point) -> Point {
        if root == p1!{
            return p2!
        }
        return p1!
    }
    
    func pathToFollow(initialPoint:Point) -> CGPathRef {
        
        if initialPoint == self.p1! {
            return self.path!
        }
        var bPath = UIBezierPath(CGPath: self.path!)
        bPath = bPath.bezierPathByReversingPath()
        
        return bPath.CGPath
        
    }
    
    private func midPoint() -> CGPoint {
        return CGPointMake((self.p1!.point.x + self.p2!.point.x)/2, (self.p1!.point.y + self.p2!.point.y)/2)
    }
    
}
