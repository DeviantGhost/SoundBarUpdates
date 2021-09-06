//
//  EditProfilePageViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 8/4/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class EditProfilePageViewController: ASDKViewController<BaseNode> {
    
    var editProfilepage: EditProfilePage!
 
    override init() {
        super.init(node: BaseNode())
        
        NotificationCenter.default.addObserver(self, selector: #selector(editProfileKeyoard), name: NSNotification.Name(rawValue: "editProfileKeyoard"), object: nil)
        
        self.node.backgroundColor = UIColor().backgroundGray()
        
        editProfilepage = EditProfilePage()
        editProfilepage.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 20, width: UIScreen.main.bounds.width, height: 100)
        view.addSubnode(editProfilepage)
    }
    
    @objc func editProfileKeyoard() {
        DispatchQueue.main.async {
            self.editProfilepage.editableText.becomeFirstResponder()
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

