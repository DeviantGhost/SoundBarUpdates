//
//  Animation Extension.swift
//  SoundBar
//
//  Created by Justin Cose on 2/12/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit
import AVFoundation
import UIKit


extension ASImageNode {
    
//    func animateProgressBar() {
//
//
//
//    }
    
//    func resetProgressBar() {
//
//
//
//    }
    func fullSongQueueOpen() {
        
        let initialPosition = self.position.y
        
        let moveDown: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition
        moveDown.toValue = initialPosition + 70
        moveDown.duration = 0.175
        self.position.y += 70

        self.layer.add(moveDown, forKey: "position.y")
    }
    
    func followingClicked() {
        
        
        let initialPosition = self.position.x
        let moveUp = CASpringAnimation(keyPath: "position.x")
        
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 123
        moveUp.duration = 0.75
        moveUp.damping = 16
        moveUp.initialVelocity = 5
        
        self.layer.add(moveUp, forKey: "position.x")
    }
    
    func barsClicked() {
        
        
        let initialPosition = self.position.x
        let moveUp = CASpringAnimation(keyPath: "position.x")
        
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition + 123
        moveUp.duration = 0.75
        moveUp.damping = 16
        moveUp.initialVelocity = 5
        
        self.layer.add(moveUp, forKey: "position.x")
    }
    
//    func rotateDisk(completeCircle: CGFloat) {
//
//
//        //        print("ROTATE!")
//    }
    
//    func stopRotateDisk(newRotationAngle: Double) {
//
//    }
    
    func resetDisk(completeCircle: CGFloat) {
        self.layer.removeAnimation(forKey: "rotationAnimation")
        self.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(completeCircle)))
    }
    
    func unpauseRotateDisk(newRotationAngle: Double, completeCircle: CGFloat) {
        
        print("ROTATE!")
    }
    
    
    func springRotateFireDisk() {
        let rotation: CASpringAnimation = CASpringAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = CGFloat(Double.pi * 2)
        rotation.duration = 5
        //rotation.isCumulative = true
        rotation.repeatCount = .zero
        self.layer.add(rotation, forKey: "rotationAnimation")
        //        print("ROTATE!")
    }
    
    func radiansToDegress(radians: CGFloat) -> CGFloat {
        return radians * 180 / CGFloat(Double.pi)
    }
    
    
    func playPauseFadeOut() {
        
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1
        fadeOut.toValue = 0
        fadeOut.duration = 0.75
        fadeOut.autoreverses = false
        //fadeOut.repeatCount = .
        self.layer.add(fadeOut, forKey: "opacity")
    }
    
    func PopUpBufferUp() {
        
        let initialPosition = self.position.y
        let moveUp = CASpringAnimation(keyPath: "position.y")
        
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 50
        moveUp.duration = 1
        moveUp.damping = 12
        moveUp.initialVelocity = 5
        
        self.layer.add(moveUp, forKey: "position.y")
        
    }
    
    func PopUpBufferDown() {
        
        let initialPosition = self.position.y
        
        let moveDown: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition
        moveDown.toValue = initialPosition + 50
        moveDown.duration = 0.175
        
        self.layer.add(moveDown, forKey: "position.y")
    }
}


extension CAShapeLayer{
    
    func animateCircle() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = 30
        
        animation.fromValue = 0
        animation.toValue = 1
        
        animation.timingFunction = (CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear))
        
        self.strokeEnd = 1.0
        
        self.add(animation, forKey: "animateCircle")
    }
    
//    func resetPreviewCircle(){
//
//    }
    
    func undoPreviewCircle(){
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = 0
        
        animation.fromValue = 0
        animation.toValue = 0
        
        self.strokeEnd = 0
        
        self.add(animation, forKey: "animateCircle")
        
    }
    
    func unpauseAnimateCircle(){
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = 30
        
        animation.fromValue = 0
        animation.toValue = 1
        
        animation.timingFunction = (CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear))
        
        self.strokeEnd = 1.0
        
        self.add(animation, forKey: "animateCircle")
    }
//
//    func MoveDiskAnimationUp() {
//
//
//    }
//
//    func MoveDiskAnimationDown() {
//
//
//
//    }
//
//    func songDiskPulse() {
//
//
//
//    }
//
//    func songDiskPulseFadeOut() {
//
//
//
//    }
//
//
//    func songDiskPulseStop() {
//
//
//    }
}


extension ASTextNode{
    
//    func moveTextUp() {
//
//
//    }
//
//    func moveTextDown() {
//
//
//
//    }
    
    
    func growText() {
        
        
        let initialPosition = self.position.y
        
        let moveUp: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 73
        moveUp.duration = 0.175
        
        self.layer.add(moveUp, forKey: "position.y")
    }
    
    func shrinkText() {
        let initialPosition = self.position.y
        
        let moveDown: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition - 73
        moveDown.toValue = initialPosition
        moveDown.duration = 0.175
        
        self.layer.add(moveDown, forKey: "position.y")
    }
}


extension ASButtonNode{
    
//    func openRotate() {
//
//
//    }
    
    func fullSongQueueOpen() {
        
        let initialPosition = self.position.y
        
        let moveDown: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition
        moveDown.toValue = initialPosition + 70
        moveDown.duration = 0.175
        self.position.y += 70

        self.layer.add(moveDown, forKey: "position.y")
    }
    
    func closeRotate(){
        let resultRotation = (CGFloat.pi) * 0
        let rotation = CASpringAnimation(keyPath: "transform.rotation.z")
        
        rotation.fromValue = -Double.pi
        rotation.toValue = 0
        rotation.duration = 1
        rotation.isCumulative = false
        rotation.repeatCount = 0
        rotation.fillMode = .backwards
        rotation.damping = 10
        rotation.initialVelocity = 2
        rotation.stiffness = 0
        rotation.isRemovedOnCompletion = false;
        self.layer.add(rotation, forKey: "rotationAnimation")
        self.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(resultRotation)))
        
    }
    
    func growFavoritesButton() {
        
        
        let initialPosition = self.position.y
        
        let moveUp: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 72
        moveUp.duration = 0.25
        
        self.layer.add(moveUp, forKey: "position.y")
        
        
    }
    
    func shrinkFavoritesButton() {
        
        let initialPosition = self.position.y
        
        let moveDown: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition - 72
        moveDown.toValue = initialPosition
        moveDown.duration = 0.175
        
        self.layer.add(moveDown, forKey: "position.y")
        
    }
    
    func fadeIn() {
        
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.autoreverses = false
        fadeIn.fillMode = .forwards
        fadeIn.isRemovedOnCompletion = false
        fadeIn.fromValue = 0
        fadeIn.toValue = 1
        fadeIn.duration = 0.175
        fadeIn.autoreverses = false
        self.layer.add(fadeIn, forKey: "opacity")
        
    }
    
    func fadeOut() {
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.autoreverses = false
        fadeOut.fillMode = .forwards
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fromValue = 1
        fadeOut.toValue = 0
        fadeOut.duration = 0.175
        fadeOut.autoreverses = false
        self.layer.add(fadeOut, forKey: "opacity")
        
    }
    
    
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
