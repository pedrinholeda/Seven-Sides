//
//  GameScene.swift
//  7 Sides
//
//  Created by Pedro Henrique  on 30/12/19.
//  Copyright © 2019 Pedro Henrique . All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var colorWheelBase = SKShapeNode()
    
    let spinColorWheel = SKAction.rotate(byAngle: -convertDegressToRadians(degress: 360/7), duration: 0.2)
    
    var currentGameState : gameState = gameState.beforeGame
    //0 = antes do jogo
    //1 = está no jogo
    let tapToStartLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    let develName = SKLabelNode(fontNamed: "Caviar Dreams")
    
    let scoreLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    let highScoreLabel = SKLabelNode(fontNamed: "Caviar Dreams")
    
    var highScore = UserDefaults.standard.integer(forKey: "highScoreSaved")
    
    let playCorrectSound = SKAction.playSoundFileNamed("correctSound.wav", waitForCompletion: false)
    let playInorrectSound = SKAction.playSoundFileNamed("incorrectSound.wav", waitForCompletion: false)


    
    override func didMove(to view: SKView) {

        self.physicsWorld.contactDelegate = self

        let background = SKSpriteNode(imageNamed: "gameBackground")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = -1
        self.addChild(background)
        
        colorWheelBase = SKShapeNode(rectOf: CGSize(width: self.size.width*0.8, height: self.size.width*0.8))
        colorWheelBase.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        colorWheelBase.fillColor = SKColor.clear// para o quadrado nao aparecer
        colorWheelBase.strokeColor = SKColor.clear
        self.addChild(colorWheelBase)
        
        prepColorWheel()
        
        tapToStartLabel.text = "Toque Para Começar"
        tapToStartLabel.fontSize = 100
        tapToStartLabel.fontColor = SKColor.darkGray
        tapToStartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.1)
        self.addChild(tapToStartLabel)
        
        
        develName.text = "Developed by: Pedro Léda"
        develName.fontSize = 40
        develName.fontColor = SKColor.darkGray
        develName.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(develName)
        
        
        scoreLabel.text = "0"
        scoreLabel.fontColor = SKColor.darkGray
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.85)
        scoreLabel.fontSize = 225
        self.addChild(scoreLabel)
        
        highScoreLabel.text = "Best: \(highScore)"
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.80)
        highScoreLabel.fontSize = 100
        highScoreLabel.fontColor = SKColor.darkGray
        self.addChild(highScoreLabel)
    }
    
    func prepColorWheel(){
        
        for i in 0...6{
        let side = Side(type: colorWheelOrder[i]) // barras de todas as coress
        let basePosition = CGPoint(x: self.size.width/2, y: self.size.height*0.25)
        side.position = convert(basePosition, to: colorWheelBase)
            side.zRotation = -colorWheelBase.zRotation // para fechar as barras corretamente
        colorWheelBase.addChild(side)
        
        colorWheelBase.zRotation += convertDegressToRadians(degress: 360/7)
        }
        
        for side in colorWheelBase.children{
            
            let sidePosition = side.position
            let positionInScene = convert(sidePosition, from: colorWheelBase)
            sidePositions.append(positionInScene)
            
        }

    }
    
    func spawnBall(){
        let ball = Ball()
        ball.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(ball)
    }
    
    func startTheGame(){
        spawnBall()
        currentGameState = .inGame
        
        let scaleDown = SKAction.scale(to: 0, duration: 0.2)
        let deleteLabel = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([scaleDown, deleteLabel])
        tapToStartLabel.run(deleteSequence)
        develName.run(deleteSequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentGameState == .beforeGame{
            startTheGame()
        }
       else if currentGameState == .inGame{
            colorWheelBase.run(spinColorWheel)
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let ball: Ball
        let side: Side
        
        if contact.bodyA.categoryBitMask == PhysicsCategories.Ball{
            ball = contact.bodyA.node! as! Ball
            side = contact.bodyB.node! as! Side
        } else{
            ball = contact.bodyB.node! as! Ball
            side = contact.bodyA.node! as! Side
        }
        if ball.isActive == true{
        checkMatch(ball: ball, side: side)
        }
        
    }
    
    func checkMatch (ball: Ball, side: Side){
        
        if ball.type == side.type{
            correctMatch(ball: ball)
           print("acertou")
        }else {
            wrongMatch(ball:ball)
            print("errou")
        }
        
    }
    
    func correctMatch(ball: Ball){
        ball.delete()
        
        score += 1
        scoreLabel.text = "\(score)"
        
        if score > highScore{
            highScoreLabel.text = "Best: \(score)"
        }
        
        switch score {
        case 5: ballMovementSpeed = 1.8
        case 10: ballMovementSpeed = 1.6
        case 15: ballMovementSpeed = 1.5
        case 20: ballMovementSpeed = 1.4
        case 30: ballMovementSpeed = 1.3
        case 40: ballMovementSpeed = 1.2
        case 50: ballMovementSpeed = 1.1
        case 60: ballMovementSpeed = 1.0
        default:
            print("")
        }
        spawnBall()
        self.run(playCorrectSound)
    }
    
    func wrongMatch(ball:Ball){
        if score > highScore{
            highScore = score
            UserDefaults.standard.set(highScore, forKey: "highScoreSaved")
        }
        ball.flash()
        self.run(playInorrectSound)
    }
  
}
