//
//  EditProfileController.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-30.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class EditProfileController: ASDKViewController<BaseNode> {
    
    var editProfile: EditProfileFeed!
    
    override init() {
        super.init(node: BaseNode())
<<<<<<< Updated upstream:SoundBar/Controllers/Profile/EditProfileController.swift
=======
        
>>>>>>> Stashed changes:SoundBar/Profile Feed/Edit Profile/EditProfileController.swift
        editProfile = EditProfileFeed()
        self.node.addSubnode(editProfile)
        self.node.backgroundColor = .black
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .zero, child: self.editProfile)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
