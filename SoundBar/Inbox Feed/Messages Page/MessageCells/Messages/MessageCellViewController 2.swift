//
//  MessageCellViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 3/21/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit
import UIKit

class MessageCellViewController: ASDKViewController<BaseNode> {
    
    var messageCellTop: MessageCellTop!
    var messageCellDisplay: MessageCellDisplay!
    var messageBottomControls: MessageBottomControls!
    
    override init() {
        super.init(node: BaseNode())
        
        NotificationCenter.default.addObserver(self, selector: #selector(startTyping), name: NSNotification.Name("startTyping"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopTyping), name: NSNotification.Name("stopTyping"), object: nil)
        
    }
    
    override func viewDidLoad() {
        messageCellTop = MessageCellTop()
        messageCellTop.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 115)
        messageCellTop.zPosition = 10
        view.addSubnode(messageCellTop)
     
        messageBottomControls = MessageBottomControls()
        messageBottomControls.frame = CGRect(x: 0, y: 750, width: UIScreen.main.bounds.width, height: 100)
        messageBottomControls.zPosition = 10
        view.addSubnode(messageBottomControls)
        
    }
    
    @objc func startTyping() {
        messageBottomControls.barPopsUp()
        messageBottomControls.position.y -= 315
    }
    
    @objc func stopTyping() {
        messageBottomControls.barPopsDown()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MessageBottomControls {
    func barPopsUp() {
        let initialPosition = self.position.y
        let move = CABasicAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition - 315
        move.duration = 0.1
        self.layer.add(move, forKey: "position.y")
    }

    func barPopsDown() {
        let initialPosition = self.position.y
        let move = CABasicAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition + 315
        move.duration = 0.1
        self.layer.add(move, forKey: "position.y")
    }

}
