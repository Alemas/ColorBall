//
//  MultipleJunctionPoint.swift
//  ColorBall
//
//  Created by Mateus Reckziegel on 7/27/15.
//  Copyright (c) 2015 Mateus Reckziegel. All rights reserved.
//

import UIKit
import SpriteKit

class MultipleJunctionPoint: Point {
    
    var l2Index = 0
    var l1ArrowNode:SKShapeNode?
    var l2ArrowNode = SKShapeNode()
    let oneWayL1:Bool
    
    init(point: CGPoint, oneWayL1:Bool) {
        self.oneWayL1 = oneWayL1

        super.init(point: point)
        self.node.userInteractionEnabled = true
        self.node.name = "MJPoint"
        
        let l1ArrowPath = UIBezierPath()
        l1ArrowPath.moveToPoint(CGPointMake(3.4, 0))
        l1ArrowPath.addLineToPoint(CGPointMake(0, 7.18))
        l1ArrowPath.addLineToPoint(CGPointMake(-4, 0))
        l1ArrowPath.closePath()
        
        let l2ArrowPath = UIBezierPath(CGPath: l1ArrowPath.CGPath)
        l2ArrowPath.applyTransform(CGAffineTransformMakeTranslation(0, 7.5))
        l2ArrowPath.applyTransform(CGAffineTransformMakeRotation(self.degreeToRadians(-90)))
        self.l2ArrowNode.path = l2ArrowPath.CGPath
        self.l2ArrowNode.zPosition = 0.022
        
        if self.oneWayL1 {
            
            l1ArrowPath.applyTransform(CGAffineTransformMakeScale(1.0, -1.0))
            l1ArrowPath.applyTransform(CGAffineTransformMakeTranslation(0,7.5+7.18))
            l1ArrowPath.applyTransform(CGAffineTransformMakeRotation(self.degreeToRadians(-90)))
            self.l1ArrowNode = SKShapeNode(path: l1ArrowPath.CGPath)
            self.l1ArrowNode!.zPosition = 0.022
            self.node.addChild(self.l1ArrowNode!)
            
        }

        self.node.addChild(self.l2ArrowNode)
        updateNodeAppearance(false)
    }
   
    func toggleJunction() {
        
        if connectedLines.count <= 1 {
            return
        }
        if l2Index > (connectedLines.count - 1) {
            l2Index = 0
        }
        if self.oneWayL1 && self.l1 == (connectedLines[l2Index] as! Line) {
            l2Index++
        }
        self.l2 = (connectedLines[l2Index] as! Line)
        l2Index++
        
        updateNodeAppearance(true)
        
    }
    
    override func nextLine(line: Line) -> Line {
        return self.l2!
    }
    
    override func setLines(lines: NSArray) {
        super.setLines(lines)
        self.updateNodeAppearance(false)
    }
    
    private func angleBetween2Points(p1:CGPoint, p2:CGPoint) -> CGFloat {
        
        let xDiff = p2.x - p1.x
        let yDiff = p2.y - p1.y
        return atan2(yDiff, xDiff)
        
    }
    
    private func degreeToRadians(angle:CGFloat) -> CGFloat {
        return angle * CGFloat(M_PI/180)
    }
    
    override func updateNodeAppearance(animated:Bool) {
        super.updateNodeAppearance(animated)
        
        if self.oneWayL1 && self.l1ArrowNode != nil {
            self.l1ArrowNode!.strokeColor = UIColor.blackColor()
            self.l1ArrowNode!.fillColor = (Layout.colorSet[Layout.colorIndex][1] as UIColor)
            if l1 != nil {
                self.l1ArrowNode!.zRotation = angleBetween2Points(self.point, p2: self.l1!.adjacentPoint(self).point)
            }
        }
        
        self.l2ArrowNode.strokeColor = UIColor.blackColor()
        self.l2ArrowNode.fillColor = (Layout.colorSet[Layout.colorIndex][1] as UIColor)
        
        if l2 != nil {
            self.l2ArrowNode.zRotation = angleBetween2Points(self.point, p2: self.l2!.adjacentPoint(self).point)
        }
            
    }
    
}
