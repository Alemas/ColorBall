//
//  GameScene.swift
//  ColorBall
//
//  Created by Mateus Reckziegel on 7/14/15.
//  Copyright (c) 2015 Mateus Reckziegel. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player:Ball?
    let mapLayer = CALayer()
    var startPoint:Point?
    var jpoint:MultipleJunctionPoint?
    
    override func didMoveToView(view: SKView) {

        self.scene!.size = CGSizeMake(self.view!.frame.width, self.view!.frame.height)
        
        self.backgroundColor = SKColor(red: 0.96078, green: 0.96470, blue: 0.83137, alpha: 1.0)
        
        self.mapLayer.contentsScale = UIScreen.mainScreen().scale
        self.mapLayer.frame = self.scene!.frame
        self.mapLayer.delegate = self
        self.view!.layer.addSublayer(self.mapLayer)
        
        self.startPoint = Point(point: CGPointMake(50, 330))
        let p1 = Point(point: CGPointMake(50, 400))
        let p2 = MultipleJunctionPoint(point: CGPointMake(120, 400), oneWayL1: false)
        self.jpoint = p2
        let p3 = Point(point: CGPointMake(120, 350))
        let p4 = Point(point: CGPointMake(120, 500))
        let end = Point(point: CGPointMake(120, 300))
        
        let l1 = Line(p1: self.startPoint!, p2: p1)
        let l2 = Line(p1: p1, p2: p2)
        
        let l3Path = UIBezierPath()
        l3Path.moveToPoint(p2.point)
        l3Path.addLineToPoint(CGPointMake(p2.point.x + 25, p2.point.y))
        l3Path.addCurveToPoint(CGPointMake(p2.point.x + 25, p2.point.y - 25), controlPoint1: CGPointMake(p2.point.x + 25 + 25, p2.point.y), controlPoint2: CGPointMake(p2.point.x + 25 + 25, p2.point.y - 25))
        l3Path.addLineToPoint(CGPointMake(p2.point.x, p2.point.y - 25))
        l3Path.addLineToPoint(CGPointMake(p2.point.x - 25, p2.point.y - 25))
        l3Path.addCurveToPoint(CGPointMake(p3.point.x - 25, p3.point.y), controlPoint1: CGPointMake(p2.point.x - 50, p2.point.y - 25), controlPoint2: CGPointMake(p2.point.x - 50, p2.point.y - 50))
        l3Path.addLineToPoint(p3.point)
        
        let l3 = Line(p1: p2, p2: p3, path: l3Path.CGPath)
        let l4 = Line(p1: p3, p2: end)
        let l5 = Line(p1: p2, p2: p4)
        
        self.startPoint!.setLines([l1])
        p1.setLines([l1, l2])
        p2.setLines([l2, l3, l5])
        p3.setLines([l3, l4])
        end.setLines([l4])
        p4.setLines([l5])
        
        let path = UIBezierPath()
        
        self.drawMap(self.startPoint!, path: path, c: 0)
        self.drawActiveMap(self.startPoint!)
        
        self.player = Ball(startPoint: self.startPoint!)
        self.scene!.addChild(self.player!.node)
        
    }
    
    func clearActiveMap(root:Point){
        
        root.mark = true
        root.highlighted = false
        
        for line in root.connectedLines {
            let adjacentPoint = (line as! Line).adjacentPoint(root)
            if !adjacentPoint.mark {
                (line as! Line).highlighted = false
                clearActiveMap(adjacentPoint)
            }
        }
        root.mark = false
    }
    
    func drawActiveMap(root:Point) {
        
        root.mark = true
        root.highlighted = true
        
        var line:Line?
        line = root.l1
        
        for var i=0; i<2; i++ {
            
            if line == nil {break}
            
            let adjacentPoint = line!.adjacentPoint(root)
            if !adjacentPoint.highlighted{
                line!.highlighted = true
                drawActiveMap(adjacentPoint)
            }
            line = root.l2
        }
        root.mark = false
        
    }
    
    func updateActiveMap() {
        self.clearActiveMap(self.startPoint!)
        self.drawActiveMap(self.startPoint!)
    }
    
    func drawMap(root:Point, path:UIBezierPath?, c:Int) {
        
        root.mark = true
        
        self.scene!.addChild(root.node)
        
        for line in root.connectedLines{
            
            let lNode = (line as! Line).node
            
            if lNode.parent == nil {
                self.scene!.addChild(lNode)
            }
            
        }
        
        path!.moveToPoint(root.point)
        
        for var i = 0; i<root.connectedLines.count; i++ {
            
            let adjacentPoint = (root.connectedLines[i] as! Line).adjacentPoint(root)
            
            if !adjacentPoint.mark {
                
                if i == 0 {
                    path!.addLineToPoint(adjacentPoint.point)
                    drawMap(adjacentPoint, path: path!, c: c+1)
                } else {
                    let auxPath = UIBezierPath()
                    auxPath.moveToPoint(root.point)
                    auxPath.addLineToPoint(adjacentPoint.point)
                    drawMap(adjacentPoint, path: auxPath, c: c+1)
                    path!.appendPath(auxPath)
                }
                
            }
            
        }
        
        root.mark = false
        
    }
    
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        
        if layer == self.mapLayer {
            
            CGContextClearRect(ctx, layer.frame)

            let path = UIBezierPath()
            
            self.drawMap(self.startPoint!, path: path, c:0)
            
            CGContextAddPath(ctx, path.CGPath)
            //CGContextStrokePath(ctx)
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.player!.move()
        self.jpoint!.toggleJunction()
        
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            
            let node = self.scene!.nodeAtPoint(location)
            self.updateActiveMap()
            
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    
    }
}
