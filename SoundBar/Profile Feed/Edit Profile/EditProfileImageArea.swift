//
//  EditProfileImageArea.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-31.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class EditProfileImageArea: BaseNode {
    
    let coverPhoto = ASNetworkImageNode()
    let profilePhoto = ASNetworkImageNode()
    let changeCoverBtn = ASButtonNode()
    let changeProfileBtn = ASButtonNode()
    
    override init() {
        super.init()
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let profileCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: profilePhoto)
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 50,
                                       justifyContent: .center,
                                       alignItems: .stretch,
                                       children: [changeProfileBtn, changeCoverBtn])
        let vStack = ASStackLayoutSpec(direction: .vertical,
                                       spacing: 15,
                                       justifyContent: .center,
                                       alignItems: .stretch,
                                       children: [profileCenter, hStack])
        return ASOverlayLayoutSpec(child: coverPhoto, overlay: vStack)
    }
    
    override func didEnterVisibleState() {
        super.didEnterVisibleState()
//        DispatchQueue.main.async {
//            
//        }
//        self.coverPhoto.addTopBorder()
//        self.coverPhoto.addBottomBorder()
    }
    
    private func setupNodes() {
        coverPhoto.url = URL(string: "https://firebasestorage.googleapis.com/v0/b/soundbar-3d263.appspot.com/o/userProfileImages%2Fdababy%2Fcover-dababy?alt=media&token=7f897f38-1c39-4d40-905b-8c5d5dccf130")
        coverPhoto.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 200)
        coverPhoto.contentMode = .scaleAspectFill
        
        profilePhoto.url = URL(string: "https://firebasestorage.googleapis.com/v0/b/soundbar-3d263.appspot.com/o/userProfileImages%2Fdababy%2Fprof-dababy?alt=media&token=086326c1-9169-4f69-bc23-7b6a0cdb80fb")
        profilePhoto.style.preferredSize = .init(width: 100, height: 100)
        profilePhoto.cornerRadius = 100/2
        profilePhoto.borderWidth = 2
        profilePhoto.borderColor = UIColor.white.cgColor

        changeCoverBtn.setTitle("Change Cover Photo", with: UIFont.boldSystemFont(ofSize: 15), with: UIColor.yellow, for: .normal)
        changeCoverBtn.addTarget(self, action: #selector(changeCoverClicked), forControlEvents: .touchUpInside)
        
        changeProfileBtn.setTitle("Change Profile Photo", with: UIFont.boldSystemFont(ofSize: 15), with: UIColor.yellow, for: .normal)
        changeCoverBtn.addTarget(self, action: #selector(changeProfileClicked), forControlEvents: .touchUpInside)
    }
    
    @objc private func changeCoverClicked() {
        
    }
    
    @objc private func changeProfileClicked() {
        
    }
}

extension ASNetworkImageNode {
    func addTopBorder() {
        let topLine = CALayer()
        topLine.frame = .init(x: 0, y: 0, width: self.frame.size.width, height: 1)
        topLine.backgroundColor = UIColor.white.cgColor
        self.layer.addSublayer(topLine)
    }
    
    func addBottomBorder() {
        let topLine = CALayer()
        topLine.frame = .init(x: 0, y: self.frame.size.height - 0.6, width: self.frame.size.width, height: 0.6)
        topLine.backgroundColor = UIColor.white.cgColor
        self.layer.addSublayer(topLine)
    }
}
