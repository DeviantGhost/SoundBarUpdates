//
//  PlaylistPageViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 2/25/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class PlaylistPageViewController: ASDKViewController<BaseNode> {
    
    var playlistPage: PlaylistPage!
     var imageNode = ASImageNode()
    
    init(audio: AudioHandler, playlistSongs: [SongPresentation], animationHandle: SongsAnimationHandler) {
        super.init(node: BaseNode())
        
        NotificationCenter.default.addObserver(self, selector: #selector(sharePagePops), name: NSNotification.Name(rawValue: "loadSharePopUp"), object: nil)
        
        let window = UIApplication.shared.windows[0]
        globalTopScreenPadding = window.safeAreaInsets.top
        
        playlistPage = PlaylistPage(audio: audio, animationHandle: animationHandle, data: playlistSongs)
        self.node.addSubnode(playlistPage)
        self.node.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
        self.node.layoutSpecBlock = { [self] (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .init(top: -globalTopScreenPadding, left: 0, bottom: 0, right: 0), child: self.playlistPage)
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

extension PlaylistPageViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PopUpViewController(presentedViewController: presented, presenting: presenting)
    }
}
