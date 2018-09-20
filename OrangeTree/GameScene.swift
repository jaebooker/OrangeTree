//
//  GameScene.swift
//  OrangeTree
//
//  Created by Jaeson Booker on 9/18/18.
//  Copyright © 2018 Jaeson Booker. All rights reserved.
//
import SpriteKit

class GameScene: SKScene {
    var orangeTree: SKSpriteNode!
    var orange: Orange?
    var touchStart: CGPoint = .zero
    var shapeNode = SKShapeNode()
    override func didMove(to view: SKView) {
        orangeTree =  childNode(withName: "tree") as! SKSpriteNode
        shapeNode.lineWidth = 20
        shapeNode.lineCap = .round
        shapeNode.strokeColor = UIColor(white: 1, alpha: 0.3)
        addChild(shapeNode)
        //create contact delegate
        physicsWorld.contactDelegate =  self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //find out where screen was touched
        let touch = touches.first!
        let location = touch.location(in: self)
        //find out if screen was touched on the "orange tree"
        if atPoint(location).name == "tree" {
            orange = Orange()
            orange?.physicsBody?.isDynamic = false
            orange?.position = location
            addChild(orange!)
            
            //keep a record of where the screen was touched
            touchStart = location
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //find out where screen was touched
        let touch = touches.first!
        let location = touch.location(in: self)
        
        //put an Orange on the place touched
        orange?.position = location
        
        //firing vector
        let path = UIBezierPath()
        path.move(to: touchStart)
        path.addLine(to: location)
        shapeNode.path = path.cgPath
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //find out where screen stopped being touched
        let touch = touches.first!
        let location = touch.location(in: self)
        
        //find out how much the finger moved
        let dx = touchStart.x - location.x
        let dy = touchStart.y - location.y
        let vector = CGVector(dx: dx, dy: dy)
        
        //fill the orange with flying impulses from the touch
        orange?.physicsBody?.isDynamic = true
        orange?.physicsBody?.applyImpulse(vector)
        // remove path from shapeNode
        shapeNode.path = nil
    }
}
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        //^called when physics world feels nodes colliding into each other
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if contact.collisionImpulse > 15 {
            if nodeA?.name == "skull" {
                removeSkull(node: nodeA!)
            } else if nodeB?.name == "skull" {
                removeSkull(node: nodeB!)
            }
        }
    }
    //function used to remove Skull node
    func removeSkull(node: SKNode) {
        node.removeFromParent()
    }
}
