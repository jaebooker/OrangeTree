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
    override func didMove(to view: SKView) {
        orangeTree =  childNode(withName: "tree") as! SKSpriteNode
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
    }
}
