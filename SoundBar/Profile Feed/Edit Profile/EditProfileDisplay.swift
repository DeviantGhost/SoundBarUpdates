//
//  EditProfileDisplay.swift
//  SoundBar
//
//  Created by Justin Cose on 7/21/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

var editProfilePageTitle = ""
var editProfilePageInfo = ""

class EditProfileDisplay: BaseCellNode,  ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    
    let changeProfileText = ASTextNode()
    let switchAccount = ASTextNode()
    
    let profileImage = ASImageNode()
    let cellSeperator = ASImageNode()
    let cellSeperatorTwo = ASImageNode()
    let rightPadding = ASImageNode()
    
    let switchAccountBackground = ASImageNode()
    
    var dataSource = ["Name","Username","Website","Bio","Email","Phone","Gender","Birthday"]
    var dataSourceInfo = ["Justin Cose","@justincose","","Up and coming artist out","justinrcose@gmail.com","(773)-272-6162","Male","July 19, 2001"]
    
    override init() {
        super.init()
    
        self.backgroundColor = UIColor().backgroundGray()
        self.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        collectionNode = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 30)
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 30
            
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
    
        let changeProfileInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 8, bottom: 0, right: 0), child: changeProfileText)
        
        
        let topLayout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 10,
                                           justifyContent: .center,
                                           alignItems: .center,
                                              children: [profileImage, changeProfileInset])
        
        let backAppend = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 60,
                                           justifyContent: .center,
                                           alignItems: .center,
                                              children: [topLayout])
        
        let switchAccountLayout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 0,
                                           justifyContent: .center,
                                           alignItems: .center,
                                              children: [switchAccount])
        
        let switchAccountInset = ASInsetLayoutSpec(insets: .init(top: 20, left: 0, bottom: 0, right: 0), child: switchAccountLayout)
        
        let collectionInset = ASInsetLayoutSpec(insets: .init(top: 15, left: 10, bottom: 0, right: 0), child: collectionNode)
        
        
        let sectionLayout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 10,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [backAppend, cellSeperator, collectionInset,cellSeperatorTwo, switchAccountInset])
        
        let sectionInset = ASInsetLayoutSpec(insets: .init(top: 65, left: 0, bottom: 0, right: 0), child: sectionLayout)
        
        return sectionInset
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
            return EditProfileCell(Text: self!.dataSource[indexPath.row], Info: self!.dataSourceInfo[indexPath.row])
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("node: clicked at \(indexPath.row)")
    }
    
    private func setupNodes() {
        rightPadding.style.preferredSize = CGSize(width: 30, height: 30)
        
        profileImage.image = UIImage(named: "commentsPfp2" )
        profileImage.contentMode = .scaleAspectFill
        profileImage.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        profileImage.borderWidth = 1
        profileImage.cornerRadius = 100/2
        profileImage.clipsToBounds = true
        profileImage.style.preferredSize = .init(width: 100, height: 100)
        
        changeProfileText.attributedText = NSAttributedString(string: "Change Profile Photo", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        
        switchAccount.attributedText = NSAttributedString(string: "Switch to Artist Account", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        
        cellSeperator.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        cellSeperator.backgroundColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        
        cellSeperatorTwo.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        cellSeperatorTwo.backgroundColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        
        collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 460)
        
        switchAccountBackground.style.preferredSize = CGSize(width: 230, height: 40)
        switchAccountBackground.cornerRadius = 15
        switchAccountBackground.backgroundColor = UIColor().buttonsGray()
    }
    
    @objc private func backClicked() {
        self.closestViewController?.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

