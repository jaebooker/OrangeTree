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
            orange?.position = location
            addChild(orange!)
            //fill the orange with flying impulses
            let vector = CGVector(dx: 100, dy: 0)
            orange?.physicsBody?.applyImpulse(vector)
        }
    }
}
