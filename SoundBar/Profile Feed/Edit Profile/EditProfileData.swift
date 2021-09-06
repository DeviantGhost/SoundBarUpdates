//
//  EditProfile.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-09-01.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class EditProfileData: BaseCellNode {
    var editProfileImageArea: EditProfileImageArea!
    var editProfileAccountArea: EditProfileAccountArea!
    var editProfileSocialArea: EditProfileSocialArea!

    override init() {
        super.init()
        editProfileImageArea = EditProfileImageArea()
        editProfileAccountArea = EditProfileAccountArea()
        editProfileSocialArea = EditProfileSocialArea()
    }
    
    override func didEnterVisibleState() {
        super.didEnterVisibleState()
//        print(self.closestViewController?.navigationController?.navigationBar.)
//        self.closestViewController?.navigationController?.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonClicked))
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let vStack = ASStackLayoutSpec(direction: .vertical,
                                 spacing: 15,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [editProfileImageArea, editProfileAccountArea, editProfileSocialArea])
        
        return ASInsetLayoutSpec(insets: .zero, child: vStack)
    }
    
    @objc private func doneButtonClicked() {
        print("hereeee")
    }
}
