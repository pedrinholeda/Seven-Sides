//
//  ModelsAndData.swift
//  7 Sides
//
//  Created by Pedro Henrique  on 30/12/19.
//  Copyright © 2019 Pedro Henrique . All rights reserved.
//

import Foundation
import SpriteKit

//Sides and ball information
enum colorType {
    case Red
    case Orange
    case Pink
    case Blue
    case Yellow
    case Purple
    case Green
}

let colorWheelOrder: [colorType] = [
.Red,     //0
.Orange,  //1
.Yellow,  //2
.Green,   //3
.Blue,    //4
.Purple,  //5
.Pink     //6
]

var sidePositions:[CGPoint] = []

// game state

enum gameState {
    case beforeGame
    case inGame
    case afterGame
}
// physics categories

struct PhysicsCategories {
    static let None: UInt32 = 0 //0
    static let Ball: UInt32 = 0b1 //1
    static let Side: UInt32 = 0b10 //2
}

// Score System

var score: Int = 0

//level system

var ballMovementSpeed: TimeInterval = 2
