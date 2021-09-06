//
//  BetaWelcomeDisplay.swift
//  SoundBar
//
//  Created by Justin Cose on 9/3/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import UIKit
import AsyncDisplayKit


class BetaWelcomeDisplay: BaseNode, ASEditableTextNodeDelegate {
    
    var welcomeTitle = ASTextNode()
    var welcomeText =  ASTextNode()
    var welcomeTextBox = ASImageNode()
    
    var applyText = ASTextNode()
    var applyButton = ASImageNode()
    
    var skipText = ASTextNode()
    var skipButton = ASImageNode()

    override init() {
        super.init()
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let applyTextCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: applyText)
        let skipTextCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: skipText)
        
        let applyOverlay = ASOverlayLayoutSpec(child: applyButton, overlay: applyTextCenter)
        let skipOverlay = ASOverlayLayoutSpec(child: skipButton, overlay: skipTextCenter)
        
        let centerWelcomeText = ASCenterLayoutSpec(centeringOptions: .XY, child: welcomeText)
        let welcomeTextOverlay = ASOverlayLayoutSpec(child: welcomeTextBox, overlay: centerWelcomeText)
        
        let buttonStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 60,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [applyOverlay, skipOverlay])
        
        let layout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 30,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [welcomeTitle, welcomeTextOverlay, buttonStack])
       return layout
    }
    
    func setupNodes() {
        welcomeTitle.attributedText = NSAttributedString(string: "Welcome to the Soundbar Concept Beta!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 5.0
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 16), NSAttributedString.Key.paragraphStyle: paragraphStyle]

        welcomeText.attributedText = NSAttributedString(string: "If you are an artist and want to see your music go live on this app this November, apply via the link below to submit your music early!", attributes: attributes)
        welcomeTextBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 110)
        
        applyText.attributedText = NSAttributedString(string: "Apply", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        applyButton.style.preferredSize = CGSize(width: 100, height: 50)
        applyButton.backgroundColor = UIColor().soundbarColorScheme()
        applyButton.cornerRadius = 5
        applyButton.addTarget(self, action: #selector(applyButtonClicked), forControlEvents: .touchUpInside)
        
        skipText.attributedText = NSAttributedString(string: "Skip", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        skipButton.style.preferredSize = CGSize(width: 100, height: 50)
        skipButton.backgroundColor = UIColor().buttonsGray()
        skipButton.cornerRadius = 5
        skipButton.addTarget(self, action: #selector(skipButtonClicked), forControlEvents: .touchUpInside)
    }
    
    @objc func applyButtonClicked() {
        UIApplication.shared.openURL(NSURL(string: "https://04qahemhprh.typeform.com/to/ec2LwOQX")! as URL)
    }
    
    @objc func skipButtonClicked() {
        self.closestViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
    override func didExitVisibleState() {
        self.closestViewController?.dismiss(animated: false, completion: nil)
    }
}



