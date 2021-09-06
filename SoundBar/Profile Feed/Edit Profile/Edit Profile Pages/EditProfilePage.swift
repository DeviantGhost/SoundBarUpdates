//
//  Edit Profile Page.swift
//  SoundBar
//
//  Created by Justin Cose on 8/4/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit


class EditProfilePage: BaseCellNode, ASEditableTextNodeDelegate {
    
    var titleText = ASTextNode()
    
    var cancelText = ASTextNode()
    var saveText = ASTextNode()
    
    var editableText = ASEditableTextNode()
    
    var textBackground = ASImageNode()
    var cellSeperator = ASImageNode()
    var cellSeperatorTwo = ASImageNode()
    
    override init() {
        super.init()
    
        self.backgroundColor = UIColor().backgroundGray()
       // self.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        setupNodes()
    }
    
    override func didEnterVisibleState() {
        NotificationCenter.default.post(name: NSNotification.Name("editProfileKeyoard"), object: nil)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let topText = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 250,
                                           justifyContent: .center,
                                           alignItems: .center,
                                              children: [cancelText, saveText])
        
        let topFull = ASStackLayoutSpec(direction: .vertical,
                                           spacing: -20,
                                           justifyContent: .center,
                                           alignItems: .center,
                                              children: [titleText, topText])
        
        let center = ASCenterLayoutSpec(centeringOptions: .Y, child: editableText)
        
        let overlay = ASOverlayLayoutSpec(child: textBackground, overlay: center)
        
        let bottomPart = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 0,
                                           justifyContent: .center,
                                           alignItems: .center,
                                              children: [cellSeperator, overlay, cellSeperatorTwo])
        
        let layout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 15,
                                           justifyContent: .center,
                                           alignItems: .center,
                                              children: [topFull, bottomPart])
    
        return layout
    }

    private func setupNodes() {
        titleText.attributedText = NSAttributedString(string: editProfilePageTitle, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        
        cancelText.attributedText = NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        cancelText.addTarget(self, action: #selector(cancelClicked), forControlEvents: .touchUpInside)
        
        saveText.attributedText = NSAttributedString(string: "Save", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        
        editableText.delegate = self
        editableText.attributedPlaceholderText = .init(string: editProfilePageInfo, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        editableText.backgroundColor = .clear
        editableText.style.preferredSize = .init(width: 230, height: 40)
        editableText.textContainerInset = .init(top: 0, left: 10, bottom: 0, right: 0)
        editableText.tintColor = UIColor().soundbarColorScheme()
        editableText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
        editableText.style.preferredSize = editProfilePageInfo.sizeOfString(font: UIFont.systemFont(ofSize: 15))

        textBackground.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        
        cellSeperator.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 0.3)
        cellSeperator.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        cellSeperatorTwo.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 0.3)
        cellSeperatorTwo.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @objc private func cancelClicked() {
        self.closestViewController?.navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveClicked() {
        self.closestViewController?.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
