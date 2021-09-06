//
//  FullSongPageViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 8/8/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class FullSongPageViewController: ASDKViewController<BaseNode> {
    var queuePageOpen = false

    var fullSongSocials: FullSongPageSocialControls!
    var fullSongComment: FullSongPageComment!
    var fullSongPageTop: FullSongPageTop!

    var dataSource: [SongPresentation]!

    var song = hotBarsDataSourceStatic[20]

    var audioPlayer: AudioHandler!

    var backgroundImage = ASImageNode()

    var shadow = ASImageNode()

    var queueDisplayNode: QueueDisplayPage!

    var animationHandler: HomeAnimationHandler!

    var didAddGradient = false

    var keyboardHeight: CGFloat!
    
    init(audio: AudioHandler) {
        super.init(node: BaseNode())
        
        NotificationCenter.default.addObserver(self, selector: #selector(commentPagePops), name: NSNotification.Name(rawValue: "loadCommentPopUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sharePagePops), name: NSNotification.Name(rawValue: "loadSharePopUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(queuePageToggle), name: NSNotification.Name(rawValue: "loadQueuePage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(songChanged), name: NSNotification.Name(rawValue: "updateUI"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startTyping), name: NSNotification.Name("startTyping"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopTyping), name: NSNotification.Name("stopTyping"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        fullSongOpen = true
        
        animationHandler = HomeAnimationHandler()
        audioPlayer = audio
        dataSource = hotBarsDataSourceStatic

        fullSongComment = FullSongPageComment()
        
        fullSongPageTop = FullSongPageTop()
        fullSongPageTop.frame = CGRect(x: 0, y: Int(UIScreen.main.bounds.height / 18.75), width: Int(UIScreen.main.bounds.width), height: 30)
        fullSongPageTop.zPosition = 10
        view.addSubnode(fullSongPageTop)
        
        fullSongSocials = FullSongPageSocialControls(likes: "\(formatNumber(fullSongPageData.likes!))",
                                                     shares:  "\(formatNumber(fullSongPageData.shares!))",
                                                     comments:  "\(formatNumber(fullSongPageData.comments!))",
                                                     artistID: fullSongPageData.artistID ?? "",
                                                     songName: fullSongPageData.songName ?? "",
                                                     imageLink: fullSongPageData.profileImageLink ?? "",
                                                     id: fullSongPageData.id ?? "",
                                                     fullLink: fullSongLinkGlobal ,
                                                     snippetLink: fullSongPageData.snippetLink ?? "",
                                                     audio: audioPlayer, homeAnimationHandler: animationHandler)

        

        self.node.addSubnode(fullSongSocials)
        self.node.addSubnode(fullSongComment)

        backgroundImage.image = UIImage(named: fullSongImageGlobal)
        backgroundImage.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        backgroundImage.addTarget(self, action: #selector(toggleSongRunning), forControlEvents: .touchUpInside)

        shadow.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        shadow.backgroundColor = .black
        shadow.alpha = 0.3
    
        self.node.backgroundColor = UIColor().backgroundGray()
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            let display = ASStackLayoutSpec(direction: .vertical,
                                                spacing: 0,
                                                justifyContent: .end,
                                                alignItems: .center,
                                                children: [self.fullSongSocials, self.fullSongComment])
            
            let displayInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 15, right: 0), child: display)
            let shadowOverlay = ASOverlayLayoutSpec(child: self.backgroundImage, overlay: self.shadow)
            let displayOverlay = ASOverlayLayoutSpec(child: shadowOverlay, overlay: displayInset)

            return ASInsetLayoutSpec(insets: .zero, child: displayOverlay)
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
    
    @objc func startTyping() {
        fullSongComment.barPopsUp(keyboard: keyboardHeight)
    }

    @objc func stopTyping() {
        fullSongComment.barPopsUp(keyboard: keyboardHeight)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print("Keyboard show notification two")
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }

    @objc override func viewWillDisappear(_ animated: Bool) {
        fullSongSocials.removeFromSupernode()
        fullSongComment.removeFromSupernode()
    }
    
    @objc func queuePageToggle(){
        if queuePageOpen == false {
            NotificationCenter.default.post(name: NSNotification.Name("setSongNameAndArtist"), object: nil, userInfo: ["name": song.songName!, "image": song.imageLink!])

            queueDisplayNode = QueueDisplayPage(audio: audioPlayer, data: dataSource)
            queueDisplayNode.frame = CGRect(x: 0, y: Int(UIScreen.main.bounds.height / 10.55), width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height / 1.44))
            queueDisplayNode.backgroundColor = .clear
            shadow.shadowEaseIn()
            view.addSubnode(self.queueDisplayNode)
            
            self.queuePageOpen = true
            
            NotificationCenter.default.post(name: NSNotification.Name("fullSongControlsClose"), object: nil)
        }
        
        else if queuePageOpen == true{
            NotificationCenter.default.post(name: NSNotification.Name("fullSongControlsOpen"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("closeQueuePage"), object: nil)

            shadow.shadowEaseOut()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.queueDisplayNode.removeFromSupernode()
                self.queuePageOpen = false
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        fullSongOpen = false
    }
    
    @objc func songChanged(){
        backgroundImage.image = UIImage(named: fullSongImageGlobal)
    }
    
    @objc func toggleSongRunning(){
        audioPlayer.togglePlay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FullSongPageViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PopUpViewController(presentedViewController: presented, presenting: presenting)
    }
}

extension FullSongPageComment {
    func barPopsUp(keyboard: CGFloat) {
        let initialPosition = self.position.y
        let move = CABasicAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition - keyboard
        move.duration = 0.1
        self.layer.add(move, forKey: "position.y")
    }
    
    func barPopsDown(keyboard: CGFloat) {
        let initialPosition = self.position.y
        let move = CABasicAnimation(keyPath: "position.y")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition + keyboard
        move.duration = 0.1
        self.layer.add(move, forKey: "position.y")
    }
}

