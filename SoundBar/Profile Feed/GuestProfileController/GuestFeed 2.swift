//
//  GuestFeed.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-11-13.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit
import FirebaseUI

class GuestFeed: ASDKViewController<BaseNode> {
    
    let textPrompt = ASTextNode()
    let profileImage = ASImageNode()
    let signUpButton = ASButtonNode()
    
    override init() {
        super.init(node: BaseNode())
        setupNode()
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            let vStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 30,
                                           justifyContent: .center,
                                           alignItems: .stretch,
                                           children: [self.textPrompt, self.signUpButton])
            let vStackFull = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 30,
                                               justifyContent: .center,
                                               alignItems: .center,
                                               children: [self.profileImage, vStack])
            return vStackFull
//            let centerLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: vStackFull)
//            return ASOverlayLayoutSpec(child: node, overlay: centerLayout)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNode() {
        self.node.backgroundColor = UIColor.init(white: 1.0, alpha: 0.0)
        textPrompt.attributedText = .init(string: "Sign up or log in to follow artists or post music", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        profileImage.image = UIImage.init(imageLiteralResourceName: "profile")
        profileImage.style.preferredSize = .init(width: 85, height: 85)
        
        signUpButton.style.preferredSize.height = 50
        signUpButton.setTitle("Sign Up", with: .italicSystemFont(ofSize: 25), with: .white, for: .normal)
        signUpButton.backgroundColor = .red
        signUpButton.cornerRadius = 50 / 4
        signUpButton.addTarget(self, action: #selector(callSignupControl), forControlEvents: .touchUpInside)
    }
    
    @objc func callSignupControl() {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        let providers = [FUIEmailAuth()]
        authUI?.providers = providers
        let authVC = authUI!.authViewController()
        authVC.modalPresentationStyle = .overFullScreen
        self.parent?.present(authVC, animated: true, completion: nil)
    }
}

extension GuestFeed: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else { print(error?.localizedDescription); return }
        userID = (authDataResult?.user.uid)!
//        self.node.removeFromSupernode()
        print("printing user id...\(userID)")
    }
}
