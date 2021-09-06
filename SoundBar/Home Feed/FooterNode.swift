//
//  FooterNode.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-08-01.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit
import AVFoundation

class FooterNode: BaseNode {
    
//    let videoNode = ASVideoNode()
    let backgroundImageNode = ASImageNode()
    let profileImageNode = ASNetworkImageNode()
    let headphonesImage = ASImageNode()
    let userNameNode = ASTextNode()
    let listensNode = ASImageNode()
    let listenCount = ASTextNode()
    let playingTimeNode = ASTextNode()
    let songCaption = ASTextNode()
    
    let extraListensNode = ASImageNode()
    let extraListenCount = ASTextNode()
    let extraHeadphonesImage = ASImageNode()

    let sliderNode = ASDisplayNode { () -> UIView in
        func makeCircleWith(size: CGSize, backgroundColor: UIColor) -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            let context = UIGraphicsGetCurrentContext()
            context?.setFillColor(backgroundColor.cgColor)
            context?.setStrokeColor(UIColor.clear.cgColor)
            let bounds = CGRect(origin: .zero, size: size)
            context?.addEllipse(in: bounds)
            context?.drawPath(using: .fill)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        
        let slider = CustomSlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 25
        slider.maximumTrackTintColor = .white
        slider.minimumTrackTintColor = .yellow
        slider.setThumbImage(makeCircleWith(size: CGSize(width: 1, height: 1), backgroundColor: UIColor.white), for: .normal)
//        slider.addTarget(self, action: #selector(updateSlider(_:)), for: .allEvents)
        return slider
    }
    
    init(artist: String, caption: String, listens: String, shares: String) {
        super.init()
        setupNode(artist: artist, caption: caption, listens: listens, shares: shares)
        NotificationCenter.default.addObserver(self, selector: #selector(didViewFullSong), name: NSNotification.Name(rawValue: "playFullAudioClicked"), object: nil)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let sliderInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 2, bottom: 0, right: 0), child: sliderNode)
        let listenBoxStack = ASStackLayoutSpec(direction: .vertical,
                                         spacing: 0,
                                         justifyContent: .center,
                                         alignItems: .center,
                                         children: [headphonesImage, listenCount])
        
        let extraListenBoxStack = ASStackLayoutSpec(direction: .vertical,
                                         spacing: 0,
                                         justifyContent: .center,
                                         alignItems: .center,
                                         children: [extraHeadphonesImage, extraListenCount])
        let extraListenBoxCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: extraListenBoxStack)
        let extraListenOverlay = ASOverlayLayoutSpec(child: extraListensNode, overlay: extraListenBoxCenter)
        let extraHStackListen = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 0,
                                       justifyContent: .start,
                                       alignItems: .start,
                                       children: [extraListenOverlay])
        let leftPadding = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 0), child: extraHStackListen)
        leftPadding.style.flexGrow = 1
        
        let listenBoxCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: listenBoxStack)
        let listenOverlay = ASOverlayLayoutSpec(child: listensNode, overlay: listenBoxCenter)
        
        let hStackListen = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 0,
                                       justifyContent: .end,
                                       alignItems: .start,
                                       children: [listenOverlay])
        let rightPadding = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 15), child: hStackListen)
        rightPadding.style.flexGrow = 1
        
        let userNameCenter = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: userNameNode)
        let playingTimeInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 0, bottom: 0, right: 0), child: ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: playingTimeNode))
        let profileImageInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 0, bottom: 0, right: 0), child: profileImageNode)
        let songCaptionCenter = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: songCaption)
        let hStackNameListens = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 0,
                                       justifyContent: .start,
                                       alignItems: .stretch,
                                       children: [leftPadding, profileImageInset, rightPadding])

        let vStackDetails = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 5,
                                              justifyContent: .start,
                                              alignItems: .stretch,
                                              children: [hStackNameListens, userNameCenter, songCaptionCenter, playingTimeInset])
        let vStackDetailsOverlay = ASOverlayLayoutSpec(child: backgroundImageNode, overlay: vStackDetails)
        let vStackFooter = ASStackLayoutSpec(direction: .vertical,
                                       spacing: -5,
                                       justifyContent: .start,
                                       alignItems: .stretch,
                                       children: [vStackDetailsOverlay, sliderInset])
        vStackFooter.style.flexGrow = 1
        return vStackFooter
    }
    
    private func setupNode(artist: String, caption: String, listens: String, shares: String) {
        userNameNode.attributedText = NSAttributedString(string: artist, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        userNameNode.isHidden = true
        
        songCaption.attributedText = NSAttributedString(string: caption, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        songCaption.isHidden = true
        
        profileImageNode.style.preferredSize = .init(width: 75, height: 75)
        profileImageNode.cornerRadius = 75/2
        profileImageNode.url = URL(string: "https://upload.wikimedia.org/wikipedia/en/0/00/The_Child_aka_Baby_Yoda_%28Star_Wars%29.jpg")
        profileImageNode.isHidden = true
        
        listensNode.style.preferredSize = .init(width: 50, height: 50)
        listensNode.cornerRadius = 50/2
        listensNode.backgroundColor = .black
        listensNode.isHidden = true
        
        headphonesImage.style.preferredSize = .init(width: 20, height: 20)
        headphonesImage.cornerRadius = 20/2
        headphonesImage.image = .init(imageLiteralResourceName: "headphones")
        headphonesImage.isHidden = true
        
        listenCount.attributedText = NSAttributedString(string: listens, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)])
        listenCount.isHidden = true
        

    
        
        extraListensNode.style.preferredSize = .init(width: 50, height: 50)
        extraListensNode.cornerRadius = 50/2
        extraListensNode.backgroundColor = .black
        extraListensNode.isHidden = true
        
        extraHeadphonesImage.style.preferredSize = .init(width: 25, height: 25)
        extraHeadphonesImage.cornerRadius = 25/2
        extraHeadphonesImage.image = .init(imageLiteralResourceName: "profileButton")
        extraHeadphonesImage.isHidden = true
        
        extraListenCount.attributedText = NSAttributedString(string: shares, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)])
        extraListenCount.isHidden = true
        
        
        

        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.yellow, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        let partOne = NSMutableAttributedString(string: "0:00", attributes: attributes)
        let partTwo = NSMutableAttributedString(string: " / 2:22", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        let combination = NSMutableAttributedString()
        combination.append(partOne)
        combination.append(partTwo)
        playingTimeNode.attributedText = combination
        playingTimeNode.isHidden = true
        

        backgroundImageNode.backgroundColor = .init(white: 0.0, alpha: 0.8)
        backgroundImageNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 225)
        backgroundImageNode.isHidden = true
    }
    
    @objc private func didViewFullSong() {
        print("notification active")
        listensNode.isHidden = !listensNode.isHidden
        listenCount.isHidden = !listenCount.isHidden
        profileImageNode.isHidden = !profileImageNode.isHidden
        userNameNode.isHidden = !userNameNode.isHidden
        playingTimeNode.isHidden = !playingTimeNode.isHidden
        backgroundImageNode.isHidden = !backgroundImageNode.isHidden
        headphonesImage.isHidden = !headphonesImage.isHidden
        
        extraListensNode.isHidden = !extraListensNode.isHidden
        extraHeadphonesImage.isHidden = !extraHeadphonesImage.isHidden
        extraListenCount.isHidden = !extraListenCount.isHidden
        songCaption.isHidden = !songCaption.isHidden
    }
}

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: bounds.midY)
        return CGRect(origin: point, size: CGSize(width: UIScreen.main.bounds.width - 2, height: 4))
    }
}
