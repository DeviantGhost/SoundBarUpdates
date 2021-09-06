//
//  ProfileController.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-08-06.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit
import UIKit

var userID = ""
var homeFeedTab = false
var songBoxDisplaying = false
var globalSongDisplayNode: BottomSongDisplay?
var audioCurrentTime: CMTime?
var bottomSongDisplayHeight = CGFloat(55)

class LibraryController: ASDKViewController<BaseNode> {
    
    var subNodeAdded = false

    var profile: LibraryFeed!
    var temporaryUser: GuestFeed!
    var songDisplayNode: BottomSongDisplay!
    var audioPlayer: AudioHandler!
    let animationHandler = SongsAnimationHandler()
    
    init(audio: AudioHandler, data: ProfileHeader? = ProfileHeader(coverLink: "", profileLink: "commentsPfp10", username: "@jacksmith", followersCount: 853, followingCount: 4374, likesCount: 827, bio: "Just a young artist trying to get their start!\nChicago📍🏙", bioLink: nil, fullName: "Jack Smith", id: nil, socials: nil, listens: 9390), isArt: Bool = false) {
        super.init(node: BaseNode())
        
        NotificationCenter.default.addObserver(self, selector: #selector(sharePagePops), name: NSNotification.Name(rawValue: "loadSharePopUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(newPlaylistPops), name: NSNotification.Name(rawValue: "addNewPlaylist"), object: nil)
        
        profile = LibraryFeed(audio: audio, data: data!, libraryTop: LibrarySearchTop(), libraryTabBar: LibraryButtons())
        audioPlayer = AudioHandler()
        audioPlayer = audio
        temporaryUser = GuestFeed()
        
        self.view.backgroundColor = UIColor().topBackgroundGray()
        self.node.layoutSpecBlock = { [weak self] (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .zero, child: self!.profile)
        }
        
        currentTab = "Playlists"
        moreType = "Playlist"
    }
    
    @objc func sharePagePops() {
        let slideVC = ShareFeedPopUpViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
        print("SHARING")
    }
    
    @objc func newPlaylistPops() {
        let slideVC = NewPlaylistPopUpViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
        print("SHARING")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
        if globalSongDisplayNode == nil {
            songDisplayNode = BottomSongDisplay(audio: audioPlayer, animationHandle: animationHandler, data: [])
            songDisplayNode.frame = CGRect(x: 0, y: (globalTabBar.tabBar.frame.minY), width: UIScreen.main.bounds.width, height: CGFloat(bottomSongDisplayHeight))
            songDisplayNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            songDisplayNode.zPosition = 500

            globalSongDisplayNode = songDisplayNode
        }
        if homeFeedTab && bottomSongDisplayLoaded == false{
            isPlayingSong = false
        }
        if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
            audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
        }
        else{
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
        
        globalSongDisplayNode?.animationHandler.animateSongProgressBar(progressBar: "current", duration: globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds ?? 0)
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

extension LibraryController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PopUpViewController(presentedViewController: presented, presenting: presenting)
    }
}

//extension UIDevice {
//    static func vibrate() {
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
//    }
//}
//
//NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//@objc func keyboardWillShow(_ notification: Notification) {
//    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//        let keyboardRectangle = keyboardFrame.cgRectValue
//        let keyboardHeight = keyboardRectangle.height
//    }
//}
