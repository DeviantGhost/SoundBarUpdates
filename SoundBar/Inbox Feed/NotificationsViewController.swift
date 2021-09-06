//
//  NotifcationsViewController.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-22.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class NotifcationsViewController: ASDKViewController<BaseNode> {
    
    var subNodeAdded = false
    
    var songDisplayNode: BottomSongDisplay!
    
    let animationHandler = SongsAnimationHandler()
    
    var notificationsDisplay: NotificationsDisplay!
    let topBackgroundBar = ASImageNode()
    let backgroundBar = ASImageNode()
    let messagesButton = ASImageNode()
    let activityDropDown = ASTextNode()
    let backButton = ASImageNode()
    var audioPlayer: AudioHandler!
    
    override init() {
        
        audioPlayer = AudioHandler()
        
        super.init(node: BaseNode())
        notificationsDisplay = NotificationsDisplay()
        self.node.addSubnode(notificationsDisplay)
        
        self.node.backgroundColor = UIColor().backgroundGray()
        
        self.node.layoutSpecBlock = { [self] (node, constrainedSize) in
            
            let topControls = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: UIScreen.main.bounds.size.width / 4,
                                                justifyContent: .center,
                                                alignItems: .center,
                                                children: [backButton, activityDropDown, messagesButton])
            
            let topControlsInset = ASInsetLayoutSpec(insets: .init(top: globalTopScreenPadding, left: 0, bottom: 0, right: 0), child: topControls)
            let topControlsOverlay = ASOverlayLayoutSpec(child: backgroundBar, overlay: topControlsInset)
            
            let vStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 0,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [topControlsOverlay, self.notificationsDisplay])
            return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: vStack)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false

        if globalSongDisplayNode == nil {
            songDisplayNode = BottomSongDisplay(audio: globalAudioPlayer ?? audioPlayer, animationHandle: animationHandler, data: [])
            songDisplayNode.frame = CGRect(x: 0, y: (globalTabBar.tabBar.frame.minY), width: UIScreen.main.bounds.width, height: CGFloat(bottomSongDisplayHeight))
            songDisplayNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            songDisplayNode.zPosition = 500

            globalSongDisplayNode = songDisplayNode
        }
        
        if homeFeedTab && bottomSongDisplayLoaded == false{
            isPlayingSong = false
        }
        
        view.addSubnode(globalSongDisplayNode ?? BaseNode())
        
        if homeFeedTab && bottomSongDisplayLoaded {
            globalSongDisplayNode?.audioPlayer.setCurrentTime(time: audioCurrentTime ?? CMTime() )
            globalSongDisplayNode?.audioPlayer.playFullSong()
            isPlayingSong = true

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        subNodeAdded = true
        
        if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
            audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
        }
        else{
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)
        }
        if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
            audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
        }
        else{
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)
        }
        
        globalSongDisplayNode?.animationHandler.animateSongProgressBar(progressBar: "current", duration: globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds ?? 0)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if homeFeedTab {
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)
        }

        NotificationCenter.default.post(name: Notification.Name("stopSongPreview"), object: nil)
    }
    
    override func viewDidLoad() {
        setupNodes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNodes() {
        topBackgroundBar.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
        topBackgroundBar.backgroundColor = UIColor().topBackgroundGray()
        
        backgroundBar.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 9.377)
        backgroundBar.backgroundColor = UIColor().topBackgroundGray()
        
        backButton.style.preferredSize = CGSize(width: 50, height: 50)
        
        activityDropDown.attributedText = NSAttributedString(string: "All Activity", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        
        messagesButton.image = UIImage(named: "MessageIcon")
        messagesButton.style.preferredSize = CGSize(width: 50, height: 50)
        messagesButton.addTarget(self, action: #selector(messages), forControlEvents: .touchUpInside)
    }
 
    @objc func messages() {
        let vc = MessagesPageViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
