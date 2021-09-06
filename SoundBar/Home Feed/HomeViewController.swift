//
//  ViewController.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-07-31.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class HomeViewController: ASDKViewController<BaseNode> {
    
    var screen: HomeFeed!
    var headerNode: HeaderNode!
    var homeScreenAudio: AudioHandler!
    let topBar = ASImageNode()
    let animationHandler = HomeAnimationHandler()
    
    let gradientLayer = ASImageNode()
    
    init(space: Double, audio: AudioHandler) {
        super.init(node: BaseNode())
        
        NotificationCenter.default.addObserver(self, selector: #selector(commentPagePops), name: NSNotification.Name(rawValue: "loadCommentPopUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sharePagePops), name: NSNotification.Name(rawValue: "loadSharePopUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadWelcomePopUp), name: NSNotification.Name(rawValue: "loadWelcomePopUp"), object: nil)
        
        homeScreenAudio = audio
        screen = HomeFeed(space: space, audio: homeScreenAudio, animationHandle: animationHandler)
        self.node.addSubnode(screen)

        headerNode = HeaderNode(following: false, hotBars: true, audio: audio)
        headerNode.zPosition = 100
        headerNode.frame = CGRect(x: 0, y: (globalScreenTopPadding * 1.5), width: UIScreen.main.bounds.width, height: 30)
        view.addSubnode(headerNode)
      
        self.node.backgroundColor = .black
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .init(top: 0-globalScreenTopPadding, left: 0, bottom: 0, right: 0), child: self.screen)
        }
    }
    
    @objc func commentPagePops() {
        let slideVC = CommentPopUpViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    @objc func sharePagePops() {
        let slideVC = ShareFeedPopUpViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    @objc func loadWelcomePopUp() {
        let slideVC = BetaWelcomeViewController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        globalAudioPlayer?.setFullAudioLink(fullLink: fullSongLinkGlobal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeFeedTab = true
        isPlayingSong = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PopUpViewController(presentedViewController: presented, presenting: presenting)
    }
}

extension ASImageNode {
    func gradient(from color1: UIColor, to color2: UIColor) {
            let size = self.view.frame.size
            let width = size.width
            let height = size.height / 2

            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.colors = [color1.cgColor, color2.cgColor]
            gradient.locations = [0.0 , 1.0]
            gradient.startPoint = CGPoint(x: width/2, y: 1.0)
            gradient.endPoint = CGPoint(x: width/2, y: 0.0)
            gradient.frame = CGRect(x: 0.0, y: self.view.frame.size.height - height, width: width, height: height)
            self.view.layer.insertSublayer(gradient, at: 0)
    }
}

