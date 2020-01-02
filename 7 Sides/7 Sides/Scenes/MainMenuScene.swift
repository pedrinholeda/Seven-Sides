//
//  MainMenuScene.swift
//  7 Sides
//
//  Created by Pedro Henrique  on 02/01/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene{
    var playLabel = SKLabelNode()
    override func didMove(to view: SKView) {
        playLabel = self.childNode(withName: "playLabel") as! SKLabelNode
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch : AnyObject in touches{
            let pointITouched = touch.location(in: self)
            
            if playLabel.contains(pointITouched){
                
                let sceneMoveTo = GameScene(size: self.size)
                sceneMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneMoveTo, transition: sceneTransition)
                
            }
        }
    }
}
