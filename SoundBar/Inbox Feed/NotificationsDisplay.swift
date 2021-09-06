//
//  NotificationsDisplay.swift
//  SoundBar
//
//  Created by Justin Cose on 2021-03-22.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit


class NotificationsDisplay: BaseNode, ASCollectionDelegate, ASCollectionDataSource {

    var notificationCells: ASCollectionNode!
    
    var separatorLineTop = ASImageNode()
    var separatorLineBottom = ASImageNode()
    
    var addHeaderBox = ASImageNode()
    var addHeaderText = ASTextNode()
    
    var roundedCornerImage = ASImageNode()
    
    var addCommentBox = ASImageNode()
    var addCommentText = ASTextNode()
    
    var cancelButton = ASButtonNode()
    var cancelButtonCounterWeight = ASImageNode()
    var notificationsData: [NotificationsModel] = []
    
    override init() {
        super.init()
    
        notificationCells = {
            let flowLayout = UICollectionViewFlowLayout()
            let commetSize = CGSize(width: UIScreen.main.bounds.width, height: 75)
            flowLayout.collectionView?.showsVerticalScrollIndicator = false
            flowLayout.itemSize = commetSize
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 10
            
            let collection = ASCollectionNode(collectionViewLayout: flowLayout)
            
            return collection
            
        }()
        
        for (index, _) in globalProfileImageData.enumerated() {
            let notifType: NotifType = [NotifType.Following, NotifType.LikedComment, NotifType.Repost, NotifType.Released].randomElement()!
            notificationsData.append(NotificationsModel(profileImages: Array(globalProfileImageData.shuffled().prefix(3)), username: globalUsernameData[index], message: notifType == NotifType.Following ? "" : globalCommentData[index], type: notifType, likes: Int(globalLikeCountData[index]), timestamp: globalTimeStampData[index], songReference: notifType == NotifType.TikTokProduction ? (globalTiktokData.randomElement()) :  (hotBarsDataSourceStatic.shuffled()[index]).imageLink))
        }
        
        notificationCells.showsVerticalScrollIndicator = false
        setupNodes()
        
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return globalProfileImageData.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            return NotificationCellData(notification: self!.notificationsData[indexPath.row])
        }
    }
    
    func setupNodes() {
        notificationCells.dataSource = self
        notificationCells.delegate = self
        notificationCells.backgroundColor = UIColor().backgroundGray()
        notificationCells.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - (tabBarHeight * 2))
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let notificationsDisplay = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: notificationCells)
        return notificationsDisplay
    }
}
