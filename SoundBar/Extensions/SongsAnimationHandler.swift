//
//  SongsAnimationController.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-19.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import UIKit
import AsyncDisplayKit


class SongsAnimationHandler {
    
    var songCircle: CAShapeLayer?
    var songProgressBarCurrent: ASImageNode?
    var songProgressBar: ASImageNode?
    var fireIcon: ASImageNode?
    
    func setCurrentSongProgressBar(image: ASImageNode) {
        self.songProgressBarCurrent = image
    }
    
    func setSongProgressBar(image: ASImageNode) {
        self.songProgressBar = image
    }
    
    func setSongCircle(shapeLayer: CAShapeLayer) {
        self.songCircle = shapeLayer
    }
    
    func setFireIcon(image: ASImageNode) {
        self.fireIcon = image
    }
    
    func setCurrentSongProgressFrame(size: CGSize){
        self.songProgressBarCurrent?.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
    }
    
    func removeCircleAnimations(shapeLayer: CAShapeLayer? = nil) {
        // resetPreviewCircle
        if shapeLayer != nil {
            shapeLayer!.removeAnimation(forKey: "strokeEnd")
            shapeLayer!.removeAnimation(forKey: "animateCircle")
        }else{
            songCircle!.removeAnimation(forKey: "strokeEnd")
            songCircle!.removeAnimation(forKey: "animateCircle")
        }
    }
    

    func springRotateFireDisk() {
        // springRotateFireDisk

        let rotation: CASpringAnimation = CASpringAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = CGFloat(Double.pi * 2)
        rotation.duration = 5
        //rotation.isCumulative = true
        rotation.repeatCount = .zero
        fireIcon!.layer.add(rotation, forKey: "rotationAnimation")
    }

    func animateCircle() {
        // animateCircle
        let animation = CABasicAnimation(keyPath: "strokeEnd")

        self.songCircle!.strokeStart = 0.0
        
        animation.duration = 30

        animation.fromValue = 0
        animation.toValue = 1

        animation.timingFunction = (CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear))

        self.songCircle!.strokeEnd = 1.0

        self.songCircle!.add(animation, forKey: "animateCircle")
    }

    func completeCircleAnimation(shapeLayer: CAShapeLayer? = nil) {
        // undoPreviewCircle
        let animation = CABasicAnimation(keyPath: "strokeEnd")

        animation.duration = 0

        animation.fromValue = 0
        animation.toValue = 1
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false

        if shapeLayer != nil {
            shapeLayer!.strokeEnd = 0
            shapeLayer!.add(animation, forKey: "animateCircle")
        } else {
            songCircle!.add(animation, forKey: "animateCircle")
        }
    }

    func animateSongProgressBar(progressBar: String, duration: Double) {
       
        // animateProgressBar
        let currentTime = CGFloat(audioCurrentTime?.value ?? 0)
        print("Start Position: \(currentTime)")
        
        let startPosition = (currentTime / CGFloat(duration)) * UIScreen.main.bounds.width
        
        let initialBound = CGRect(x: 0, y: 0, width: startPosition, height: 3)
        print("Start Bounds: \(initialBound)")

        let finalBound = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 3)
        
        let currentDuration = CGFloat(duration) - CGFloat(audioCurrentTime?.value ?? 0)
        
        let growAnimation = CABasicAnimation(keyPath: "bounds")
        growAnimation.fromValue = initialBound
        growAnimation.toValue = finalBound
        growAnimation.duration = CFTimeInterval(currentDuration)
        growAnimation.autoreverses = false
        growAnimation.isRemovedOnCompletion = false
        growAnimation.fillMode = CAMediaTimingFillMode.forwards
        growAnimation.repeatCount = .greatestFiniteMagnitude

        if progressBar == "current" {
            songProgressBarCurrent?.layer.add(growAnimation, forKey: "bounds")
        } else {
            songProgressBar?.layer.add(growAnimation, forKey: "bounds")
        }
    }
    
    func pauseSongProgressBar(size: CGSize) {
        let pausedTime = songProgressBarCurrent!.layer.convertTime(CACurrentMediaTime(), from: nil)
        songProgressBarCurrent!.layer.speed = 0.0
        songProgressBarCurrent!.layer.timeOffset = pausedTime

        //songProgressBarCurrent!.style.preferredSize = size
        print("SongProgress Size: \(songProgressBarCurrent!.style.preferredSize)")
       
    }
    
    func resumeSongProgressBar(){
        let pausedTime = songProgressBarCurrent!.layer.timeOffset
        songProgressBarCurrent!.layer.speed = 1.0
        songProgressBarCurrent!.layer.timeOffset = 0.0
        songProgressBarCurrent!.layer.beginTime = 0.0
        let timeSincePause = songProgressBarCurrent!.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        songProgressBarCurrent!.layer.beginTime = timeSincePause
    }
    
}

extension UIImage {
    
}
