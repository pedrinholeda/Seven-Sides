//
//  BallObject.swift
//  7 Sides
//
//  Created by Pedro Henrique  on 30/12/19.
//  Copyright © 2019 Pedro Henrique . All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKSpriteNode{
    
    let type: colorType
    
    init(){
        let randomTypeIndex = Int(arc4random()%7)
        self.type = colorWheelOrder [randomTypeIndex]
        
        let ballTexture = SKTexture(imageNamed: "ball_\(self.type)")

        super.init(texture: ballTexture, color: SKColor.clear, size: ballTexture.size())
        
        self.setScale(0)
        let scaleIn = SKAction.scale(to: 1, duration: 0.2)
        self.run(scaleIn)
        
        let randomSideIndex = Int(arc4random()%7)
        let sideToMoveTo = sidePositions[randomSideIndex]
        
        let moveToSide = SKAction.move(to: sideToMoveTo, duration: 2)
        
        let ballSpawnSequence = SKAction.sequence([scaleIn, moveToSide])
        
        self.run(ballSpawnSequence)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
