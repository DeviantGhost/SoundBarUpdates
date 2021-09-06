//
//  MessagesPageViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 3/16/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class MessagesPageViewController: ASDKViewController<BaseNode> {
    
    var messagesDisplay: MessagesDisplay!
    var messagesTop: MessagesTop!
    var messagesSearch: MessagesSearch!
    
    override init() {
        super.init(node: BaseNode())
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearSearchBar), name: NSNotification.Name("clearSearchBar"), object: nil)
        
        messagesDisplay = MessagesDisplay()
        self.node.addSubnode(messagesDisplay)
        self.node.backgroundColor = UIColor().backgroundGray()
        self.node.layoutSpecBlock = { [self] (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .init(top: 155, left: 0, bottom: 0, right: 0), child: self.messagesDisplay)
        }
        
        setupNodes()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clearSearchBar() {
        DispatchQueue.main.async {
            self.messagesSearch.searchText.resignFirstResponder()
        }
    }
    
    func setupNodes() {
        messagesTop = MessagesTop()
        messagesTop.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 90)
        messagesTop.zPosition = 10
        view.addSubnode(messagesTop)
    
        messagesSearch = MessagesSearch()
        messagesSearch.frame = CGRect(x: (((UIScreen.main.bounds.width)-(UIScreen.main.bounds.width - 20)) / 2), y: 105, width: UIScreen.main.bounds.width - 20, height: 35)
        messagesSearch.zPosition = 10
        view.addSubnode(messagesSearch)
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

