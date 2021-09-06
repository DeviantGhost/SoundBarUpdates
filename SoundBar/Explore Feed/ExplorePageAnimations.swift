//
//  Animation Extension.swift
//  SoundBar
//
//  Created by Justin Cose on 2/23/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit
import AVFoundation
import UIKit

extension BaseNode{
    func displayBoxPopsUp() {
        let initialPosition = self.position.y
        let moveUp = CASpringAnimation(keyPath: "position.y")
        let songPopUpValue = bottomSongDisplayHeight - 2

        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - CGFloat(songPopUpValue)
        moveUp.duration = 0.45
        moveUp.damping = 16
        moveUp.initialVelocity = 5
      
        self.layer.add(moveUp, forKey: "position.y")
    }
    
    func displayBoxPopsDown() {
        let initialPosition = self.position.y
        let songPopDownValue = bottomSongDisplayHeight + 2
        
        let moveDown: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition
        moveDown.toValue = initialPosition + CGFloat(songPopDownValue)
        moveDown.duration = 0.175
     
        self.layer.add(moveDown, forKey: "position.y")
    }
    
    func fullDisplayBoxPopsUp() {
        let initialPosition = self.position.y
        let moveUp = CASpringAnimation(keyPath: "position.y")
        
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - UIScreen.main.bounds.height
        moveUp.duration = 0.75
        moveUp.damping = 18
        moveUp.initialVelocity = 5
      
        self.layer.add(moveUp, forKey: "position.y")
    }
    
    func fullDisplayBoxPopsDown() {
        let initialPosition = self.position.y
   
        let moveDown = CASpringAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition
        moveDown.toValue = initialPosition + UIScreen.main.bounds.height
        moveDown.duration = 0.75
        moveDown.damping = 17
        moveDown.initialVelocity = 5
     
        self.layer.add(moveDown, forKey: "position.y")
    }
}

extension ASImageNode{
    func moveStackOneUp() {
        let initialPosition = self.position.y

        let moveUp = CASpringAnimation(keyPath: "position.y")
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 200
        moveUp.duration = 1
        moveUp.damping = 15
        moveUp.initialVelocity = 2
        moveUp.stiffness = 0
        moveUp.beginTime = CACurrentMediaTime() + 0.2

        self.layer.add(moveUp, forKey: "position.y")
    }
    
    func moveStackTwoUp() {
        let initialPosition = self.position.y

        let moveUp = CASpringAnimation(keyPath: "position.y")
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 200
        moveUp.duration = 1
        moveUp.damping = 15
        moveUp.initialVelocity = 2
        moveUp.stiffness = 0
        moveUp.beginTime = CACurrentMediaTime() + 0

        self.layer.add(moveUp, forKey: "position.y")
    }
    
    func moveStackThreeUp() {
        let initialPosition = self.position.y

        let moveUp = CASpringAnimation(keyPath: "position.y")
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 200
        moveUp.duration = 1
        moveUp.damping = 15
        moveUp.initialVelocity = 2
        moveUp.stiffness = 0
        moveUp.beginTime = CACurrentMediaTime() + 0.1

        self.layer.add(moveUp, forKey: "position.y")
    }
}

extension ASTextNode{
    func moveTextOneUp() {
        
        let initialPosition = self.position.y

        let moveUp = CASpringAnimation(keyPath: "position.y")
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 200
        moveUp.duration = 1
        moveUp.damping = 15
        moveUp.initialVelocity = 2
        moveUp.stiffness = 0
        moveUp.beginTime = CACurrentMediaTime() + 0.2

        self.layer.add(moveUp, forKey: "position.y")
    }
    
    func moveTextTwoUp() {
        let initialPosition = self.position.y

        let moveUp = CASpringAnimation(keyPath: "position.y")
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 200
        moveUp.duration = 1
        moveUp.damping = 15
        moveUp.initialVelocity = 2
        moveUp.stiffness = 0
        moveUp.beginTime = CACurrentMediaTime() + 0

        self.layer.add(moveUp, forKey: "position.y")
    }
    
    func moveTextThreeUp() {
        let initialPosition = self.position.y

        let moveUp = CASpringAnimation(keyPath: "position.y")
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 200
        moveUp.duration = 1
        moveUp.damping = 15
        moveUp.initialVelocity = 2
        moveUp.stiffness = 0
        moveUp.beginTime = CACurrentMediaTime() + 0.1

        self.layer.add(moveUp, forKey: "position.y")
    }
}
