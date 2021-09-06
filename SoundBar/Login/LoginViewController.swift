//
//  BottomSongDisplayNode.swift
//  SoundBar
//
//  Created by Justin Cose on 2/23/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

var signSelectX = CGFloat()
var backTempY = CGFloat()

class LoginViewController: ASDKViewController<BaseNode>   {
    

    var animationHandler: HomeAnimationHandler!

    var signInOrSignUp: SignInOrSignUp!
    
    var signInInfo: SignInInfo!
    
    var signUpInfo: SignUpInfo!
    
    var signUpWith: SignUpWith!
    
    var uploadPhoto: UploadPhoto!

    var genreViewModel: GenreViewModel!
    
    var genreCellData: GenreCellData!
    
    override init() {
        super.init()
        print("LoginPage: Running")

        signInOrSignUp = SignInOrSignUp()
        self.view.backgroundColor = UIColor(red: 0.1098039216, green: 0.1098039216, blue: 0.1098039216, alpha: 1)
        signInOrSignUp.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 70)
        signInOrSignUp.zPosition = 4
        signInOrSignUp.anchorPoint = CGPoint(x: 0.5, y: 0)
        signInOrSignUp.backgroundColor = .clear
        view.addSubnode(signInOrSignUp)

        signInInfo = SignInInfo()
        signInInfo.frame = CGRect(x: -UIScreen.main.bounds.width/2, y: 160, width: UIScreen.main.bounds.width, height: 600)
        signInInfo.zPosition = 3
        signInInfo.anchorPoint = CGPoint(x: 0, y: 0.5)
        signInInfo.backgroundColor = .clear
        view.addSubnode(signInInfo)

        signUpInfo = SignUpInfo()

        signUpInfo.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 600)
        signUpInfo.zPosition = 4
        signUpInfo.anchorPoint = CGPoint(x: 0.5, y: 0)
        signUpInfo.backgroundColor = .clear
        view.addSubnode(signUpInfo)

        signUpWith = SignUpWith()

        signUpWith.frame = CGRect(x: -UIScreen.main.bounds.width*1.5, y: 160, width: UIScreen.main.bounds.width, height: 250)
        signUpWith.zPosition = 4
        signUpWith.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        view.addSubnode(signUpWith)
        
        uploadPhoto = UploadPhoto()
        
        uploadPhoto.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: 600)
        uploadPhoto.zPosition = 4
        uploadPhoto.anchorPoint = CGPoint(x: 0, y: 0)
        view.addSubnode(uploadPhoto)
        uploadPhoto.backgroundColor = .clear
        
        genreViewModel = GenreViewModel()
        
        genreViewModel.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        genreViewModel.zPosition = 4
        genreViewModel.anchorPoint = CGPoint(x: 0, y: 0)
        view.addSubnode(genreViewModel)
        genreViewModel.backgroundColor = .clear

        NotificationCenter.default.addObserver(self, selector: #selector(signUpClicked), name: NSNotification.Name("signUpClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(signInClicked), name: NSNotification.Name("signInClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createAccountClicked), name: NSNotification.Name("createAccountClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(signUpBack), name: NSNotification.Name("signUpBack"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(signUp), name: NSNotification.Name("signUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(uploadPhotoPage), name: NSNotification.Name("uploadPhoto"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(uploadPhotoBack), name: NSNotification.Name("uploadPhotoBack"), object: nil)
    }
    
    @objc func signUpBack(){
        
        signUpWith.signUpBack()
        signUpInfo.frame = CGRect(x: 0, y: UIScreen.main.bounds.height + 295, width: UIScreen.main.bounds.width, height: 400)
        signUpInfo.signUpBack()
        
    }
    
    @objc func signUpClicked(){
        print("Sign Up Clicked")

        signSelectX = UIScreen.main.bounds.width
        signInInfo.frame = CGRect(x: 0, y: 160, width: UIScreen.main.bounds.width, height: 600)
        signInInfo.signSelect()
        
        signUpWith.signSelect()
    }
    
    @objc func signInClicked(){
        print("Sign In Clicked")

        signSelectX = 0
        signInInfo.frame = CGRect(x: UIScreen.main.bounds.width, y: 160, width: UIScreen.main.bounds.width, height: 600)
        signInInfo.signSelect()
        signUpWith.frame = CGRect(x: 0, y: 160, width: UIScreen.main.bounds.width, height: 250)
        signUpWith.signSelect()
    }
    
    @objc func createAccountClicked(){
        print("Create Account Clicked")

        
        signUpWith.createAccount()
       
        signUpInfo.createAccount()


    }
    
    @objc func signUp(){
        signUpInfo.frame = CGRect(x: -UIScreen.main.bounds.width, y: UIScreen.main.bounds.height  - 200, width: UIScreen.main.bounds.width, height: 400)
        signUpInfo.signUp()
        genreViewModel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        genreViewModel.signUp()
    }
    
    @objc func uploadPhotoPage(){
        //genreViewModel.position.x = -UIScreen.main.bounds.width
        genreViewModel.frame = CGRect(x: -UIScreen.main.bounds.width, y: UIScreen.main.bounds.height  - 200, width: UIScreen.main.bounds.width, height: 0)
        genreViewModel.signUp()
        uploadPhoto.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        uploadPhoto.uploadPage()
        
    }
    
    @objc func uploadPhotoBack(){
        //genreViewModel.position.x = -UIScreen.main.bounds.width
        genreViewModel.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: UIScreen.main.bounds.width, height: 0)
        genreViewModel.uploadPageBack()
        uploadPhoto.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        uploadPhoto.uploadPageBack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
//Moves the SignInInfo to the right

extension SignUpWith {
    func signSelect() {
        let initialPosition = self.position.x
        let move = CASpringAnimation(keyPath: "position.x")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = signSelectX - UIScreen.main.bounds.width/2
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        
        self.layer.add(move, forKey: "position.x")
        self.position.x = signSelectX - UIScreen.main.bounds.width/2
    }
    
    func createAccount() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = +UIScreen.main.bounds.height + 160
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        fadeOut.duration = 1
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
        self.layer.add(move, forKey: "position.y")
        
        self.position.y = +UIScreen.main.bounds.height + initialPosition
    }
    
    func signUpBack() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = 285
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.0
        fadeOut.toValue = 1.0
        fadeOut.duration = 0.1
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
        self.layer.add(move, forKey: "position.y")
        self.position.y = 285
        
    }
    
}

extension SignInInfo {
    func signSelect() {
        let initialPosition = self.position.x
        let move = CASpringAnimation(keyPath: "position.x")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = signSelectX
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        
        self.layer.add(move, forKey: "position.x")
        self.position.x = (signSelectX)
    }
}

extension SignUpInfo {
    func createAccount() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = 12
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        move.beginTime = CACurrentMediaTime() + 0.3
        
        self.layer.add(move, forKey: "position.y")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.position.y = 12
        })
        
    }
    
    func signUpBack() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = UIScreen.main.bounds.height + 295
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        
        self.layer.add(move, forKey: "position.y")
        self.position.y = UIScreen.main.bounds.height + 295
    }
    
    func signUp() {
        let initialPosition = self.position.x
        let move = CASpringAnimation(keyPath: "position.x")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = -UIScreen.main.bounds.width
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        
        self.layer.add(move, forKey: "position.x")
        self.position.x = -UIScreen.main.bounds.width
    
    }
}

extension GenreViewModel {
    func signUp() {
        let initialPosition = self.position.x
        let move = CASpringAnimation(keyPath: "position.x")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = 0
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        
        self.layer.add(move, forKey: "position.x")
        self.position.x = 0
    
    }
    
    func uploadPageBack(){
        
        let initialPosition = self.position.x
        let move = CASpringAnimation(keyPath: "position.x")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = 0
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        
        self.layer.add(move, forKey: "position.x")
        self.position.x = 0
    }
    
    func uploadPhoto() {
        let initialPosition = self.position.x
        let move = CASpringAnimation(keyPath: "position.x")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = 0
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        
        self.layer.add(move, forKey: "position.x")
        self.position.x = 0
    }
}


extension UploadPhoto {
    
    func uploadPage() {
        let initialPosition = self.position.x
        let move = CASpringAnimation(keyPath: "position.x")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = 0
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        
        self.layer.add(move, forKey: "position.x")
        self.position.x = 0
    }
    
    func uploadPageBack() {
        
        let initialPosition = self.position.x
        let move = CASpringAnimation(keyPath: "position.x")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = UIScreen.main.bounds.width
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        
        self.layer.add(move, forKey: "position.x")
        self.position.x = UIScreen.main.bounds.width
    }

}
