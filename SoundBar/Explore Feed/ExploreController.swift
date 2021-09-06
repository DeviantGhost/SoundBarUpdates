//
//  SearchController.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-08-06.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit
import UIKit

class ExploreController: ASDKViewController<BaseNode> {
    
    var subNodeAdded = false
    
    var searchBar: ExploreSearch!
    var explore: ExploreFeed!
    var songDisplayNode: BottomSongDisplay!
    var audioPlayer: AudioHandler!
    
    let animationHandler = SongsAnimationHandler()

    init(audio: AudioHandler) {
        super.init(node: BaseNode())
        
        searchBar = ExploreSearch()
        explore = ExploreFeed(audio: audio)
        self.node.addSubnode(explore)
        audioPlayer = audio
        self.node.backgroundColor = UIColor().backgroundGray()
        self.node.layoutSpecBlock = { [weak self] (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .zero, child: self!.explore)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
        if globalSongDisplayNode == nil {
            songDisplayNode = BottomSongDisplay(audio: audioPlayer, animationHandle: animationHandler, data: [])
            songDisplayNode.frame = CGRect(x: 0, y: (globalTabBar.tabBar.frame.minY), width: UIScreen.main.bounds.width, height: CGFloat(bottomSongDisplayHeight))
            print("songDisplayNode's yPosition: \(songDisplayNode.frame.minY)")
            songDisplayNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            songDisplayNode.zPosition = 500
            print("padding\(globalTabBar.tabBar.frame)")
            globalSongDisplayNode = songDisplayNode
        }
        if homeFeedTab && bottomSongDisplayLoaded == false{
            isPlayingSong = false
        }
        if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
            audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
        }else{
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)
        }

        view.addSubnode(globalSongDisplayNode ?? BaseNode())
        
        globalSongDisplayNode?.animationHandler.animateSongProgressBar(progressBar: "current", duration: globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds ?? 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subNodeAdded = true
        
        if homeFeedTab && bottomSongDisplayLoaded {
            globalSongDisplayNode?.audioPlayer.setCurrentTime(time: audioCurrentTime ?? CMTime() )
            globalSongDisplayNode?.audioPlayer.playFullSong()
            
            homeFeedTab = false
            isPlayingSong = true
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if homeFeedTab {
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)
        }
        if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
            audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
        }
        else{
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)
        }
        NotificationCenter.default.post(name: Notification.Name("stopSongPreview"), object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
