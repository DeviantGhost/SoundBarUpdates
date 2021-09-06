//
//  FirstTimePopUpPager.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-09.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class FirstTimePopUpPager: BaseNode, ASPagerDataSource, ASPagerDelegate, ASCollectionDataSource {
    
    let endButton = ASButtonNode()
    let pagerNode = ASPagerNode()
    let popupPages = [PagerCellNode(label1: "Your Feed", label2: "Click the arrow on a song preview you like to listen to the full song and you can toggle it to go back to the song preview.", imageName: "gif1"), PagerCellNode(label1: "Your Explore Page", label2: "Checkout the trending hits and simply click on the fire icon in the middle to listen to its preview or click on the album cover to start listening to the full song.", imageName: "gif2"), PagerCellNode(label1: "Your Profile", label2: "Finally, our profile page is all about you. Start adding playlists and listening to them by clicking the play button.", imageName: "gif3")]

    
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return popupPages.count
    }
    
    @objc func closePopup() {
        if pagerNode.currentPageIndex == 2 {
            UserDefaults.standard.set(true, forKey: "returningUser")
            NotificationCenter.default.post(name: NSNotification.Name("returningUser"), object: nil)
        } else {
            pagerNode.scrollToPage(at: pagerNode.currentPageIndex + 1, animated: true)
            pagerNode.currentPageIndex == 1 ? makeTitle(text: "Close") : nil
        }
    }
    
    func makeTitle(text: String) -> Void {
        endButton.setTitle(text, with: UIFont.init(name: "Futura-Bold", size: 20), with: .black, for: .normal)
    }
    
    override init() {
        super.init()
        pagerNode.dataSource = self
        pagerNode.delegate = self
        
        endButton.style.preferredSize = .init(width: UIScreen.main.bounds.width - 20, height: 50)
        endButton.backgroundColor = .systemYellow
        endButton.cornerRadius = 5
        endButton.addTarget(self, action: #selector(closePopup), forControlEvents: .touchUpInside)
        makeTitle(text: "Next")
//        pagerNode.
    }
    
    func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
        let page = popupPages[index]

        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = page
            cellNode.backgroundColor = .white
            return cellNode
        }
        return cellNodeBlock
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let inset = ASInsetLayoutSpec(insets: .zero, child: pagerNode)
        let insets = ASInsetLayoutSpec(insets: .init(top: .infinity, left: 10, bottom: 10, right: 10), child: endButton)
        return ASOverlayLayoutSpec(child: inset, overlay: insets)
    }
}
