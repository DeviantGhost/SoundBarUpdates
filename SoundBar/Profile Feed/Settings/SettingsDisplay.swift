//
//  SettingsDisplay.swift
//  SoundBar
//
//  Created by Justin Cose on 2021-03-22.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit



class SettingsDisplay: BaseNode {
    
    
    let tableNode = ASTableNode()
    
    let settingsViewModel = SettingsViewModel()
    
    override init() {
        super.init()
        self.backgroundColor = .clear
        tableNode.allowsSelection = false
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        tableNode.zPosition = 10
        
        tableNode.view.separatorStyle = .none
        settingsViewModel.reloadTableView = {
            self.tableNode.reloadData()
        }
    }
    
    override func didLoad() {
        tableNode.view.showsVerticalScrollIndicator = false
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: self.tableNode)
    }
    
    
}

extension SettingsDisplay: ASTableDelegate, ASTableDataSource{
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
        return 4
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            return self!.settingsViewModel.getCellAt(cell: indexPath)
        }
    }
}







