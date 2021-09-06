//
//  ProfileController.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-08-06.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class AccountProfileController: ASDKViewController<BaseNode> {
    
    var subNodeAdded = false

    var profile: ProfileFeedHome!
    
    var songDisplayNode: BottomSongDisplay!
    var audioPlayer: AudioHandler!
    let animationHandler = SongsAnimationHandler()
    
    var userInfo = ProfileHeader()
    
    init(audio: AudioHandler, data: ProfileHeader, isArt: Bool = false) {
        super.init(node: BaseNode())
        
        NotificationCenter.default.addObserver(self, selector: #selector(sharePagePops), name: NSNotification.Name(rawValue: "loadSharePopUp"), object: nil)
        
        self.view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    
        audioPlayer = audio
        userInfo = data
        profile = ProfileFeedHome(audio: audio, data: data, isArt: isArt, profileTop: ProfileInfo(userProfile: userInfo), profileTabBar: ProfileFeedButtons())

        let window = UIApplication.shared.windows[0]
        globalTopScreenPadding = window.safeAreaInsets.top
        
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .init(top: 0-globalTopScreenPadding, left: 0, bottom: 0, right: 0), child: self.profile)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
     
        if artistProfile == false {
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
            
                view.addSubnode(globalSongDisplayNode ?? BaseNode())
        }
        else {
            self.edgesForExtendedLayout = .all
            self.extendedLayoutIncludesOpaqueBars = true
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subNodeAdded = true
        artistProfile = false

        if homeFeedTab && bottomSongDisplayLoaded {
            globalSongDisplayNode?.audioPlayer.setCurrentTime(time: audioCurrentTime ?? CMTime() )
            globalSongDisplayNode?.audioPlayer.playFullSong()
            homeFeedTab = false
            isPlayingSong = true

        }
        globalSongDisplayNode?.animationHandler.animateSongProgressBar(progressBar: "current", duration: globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds ?? 0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
            audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
        }else{
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)
        }
    }
    
    @objc func sharePagePops() {
        let slideVC = ShareFeedPopUpViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountProfileController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PopUpViewController(presentedViewController: presented, presenting: presenting)
    }
}
