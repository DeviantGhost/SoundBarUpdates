//
//  BottomSongDisplayNode.swift
//  SoundBar
//
//  Created by Justin Cose on 2/23/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

var signBarSelectX = CGFloat()


class SignInOrSignUp: BaseNode {
        
    let selectionBar = ASImageNode()
    
    let signIn = ASTextNode()
    let signUp = ASTextNode()
    var isSignIn: Bool = true
    
    override func didEnterVisibleState() {
        //fades on the screen
        setupNodes()

        selectionBar.backgroundColor = UIColor().soundbarColorScheme()
        selectionBar.frame = CGRect(x: 120, y: 60 , width: 40, height: 3)
        selectionBar.zPosition = 30
        view.layer.addSubnode(selectionBar)
        
        NotificationCenter.default.addObserver(self, selector: #selector(createAccountClicked), name: NSNotification.Name("createAccountClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(signUpBack), name: NSNotification.Name("signUpBack"), object: nil)

    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        

        let title = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 50,
                                           justifyContent: .center,
                                           alignItems: .center,
                                           children: [signIn, signUp])
                
        let titleInset = ASInsetLayoutSpec(insets: .init(top: 20, left: 0, bottom: 0, right: 0), child: title)
        
        return titleInset
    }
    
    func setupNodes() {
                
        signIn.attributedText = NSAttributedString(string: "Sign in", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        signIn.addTarget(self, action: #selector(signInClicked), forControlEvents: .touchUpInside)

        
        signUp.attributedText = NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.6), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        signUp.addTarget(self, action: #selector(signUpClicked), forControlEvents: .touchUpInside)
        
    }
    
    @objc func signUpClicked(){
        if(isSignIn){
            signIn.attributedText = NSAttributedString(string: "Sign in", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.6), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
            signUp.attributedText = NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
            signBarSelectX = 270
            selectionBar.position.x = 120
            selectionBar.signSelect()
            NotificationCenter.default.post(name: NSNotification.Name("signUpClicked"), object: nil)
            isSignIn = false
        }
        
    }
    
    @objc func signInClicked(){
        if(!isSignIn){
            signIn.attributedText = NSAttributedString(string: "Sign in", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
            signUp.attributedText = NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.6), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
            signBarSelectX = 120
            selectionBar.position.x = 270
            selectionBar.signSelect()
            NotificationCenter.default.post(name: NSNotification.Name("signInClicked"), object: nil)
            isSignIn = true

        }
    }
    
    @objc func signUpBack(){
        selectionBar.position.y = 40
        selectionBar.signUpBack()
        signIn.signUpBack()
        signUp.signUpBack()
        
    }
    
    @objc func createAccountClicked(){

        selectionBar.position.y = 65
        selectionBar.createAccount()
        signIn.createAccount()
        signUp.createAccount()
    }

    
}

//NOTE small offset by about 2 or 3 points after animation
extension ASImageNode {
    func signSelect() {
        var offset = CGFloat()
        let initialPosition = self.position.x
    
        if(initialPosition < signBarSelectX){
            offset = 20
        }else{
            offset = -20
        }
        
        let move = CASpringAnimation(keyPath: "position.x")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition + offset
        move.toValue = signBarSelectX
        move.damping = 10
        move.initialVelocity = 2
        move.duration = 0.175
        self.layer.add(move, forKey: "position.x")
    }
    
    func createAccount() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition - UIScreen.main.bounds.height
        move.damping = 10
        move.initialVelocity = 2
        move.duration = 0.175
        self.layer.add(move, forKey: "position.y")
    }
    
    
    func signUpBack() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = 65
        move.damping = 10
        move.initialVelocity = 2
        move.duration = 0.175
        self.layer.add(move, forKey: "position.y")
    }
}

extension ASTextNode {
    
    func createAccount() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = -UIScreen.main.bounds.height
        move.damping = 10
        move.initialVelocity = 2
        move.duration = 0.175
        self.layer.add(move, forKey: "position.y")
        self.position.y = -UIScreen.main.bounds.height

    }
    
    func signUpBack() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = 0
        move.toValue = 40
        move.damping = 10
        move.initialVelocity = 2
        move.duration = 0.5
        self.layer.add(move, forKey: "position.y")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.position.y = 40
        })
                                      
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.0
        fadeOut.toValue = 1
        fadeOut.duration = 0.5
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
    }

}

