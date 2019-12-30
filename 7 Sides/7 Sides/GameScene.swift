//
//  GameScene.swift
//  7 Sides
//
//  Created by Pedro Henrique  on 30/12/19.
//  Copyright © 2019 Pedro Henrique . All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var colorWhellBase = SKShapeNode()
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "gameBackground")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = -1
        self.addChild(background)
        
        colorWhellBase = SKShapeNode(rectOf: CGSize(width: self.size.width*0.8, height: self.size.width*0.8))
        colorWhellBase.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        colorWhellBase.fillColor = SKColor.clear // para o quadrado nao aparecer
        colorWhellBase.strokeColor = SKColor.clear
        self.addChild(colorWhellBase)
        
        prepColorWhell()
        
    }
    
    func prepColorWhell(){
        
        for _ in 0...6{
        let side = SKSpriteNode(imageNamed: "side_Blue")
        let basePosition = CGPoint(x: self.size.width/2, y: self.size.height*0.25)
        side.position = convert(basePosition, to: colorWhellBase)
            side.zRotation = -colorWhellBase.zRotation // para fechar as barras corretamente
        colorWhellBase.addChild(side)
        
        colorWhellBase.zRotation += convertDegressToRadians(degress: 360/7)
        }
    }
  
}
