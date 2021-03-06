//
//  GameScene.swift
//  emojiPhysicsBody
//
//  Created by kazuhiro hayashi on 2018/09/10.
//  Copyright © 2018  kazuhiro hayashi. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        

        let ground = SKSpriteNode(color: .black, size: CGSize(width: view.frame.width*2, height: 50))
        ground.position = CGPoint(x: 0, y: -view.frame.size.height + 50)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        addChild(ground)
    }
    
    func makeEmojiNode() -> SKSpriteNode {
        let size = CGSize(width: 50, height: 50)
        
        let texture = SKTexture(image: makeEmojiImage()!)
        let shpenode = SKSpriteNode(texture: texture)
        shpenode.size = size
        shpenode.physicsBody = SKPhysicsBody(texture: texture, size: size)
        return shpenode
    }
    
    func makeEmojiImage() -> UIImage? {
        let size = CGSize(width: 17, height: 17)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        (makeRandomEmoji() as NSString).draw(in: CGRect(origin: .zero, size: size), withAttributes: nil)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func makeRandomEmoji() -> String {
        let range = 0x1F300...0x1F3F0
        let index = Int(arc4random_uniform(UInt32(range.count)))
        let ord = range.lowerBound + index
        guard let scalar = UnicodeScalar(ord) else { return "😃" }
        return String(scalar)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        let node = makeEmojiNode()
        node.position = pos
        self.addChild(node)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        self.touchUp(atPoint: touch.location(in: self))
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

}

