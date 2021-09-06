//
//  HomeAnimationHandler.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-17.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import UIKit
import AsyncDisplayKit


class HomeAnimationHandler {
    
    var songDiskPulse: CAShapeLayer? = nil
    var songDisk: ASImageNode? = nil
    var fullSongTriangleButton: ASButtonNode? = nil
    var songProgressBar: ASImageNode? = nil
    var songProgressBarCurrent: ASImageNode? = nil
    var artistText: ASTextNode? = nil
    var songText: ASTextNode? = nil
    var fullSongRectangle: ASImageNode? = nil
    var toClean: Bool = false
    var isPaused: Bool = false
    var sharePageUp: Bool = false
    var commentPageUp: Bool = false

    func setToClean(_ value: Bool) {
        self.toClean = value
    }
    func setFullSongRectangle(image: ASImageNode) {
        self.fullSongRectangle = image
    }
    
    func setSongText(text: ASTextNode) {
        self.songText = text
    }
    
    func setArtistText(text: ASTextNode) {
        self.artistText = text
    }
    
    func setCurrentSongProgressBar(image: ASImageNode) {
        self.songProgressBarCurrent = image
    }
    
    func setSongProgressBar(image: ASImageNode) {
        self.songProgressBar = image
    }
    
    func setFullSongTriangle(button: ASButtonNode) {
        self.fullSongTriangleButton = button
    }
    
    func setSongDisk(image: ASImageNode) {
        self.songDisk = image
    }
    
    func setSongDiskPulse(shapeLayer: CAShapeLayer) {
        self.songDiskPulse = shapeLayer
    }
    
    func temporaryStoreValue(diskPulse: CAShapeLayer?, disk: ASImageNode?, songTriangleButton: ASButtonNode?, progressBar: ASImageNode?, progressBarCurrent: ASImageNode?, artist: ASTextNode?, song: ASTextNode?, songRectangle: ASImageNode?) {
        
     //   diskPulse != nil ? self.songDiskPulse = diskPulse : nil
      //  disk != nil ? self.songDisk = disk : nil
        songTriangleButton != nil ? self.fullSongTriangleButton = songTriangleButton : nil
        progressBar != nil ? self.songProgressBar = progressBar : nil
        progressBarCurrent != nil ? self.songProgressBarCurrent = progressBarCurrent : nil
     //   artist != nil ? self.artistText = artist : nil
       // song != nil ? self.songText = song : nil
        songRectangle != nil ? self.fullSongRectangle = songRectangle : nil
    }
    
    func animateFullSongBack() {
        //songDiskPulse != nil ? moveDownDiskAnimation() : nil
       // songDisk != nil ? moveDiskDown() : nil
        fullSongTriangleButton != nil ? resetRotateButton() : nil
        songProgressBar != nil ? moveProgressBarDown(progressBar: "notcurrent") : nil
        songProgressBarCurrent != nil ? moveProgressBarDown(progressBar: "current") : nil
       // artistText != nil ? moveTextDown(string: "artist") : nil
       // songText != nil ? moveTextDown(string: "song") : nil
        fullSongRectangle != nil ? moveProgressBarDown(progressBar: "rectangle") : nil
        
        songProgressBar != nil ? songProgressBar!.isHidden = true : nil
        songProgressBarCurrent != nil ? songProgressBarCurrent!.isHidden = true : nil
    }
    
    func clearMemory() {
        songDiskPulse = nil; songDisk = nil; fullSongTriangleButton = nil; songProgressBar = nil; songProgressBarCurrent = nil; artistText = nil; songText = nil; fullSongRectangle = nil
    }
    

    
    func bringUpCommentPage(comment: CommentPopUp) {
        let initialPosition = comment.position.y
        let moveUp = CASpringAnimation(keyPath: "position.y")
        
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - (UIScreen.main.bounds.height/2 + 95)
        moveUp.duration = 1
        moveUp.damping = 17.5
        moveUp.initialVelocity = 2
        
        
        comment.layer.add(moveUp, forKey: "position.y")
        comment.position.y -= (UIScreen.main.bounds.height/2 + 95)
    }
    
    func signSelect(signIn: SignInInfo) {
        let initialPosition = signIn.position.x
        let move = CASpringAnimation(keyPath: "position.x")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition + UIScreen.main.bounds.width
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        
        signIn.layer.add(move, forKey: "position.y")
        signIn.position.x += (UIScreen.main.bounds.width)

    }
    
    func bringDownCommentPage(comment: CommentPopUp) {
        let initialPosition = comment.position.y
        
        let moveDown: CASpringAnimation = CASpringAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition
        moveDown.toValue = initialPosition + (UIScreen.main.bounds.height/2 + 95)
        moveDown.duration = 75
        moveDown.damping = 15
        moveDown.initialVelocity = 5
        
        comment.layer.add(moveDown, forKey: "position.y")
        comment.position.y += (UIScreen.main.bounds.height/2 + 95)
    }
    
    func pulseDisk() {
        let growAnimation = CABasicAnimation(keyPath: "transform.scale")
        growAnimation.fromValue = 1
        growAnimation.toValue = 1.35
        growAnimation.duration = 2
        growAnimation.autoreverses = false
        growAnimation.repeatCount = .greatestFiniteMagnitude
        songDiskPulse?.add(growAnimation, forKey: "transform.scale")
    }
    
    func stopPulsingDisk() {
        // songDiskPulseStop
        songDiskPulse!.removeAnimation(forKey: "opacity.scale")
        songDiskPulse!.removeAnimation(forKey: "transform.scale")
    }
    
    func pulseDiskFadeOut() {
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1
        fadeOut.toValue = 0
        fadeOut.duration = 2
        fadeOut.autoreverses = false
        fadeOut.repeatCount = .greatestFiniteMagnitude
        songDiskPulse?.add(fadeOut, forKey: "opacity")
    }
    
    func continueRotatingDisk() {
        //unpauseRotateDisk

        let transform: CATransform3D = songDisk!.layer.presentation()!.transform
        let angle: CGFloat = atan2(transform.m12, transform.m11)
        var completesCircle: CGFloat!
        var newRotationAngle: Double!
        if angle >= 0 {
            newRotationAngle = Double(angle)
            completesCircle = CGFloat(newRotationAngle) + CGFloat(Double.pi * 2)
        } else {
            let newAngle = CGFloat(Double.pi * 2) - (angle * -1)
            newRotationAngle = Double(newAngle)
            completesCircle = CGFloat(newRotationAngle) + CGFloat(Double.pi * 2)
        }
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = newRotationAngle
        rotation.toValue = completesCircle
        rotation.duration = 5
        //rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        songDisk!.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func springRotateDisk() {
        // springRotateDisk
        
        let transform:CATransform3D = songDisk!.layer.presentation()!.transform
        let angle: CGFloat = atan2(transform.m12, transform.m11)
        
        var springsLoadAngle: Double
        var completesCircle: CGFloat
        if angle >= 0 {
            springsLoadAngle = Double(angle)
            completesCircle = CGFloat(Double.pi * 2)
        } else {
            let newAngle = CGFloat(Double.pi * 2) - (angle * -1)
            springsLoadAngle = Double(newAngle)
            completesCircle = CGFloat(Double.pi * 2)
        }
        
        let rotation: CASpringAnimation = CASpringAnimation(keyPath: "transform.rotation.z")
        
        rotation.fromValue = springsLoadAngle
        rotation.toValue = completesCircle
        
        rotation.duration = 5
        //rotation.isCumulative = true
        rotation.repeatCount = .zero
        songDisk!.layer.add(rotation, forKey: "rotationAnimation")
        
        songDisk!.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(completesCircle)))
    }
    
    func rotateDisk(completeCircle: CGFloat) {
        // rotateDisk
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = CGFloat(Double.pi * 2)
        rotation.duration = 5
        rotation.fillMode = CAMediaTimingFillMode.forwards
        rotation.repeatCount = MAXFLOAT
        songDisk?.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func stopRotatingDisk() {
        // stopRotateDisk
        let transform:CATransform3D = songDisk!.layer.presentation()!.transform
        let angle: CGFloat = atan2(transform.m12, transform.m11)
        
        var newRotationAngle: Double!
        if angle >= 0 {
            newRotationAngle = Double(angle)
//            let completesCircle = CGFloat(newsRotationAngle) + CGFloat(Double.pi * 2)
            
        } else {
            let newAngle = CGFloat(Double.pi * 2) - (angle * -1)
            newRotationAngle = Double(newAngle)
//            let completesCircle = CGFloat(newsRotationAngle) + CGFloat(Double.pi * 2)
        }
        songDisk!.layer.removeAnimation(forKey: "rotationAnimation")
        songDisk!.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(newRotationAngle)))
    }
    
    
    func animateSongProgressBar(progressBar: String, duration: Double, value: Double) {
        // animateProgressBar
        var initialBound = songProgressBarCurrent?.frame ?? CGRect(x: 0, y: 0, width: 0, height: 3)
        let currentTime = CGFloat(audioCurrentTime?.value ?? 0)
        print("Start Position: \(currentTime)")

        if value < 0{
            initialBound = CGRect(x: 0, y: 0, width: 0, height: 3)
        } else {
            print("here")
            let currentXPixel = (CGFloat(currentTime) / CGFloat(duration)) * UIScreen.main.bounds.width
            initialBound = CGRect(x: 0, y: 0, width: currentXPixel, height: 3)
        }
//        let initialBound = CGRect(x: 0, y: 0, width: 0, height: 3)

        let finalBound = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 3)
        let currentDuration = CGFloat(duration) - CGFloat(audioCurrentTime?.value ?? 0)

        let growAnimation = CABasicAnimation(keyPath: "bounds")
        growAnimation.fromValue = initialBound
        growAnimation.toValue = finalBound
        growAnimation.duration = CFTimeInterval(currentDuration)
        growAnimation.autoreverses = false
        growAnimation.repeatCount = .greatestFiniteMagnitude
        if progressBar == "current" {
            print("SongProgressAnimate")

            songProgressBarCurrent!.layer.add(growAnimation, forKey: "bounds")
        } else {
            songProgressBar!.layer.add(growAnimation, forKey: "bounds")
        }
        
        if isPlayingSong == false {
            pauseSongProgressBar()

        }
        
    }
    
//    func pauseSongProgressBar() {
//       songProgressBarCurrent!.layer.removeAllAnimations()
//        let transform: CATransform3D = songProgressBarCurrent!.layer.presentation()!.transform
//        print(transform)
//    }
    
    func pauseSongProgressBar() {
        
        let pausedTime = songProgressBarCurrent!.layer.convertTime(CACurrentMediaTime(), from: nil)
        songProgressBarCurrent!.layer.animation(forKey: "bounds")?.speed = 0.0
        songProgressBarCurrent!.layer.animation(forKey: "bounds")?.timeOffset = pausedTime

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
    
    func moveProgressBarUp(progressBar: String) {
        var initialPosition: CGFloat
        if progressBar == "current" {
            initialPosition = songProgressBarCurrent!.position.y
        } else if progressBar == "rectangle" {
            initialPosition = fullSongRectangle!.position.y
        } else {
            initialPosition = songProgressBar!.position.y
        }
        let moveUp = CABasicAnimation(keyPath: "position.y")
        // moveBoxUp
        
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 3
        moveUp.duration = 0.1
        
        
        if progressBar == "current" {
            songProgressBarCurrent!.layer.add(moveUp, forKey: "position.y")
        } else if progressBar == "rectangle" {
            fullSongRectangle!.layer.add(moveUp, forKey: "position.y")
        } else {
            songProgressBar!.layer.add(moveUp, forKey: "position.y")
        }
    }
    
    func moveProgressBarDown(progressBar: String) {
        // moveBoxDown
        
        var initialPosition: CGFloat
        if progressBar == "current" {
            initialPosition = songProgressBarCurrent!.position.y
        } else if progressBar == "rectangle" {
            initialPosition = fullSongRectangle!.position.y
        } else {
            initialPosition = songProgressBar!.position.y
        }
        let moveDown: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition - 3
        moveDown.toValue = initialPosition
        moveDown.duration = 0.1
                
        if progressBar == "current" {
            songProgressBarCurrent!.layer.add(moveDown, forKey: "position.y")
        } else if progressBar == "rectangle" {
            fullSongRectangle!.layer.add(moveDown, forKey: "position.y")
        } else {
            songProgressBar!.layer.add(moveDown, forKey: "position.y")
        }
    }
    
    func openFullSongTriangleButton() {
        // openRotate
        let resultRotation = -CGFloat.pi
        let rotation: CASpringAnimation = CASpringAnimation(keyPath: "transform.rotation.z")
        
        rotation.fromValue = 0
        rotation.toValue = -Double.pi
        rotation.duration = 1
        rotation.isCumulative = false
        rotation.repeatCount = 0
        rotation.fillMode = .backwards
        rotation.damping = 10
        rotation.initialVelocity = 2
        rotation.stiffness = 0
        rotation.isRemovedOnCompletion = false;
        
        fullSongTriangleButton!.layer.add(rotation, forKey: "rotationAnimation")
        fullSongTriangleButton!.layer.setAffineTransform(CGAffineTransform(rotationAngle: resultRotation))
    }
    
    func closeRotateButton() {
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
        fullSongTriangleButton!.layer.add(rotation, forKey: "rotationAnimation")
        fullSongTriangleButton!.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(resultRotation)))
    }
    
    func resetRotateButton(){
        let resultRotation = 0
        
        fullSongTriangleButton!.layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(resultRotation)))
    }
    
    func moveTextUp(string: String) {
        // moveTextUp
        var initialPosition: CGFloat = 0.0

        if string == "artist" {
            initialPosition = artistText!.position.y
        } else {
            initialPosition = songText!.position.y
        }
        let moveUp = CABasicAnimation(keyPath: "position.y")
        
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 3
        moveUp.duration = 0.175
        
        string == "artist" ? (artistText!.layer.add(moveUp, forKey: "position.y")) : (songText!.layer.add(moveUp, forKey: "position.y"))
    }
    
    func moveTextDown(string: String) {
        // moveTextDown
        var initialPosition: CGFloat = 0.0

        if string == "artist" {
            initialPosition = artistText!.position.y
        } else {
            initialPosition = songText!.position.y
        }
        
        let moveDown: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition - 3
        moveDown.toValue = initialPosition
        moveDown.duration = 0.175
        
        string == "artist" ? (artistText!.layer.add(moveDown, forKey: "position.y")) : (songText!.layer.add(moveDown, forKey: "position.y"))
    }
    
    func moveDiskUp() {
        // moveDiskUp
        let initialPosition = songDisk!.position.y
        
        let moveUp = CASpringAnimation(keyPath: "position.y")
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 3
        moveUp.duration = 1
        moveUp.damping = 10
        moveUp.initialVelocity = 2
        moveUp.stiffness = 0
        
        songDisk!.layer.add(moveUp, forKey: "position.y")
    }
    
    func moveDiskDown() {
        // moveDiskDown
        let initialPosition = songDisk!.position.y
        let moveDown: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition - 3
        moveDown.toValue = initialPosition
        moveDown.duration = 0.175
        
        songDisk!.layer.add(moveDown, forKey: "position.y")
    }
    
    func moveUpDiskAnimation() {
        // MoveDiskAnimationUp
        let initialPosition = songDiskPulse!.position.y
        let moveUp = CASpringAnimation(keyPath: "position.y")
        
        moveUp.fillMode = .forwards
        moveUp.isRemovedOnCompletion = false
        moveUp.fromValue = initialPosition
        moveUp.toValue = initialPosition - 3
        moveUp.duration = 1
        moveUp.damping = 10
        moveUp.initialVelocity = 2
        moveUp.stiffness = 0
        
        songDiskPulse!.add(moveUp, forKey: "position.y")
    }
    
    func moveDownDiskAnimation() {
        // MoveDiskAnimationDown
        let initialPosition = songDiskPulse!.position.y
        
        let moveDown: CABasicAnimation = CABasicAnimation(keyPath: "position.y")
        moveDown.fillMode = .forwards
        moveDown.isRemovedOnCompletion = false
        moveDown.fromValue = initialPosition - 3
        moveDown.toValue = initialPosition
        moveDown.duration = 0.175
        
        songDiskPulse!.add(moveDown, forKey: "position.y")
    }
}
