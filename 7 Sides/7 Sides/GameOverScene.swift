//
//  GameOverscene.swift
//  7 Sides
//
//  Created by Pedro Henrique  on 31/12/19.
//  Copyright © 2019 Pedro Henrique . All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    override func didMove(to view: SKView) {
        let scoreLabel : SKLabelNode = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "Score: \(score)"
        
        let highScoreLabel : SKLabelNode = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        let highScore = UserDefaults.standard.integer(forKey: "highScoreSaved")
        highScoreLabel.text = "High Score: \(highScore)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        let scene = GameScene(size: CGSize(width: 1536, height: 2048))
        scene.scaleMode = .aspectFill //pesquisar
        
        let sceneToMoveTo = scene
        let sceneTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
    }
}
