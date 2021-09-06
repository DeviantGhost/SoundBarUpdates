//
//  CommentPopUpViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 8/5/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class CommentPopUpViewController: ASDKViewController<BaseNode> {
    
    var comment: CommentPopUp!
    var commentBottomControls = CommentBottomControls()

    override init() {
        super.init(node: BaseNode())
       
        self.view.backgroundColor = UIColor().cellBackgroundGray()
        
        commentBottomControls = CommentBottomControls()
        commentBottomControls.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height / 1.55), width: UIScreen.main.bounds.width, height: 100)
        commentBottomControls.zPosition = 10
        view.addSubnode(commentBottomControls)
        
        comment = CommentPopUp()
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: self.comment)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentBottomControls {
    func barPopsUp(keyboard: CGFloat) {
        let initialPosition = self.position.y
        let move = CABasicAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition - keyboard
        move.duration = 0.1
        self.layer.add(move, forKey: "position.y")
    }
    func barPopsDown(keyboard: CGFloat) {
        let initialPosition = self.position.y
        let move = CABasicAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition + keyboard
        move.duration = 0.1
        self.layer.add(move, forKey: "position.y")
    }
}
