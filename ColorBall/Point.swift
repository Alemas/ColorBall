//
//  Point.swift
//  
//
//  Created by Mateus Reckziegel on 7/20/15.
//
//

import UIKit
import SpriteKit

class Point: NSObject {
    
    var point:CGPoint
    var connectedLines:NSArray
    var mark = false
    var node = SKShapeNode(circleOfRadius: Layout.pointRadius)
    private var activeNode = SKShapeNode(circleOfRadius: Layout.pointRadius - 1)
    var l1, l2:Line?
    let color1 = (Layout.colorSet[Layout.colorIndex][0] as UIColor)
    let color2 = (Layout.colorSet[Layout.colorIndex][1] as UIColor)
    
    var highlighted:Bool {
        willSet {
            if newValue != self.highlighted {
                self.highlighted = newValue
                self.updateNodeAppearance(true)
            }
        }
    }
    
    init(point:CGPoint) {
        self.point = point
        self.connectedLines = NSArray()
        self.highlighted = false
        
        self.node.position = self.point
        self.node.zPosition = 0.011
        self.activeNode.zPosition = 0.021
        
        self.node.addChild(self.activeNode)
        
        super.init()
        updateNodeAppearance(false)
    }
    
    func updateNodeAppearance(animated:Bool) {
        
        self.node.lineWidth = 1.5
        self.node.fillColor = color1
        self.node.strokeColor = color1
        
        if self.highlighted {
            self.activeNode.lineWidth = 0.5
            self.activeNode.strokeColor = color2
            self.activeNode.fillColor = color1
            self.activeNode.hidden = false
        } else {
            self.activeNode.hidden = true

        }
        
    }
    
    func nextLine(line:Line) -> Line{
        
        if self.l2 == nil{
            return l1!
        }
        if self.l1! == line{
            return l2!
        }
        return l1!
    }
    
    /*
    In 2 line points, p1 will be the first element of the array and p2 the second.
    In Multiple Joint Points, p1 will never change and the following lines of the array will relay on p2.
    */
    
    func setLines(lines:NSArray){
        self.l1 = nil
        self.l2 = nil
        if lines.count > 0 {
            self.connectedLines = lines
            self.l1 = (lines[0] as! Line)
            if lines.count > 1 {
                self.l2 = (lines[1] as! Line)
            }
        }
    }
    
}
