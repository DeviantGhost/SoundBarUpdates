//
//  SettingCollectionCells.swift
//  SoundBar
//
//  Created by Justin Cose on 9/3/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SettingCollectionCells: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    
    var cellType: String!
    
    let titleText = ASTextNode()

    let cellSeperator = ASImageNode()
    
    var dataSource = Array<Any>()
    var dataSourceIcons = Array<Any>()
    
    init(type: String!, data: Array<Any>, icons: Array<Any>) {
        super.init()
        
        cellType = type
        dataSource = data
        dataSourceIcons = icons
        print ("CellType: \(String(describing: cellType))")

        self.backgroundColor = UIColor().backgroundGray()
        
        collectionNode = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 30)
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 15
            
            let collection = ASCollectionNode(collectionViewLayout: flowLayout)
            collection.backgroundColor = .clear
            collection.isPagingEnabled = true
            return collection
        }()
        
        
        
        
        collectionNode.delegate = self
        collectionNode.dataSource = self

        setupNodes()
    }
    
    override func didLoad() {
        collectionNode.view.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
        let titleInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 8, bottom: 0, right: 0), child: titleText)
        
        let collectionInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: collectionNode)
        
        let sectionLayout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 10,
                                           justifyContent: .start,
                                           alignItems: .start,
                                           children: [titleInset, cellSeperator, collectionInset])
        
        return sectionLayout
    
        
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }

            return SettingsDataNode(Text: self!.dataSource[indexPath.row] as? String, Icons: self!.dataSourceIcons[indexPath.row] as? String)
        }
        
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("node: clicked at \(indexPath.row)")
    }
    
    private func setupNodes() {
        
        cellSeperator.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - 80, height: 1)
        cellSeperator.backgroundColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        
        if cellType == "Account" {
            
            titleText.attributedText = NSAttributedString(string: "Account", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.84313725, blue: 0, alpha: 1), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
            collectionNode.backgroundColor = .clear
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 180)
            
        } else if cellType == "General" {
            
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 90)
            
            titleText.attributedText = NSAttributedString(string: "General", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.84313725, blue: 0, alpha: 1), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
            collectionNode.backgroundColor = .clear
            
            
        } else if cellType == "Support" {
            
            titleText.attributedText = NSAttributedString(string: "Support", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.84313725, blue: 0, alpha: 1), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
            
            collectionNode.backgroundColor = .clear
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 90)
            
        } else if cellType == "About" {
            titleText.attributedText = NSAttributedString(string: "About", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.84313725, blue: 0, alpha: 1), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
            
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 435)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
