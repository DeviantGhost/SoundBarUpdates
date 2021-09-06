//
//  RepostsCollectionNode.swift
//  SoundBar
//
//  Created by Justin Cose on 7/8/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class RepostsCollectionNode: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!

    var cellType: String!
    
    var reposts: [SongPresentation]? = nil
    var tracks: [SongPresentation]? = nil
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    var isArtist: Bool!
    
    init(tab: String!, cellData: [String: Any], audio: AudioHandler, animationHandle: SongsAnimationHandler, isArt: Bool) {
        super.init()
        
        cellType = tab
        audioPlayer = AudioHandler()
        animationHandler = animationHandle
        isArtist = isArt
        self.backgroundColor = .clear
        
        reposts = hotBarsDataSourceStatic
        tracks = hotBarsDataSourceStatic
        
        if cellType == "Reposts" {
            reposts = hotBarsDataSourceStatic
            reposts?.shuffle()
            
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 110)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                return collection
            }()
        }
        
        else if cellType == "Tracks" {
            tracks = hotBarsDataSourceStatic
            tracks?.shuffle()
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 110)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                return collection
            }()
        }
        
        else {
            tracks = hotBarsDataSourceStatic
            tracks?.shuffle()
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 110)
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                return collection
            }()
        }
        
        collectionNode.delegate = self
        collectionNode.dataSource = self
        setupNodes()
    }
    
    override func didLoad() {
        collectionNode.view.showsVerticalScrollIndicator = false
        collectionNode.view.isScrollEnabled = false
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let textStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [collectionNode])
        return textStack
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 2
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if cellType == "Reposts" {
//                return reposts?.count ?? 0
                return 10
            }
            else if cellType == "Tracks" {
//                return tracks?.count ?? 0
                return 10
            }
            else {
//                return tracks?.count ?? 0
                return 10
            }
        }
        else{
            return 1
        }
    }
    
    var isFavorites = true
    var isRecommended = true
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            if indexPath.section == 0 {
                if self?.cellType == "Reposts" {
                    let cell = RepostCell(clickedSong: self!.reposts![indexPath.row], audio: self!.audioPlayer, animationHandle: self!.animationHandler)
                    cell.delegateRepost = self
                    return cell
                }
                else if self?.cellType == "Tracks" {
                    let cell = RepostCell(clickedSong: self!.tracks![indexPath.row], audio: self!.audioPlayer, animationHandle: self!.animationHandler)
                    cell.delegateTrack = self
                    return cell
                }
                else {
                    return RepostCell(clickedSong: self!.tracks![indexPath.row], audio: self!.audioPlayer, animationHandle: self!.animationHandler)
                }
            }
            else if self?.cellType == "Reposts" {
                return AccountHomeDetails(tab: self?.cellType, songs: self!.reposts!)
            }
            else {
                return AccountHomeDetails(tab: self?.cellType, songs: self!.tracks!)
            }
        }
    }
    
    private func setupNodes() {
        collectionNode.backgroundColor = .clear
        if cellType == "Reposts" {
//            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: (CGFloat(reposts?.count ?? 0) * 110) + 110)
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: (CGFloat(10) * 110) + 110)

        }
        else if cellType == "Tracks" {
//            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: (CGFloat(tracks?.count ?? 0) * 110) + 110)
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: (CGFloat(10) * 110) + 110)

        }
        else {
//            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: (CGFloat(reposts?.count ?? 0) * 110) + 110)
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: (CGFloat(10) * 110) + 110)

        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

extension RepostsCollectionNode : RepostsCellDelegate, TracksCellDelegate {
    func deleteRepost(cell: RepostCell){
        if let indexPath = collectionNode?.indexPath(for: cell) {
            reposts?.remove(at: indexPath.row)
            collectionNode.deleteItems(at: [indexPath])
        }
    }
    
    func deleteTrack(cell: RepostCell){
        if let indexPath = collectionNode?.indexPath(for: cell) {
            reposts?.remove(at: indexPath.row)
            collectionNode.deleteItems(at: [indexPath])
        }
    }
}

