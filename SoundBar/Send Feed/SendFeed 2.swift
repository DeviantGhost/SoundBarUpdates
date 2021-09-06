//
//  SendFeed.swift
//  SoundBar
//
//  Created by Justin Cose on 8/7/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SendFeed: BaseNode, ASTableDelegate, ASTableDataSource {

    let tableNode = ASTableNode()
   
    var sendTop: SendTop!
    var sendSearch: SendSearchBar!
    var sendButton: SendButton!
    var sendCells: SendCells!
    
    override init() {
        super.init()
        
        sendCells = SendCells()
        
        tableNode.allowsSelection = false
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .none
        tableNode.zPosition = 2
    
        tableNode.backgroundColor = UIColor().backgroundGray()

    }
    
    override func didEnterVisibleState() {
        sendTop = SendTop()
        sendTop.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        sendTop.backgroundColor = UIColor().topBackgroundGray()
        sendTop.zPosition = 15
        view.addSubnode(sendTop)
        
        sendSearch = SendSearchBar()
        sendSearch.frame = CGRect(x: (((UIScreen.main.bounds.width)-(UIScreen.main.bounds.width - 20)) / 2), y: 75, width: UIScreen.main.bounds.width - 20, height: 35)
        sendSearch.zPosition = 10
        view.addSubnode(sendSearch)
        
        sendButton = SendButton()
        sendButton.frame = CGRect(x: (((UIScreen.main.bounds.width)-(UIScreen.main.bounds.width - 50)) / 2), y: 700, width: UIScreen.main.bounds.width - 50, height: 50)
        sendButton.zPosition = 10
        view.addSubnode(sendButton)
    }
    
    override func didLoad() {
        tableNode.view.showsVerticalScrollIndicator = false
       
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .init(top: 120, left: 0, bottom: 0, right: 0), child: self.tableNode)
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRangeMake(CGSize(width: width, height: 0), CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        print("fetching new data")
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            return self!.sendCells
        }
    }
    
}
