
//
//  CommentPopUp.swift
//  SoundBar
//
//  Created by Justin Cose on 2/19/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.


import AsyncDisplayKit
import AVFoundation
import UIKit

class GenreViewModel: BaseCellNode {
    
    
    var genreCellData: GenreCellData!

    var titleText = ASTextNode()
    let submitText = ASTextNode()

    let submitBox = ASImageNode()
    
    var genreImageData = ["rapImg","rockImg","alternativeImg","jazzImg","reggaeImg","hipHopImg","countryImg","EDMImg","popImg","classicalImg", "indieImg", "RNBImg"]
    
    var genreTextData = ["Rap","Rock","Alternative","Jazz","Reggae","HipHop","Country","EDM","Pop","Classical", "Indie", "R&B"]
    
    override init() {
        super.init()
        setupNodes()

        
    }
    
    func setupNodes() {
        
        genreCellData = GenreCellData(GenreImage: genreImageData, GenreText: genreTextData)
       
        genreCellData.backgroundColor = .clear
        view.addSubnode(genreCellData)
        
        titleText.attributedText = NSAttributedString(string: "Preferred Genre", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)])
        
        submitText.attributedText = NSAttributedString(string: "Submit", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        
        submitBox.backgroundColor = UIColor().soundbarColorScheme()
        submitBox.borderWidth = 1
        submitBox.cornerRadius = 20
        submitBox.style.preferredSize = CGSize(width: 230, height: 40)
        submitBox.addTarget(self, action: #selector(submitButtonClicked), forControlEvents: .touchUpInside)
       
    }
    
    @objc private func submitButtonClicked() {
        NotificationCenter.default.post(name: Notification.Name("uploadPhoto"), object: nil)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
       
        
        let titleCenter = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: titleText)
        let centerSubmitLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: submitText)

        let submitOverlay = ASOverlayLayoutSpec(child: submitBox, overlay: centerSubmitLayout)
        let submitInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 0, bottom: 0, right: 0), child: submitOverlay)

        let commentVerticalStack = ASStackLayoutSpec(direction: .vertical,
                                                     spacing: 20,
                                                     justifyContent: .center,
                                                     alignItems: .center,
                                                     children: [titleCenter, genreCellData, submitInset])
        return commentVerticalStack
    }
}


class GenreCellData: BaseCellNode {
    
    var genreImage = Array<Any>()
    var genreTxt = Array<Any>()
    
    var genreCircleOne = ASImageNode()
    var genreCircleTwo = ASImageNode()
    var genreCircleThree = ASImageNode()
    var genreCircleFour = ASImageNode()
    var genreCircleFive = ASImageNode()
    var genreCircleSix = ASImageNode()
    var genreCircleSeven = ASImageNode()
    var genreCircleEight = ASImageNode()
    var genreCircleNine = ASImageNode()
    var genreCircleTen = ASImageNode()
    var genreCircleEleven = ASImageNode()
    var genreCircleTweleve = ASImageNode()

    var genreImg = ASImageNode()
    var genreOverlay = ASImageNode()
    var songDisk = ASImageNode()
    
    var genreTxtOne = ASTextNode()
    var genreTxtTwo = ASTextNode()
    var genreTxtThree = ASTextNode()
    var genreTxtFour = ASTextNode()
    var genreTxtFive = ASTextNode()
    var genreTxtSix = ASTextNode()
    var genreTxtSeven = ASTextNode()
    var genreTxtEight = ASTextNode()
    var genreTxtNine = ASTextNode()
    var genreTxtTen = ASTextNode()
    var genreTxtEleven = ASTextNode()
    var genreTxtTweleve = ASTextNode()



    init(GenreImage: Array<Any>, GenreText: Array<Any>) {
        super.init()
        
        genreImage = GenreImage
        genreTxt = GenreText
         
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        
        let photoTxtLayoutOne = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtOne)
        let photoTxtLayoutTwo = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtTwo)
        let photoTxtLayoutThree = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtThree)
        let photoTxtLayoutFour = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtFour)
        let photoTxtLayoutFive = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtFive)
        let photoTxtLayoutSix = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtSix)
        let photoTxtLayoutSeven = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtSeven)
        let photoTxtLayoutEight = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtEight)
        let photoTxtLayoutNine = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtNine)
        let photoTxtLayoutTen = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtTen)
        let photoTxtLayoutEleven = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtEleven)
        let photoTxtLayoutTweleve = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: genreTxtTweleve)

        
        let genreOverlayOne = ASOverlayLayoutSpec(child: genreCircleOne, overlay: photoTxtLayoutOne)
        let genreOverlayTwo = ASOverlayLayoutSpec(child: genreCircleTwo, overlay: photoTxtLayoutTwo)
        let genreOverlayThree = ASOverlayLayoutSpec(child: genreCircleThree, overlay: photoTxtLayoutThree)
        let genreOverlayFour = ASOverlayLayoutSpec(child: genreCircleFour, overlay: photoTxtLayoutFour)
        let genreOverlayFive = ASOverlayLayoutSpec(child: genreCircleFive, overlay: photoTxtLayoutFive)
        let genreOverlaySix = ASOverlayLayoutSpec(child: genreCircleSix, overlay: photoTxtLayoutSix)
        let genreOverlaySeven = ASOverlayLayoutSpec(child: genreCircleSeven, overlay: photoTxtLayoutSeven)
        let genreOverlayEight = ASOverlayLayoutSpec(child: genreCircleEight, overlay: photoTxtLayoutEight)
        let genreOverlayNine = ASOverlayLayoutSpec(child: genreCircleNine, overlay: photoTxtLayoutNine)
        let genreOverlayTen = ASOverlayLayoutSpec(child: genreCircleTen, overlay: photoTxtLayoutTen)
        let genreOverlayEleven = ASOverlayLayoutSpec(child: genreCircleEleven, overlay: photoTxtLayoutEleven)
        let genreOverlayTweleve = ASOverlayLayoutSpec(child: genreCircleTweleve, overlay: photoTxtLayoutTweleve)
        
        let genreRowOne = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 10,
                                           justifyContent: .center,
                                           alignItems: .center,
                                           children: [genreOverlayOne,genreOverlayTwo,genreOverlayThree])
        
        let genreRowTwo = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 10,
                                           justifyContent: .center,
                                           alignItems: .center,
                                           children: [genreOverlayFour,genreOverlayFive,genreOverlaySix])
        
        let genreRowThree = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 10,
                                           justifyContent: .center,
                                           alignItems: .center,
                                           children: [genreOverlaySeven,genreOverlayEight,genreOverlayNine])
        
        let genreRowFour = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 10,
                                           justifyContent: .center,
                                           alignItems: .center,
                                           children: [genreOverlayTen, genreOverlayEleven, genreOverlayTweleve])
        
        let genreRows = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 10,
                                           justifyContent: .center,
                                           alignItems: .center,
                                           children: [genreRowOne,genreRowTwo,genreRowThree,genreRowFour])
        return genreRows
    }
    
    private func setupNodes() {
        genreTxtOne.attributedText = NSAttributedString(string: genreTxt[0] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleOne.image = UIImage(named: genreImage[0] as! String)
        genreCircleOne.contentMode = .scaleAspectFill
        genreCircleOne.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleOne.borderWidth = 1
        genreCircleOne.cornerRadius = 110/2
        genreCircleOne.clipsToBounds = true
        genreCircleOne.style.preferredSize = .init(width: 110, height: 110)
        genreCircleOne.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
        genreTxtTwo.attributedText = NSAttributedString(string: genreTxt[1] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleTwo.image = UIImage(named: genreImage[1] as! String)
        genreCircleTwo.contentMode = .scaleAspectFill
        genreCircleTwo.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleTwo.borderWidth = 1
        genreCircleTwo.cornerRadius = 110/2
        genreCircleTwo.clipsToBounds = true
        genreCircleTwo.style.preferredSize = .init(width: 110, height: 110)
        genreCircleTwo.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
        genreTxtThree.attributedText = NSAttributedString(string: genreTxt[2] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleThree.image = UIImage(named: genreImage[2] as! String)
        genreCircleThree.contentMode = .scaleAspectFill
        genreCircleThree.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleThree.borderWidth = 1
        genreCircleThree.cornerRadius = 110/2
        genreCircleThree.clipsToBounds = true
        genreCircleThree.style.preferredSize = .init(width: 110, height: 110)
        genreCircleThree.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
        genreTxtFour.attributedText = NSAttributedString(string: genreTxt[3] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleFour.image = UIImage(named: genreImage[3] as! String)
        genreCircleFour.contentMode = .scaleAspectFill
        genreCircleFour.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleFour.borderWidth = 1
        genreCircleFour.cornerRadius = 110/2
        genreCircleFour.clipsToBounds = true
        genreCircleFour.style.preferredSize = .init(width: 110, height: 110)
        genreCircleFour.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
        genreTxtFive.attributedText = NSAttributedString(string: genreTxt[4] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleFive.image = UIImage(named: genreImage[4] as! String)
        genreCircleFive.contentMode = .scaleAspectFill
        genreCircleFive.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleFive.borderWidth = 1
        genreCircleFive.cornerRadius = 110/2
        genreCircleFive.clipsToBounds = true
        genreCircleFive.style.preferredSize = .init(width: 110, height: 110)
        genreCircleFive.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
        genreTxtSix.attributedText = NSAttributedString(string: genreTxt[5] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleSix.image = UIImage(named: genreImage[5] as! String)
        genreCircleSix.contentMode = .scaleAspectFill
        genreCircleSix.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleSix.borderWidth = 1
        genreCircleSix.cornerRadius = 110/2
        genreCircleSix.clipsToBounds = true
        genreCircleSix.style.preferredSize = .init(width: 110, height: 110)
        genreCircleSix.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
        genreTxtSeven.attributedText = NSAttributedString(string: genreTxt[6] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleSeven.image = UIImage(named: genreImage[6] as! String)
        genreCircleSeven.contentMode = .scaleAspectFill
        genreCircleSeven.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleSeven.borderWidth = 1
        genreCircleSeven.cornerRadius = 110/2
        genreCircleSeven.clipsToBounds = true
        genreCircleSeven.style.preferredSize = .init(width: 110, height: 110)
        genreCircleSeven.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
        genreTxtEight.attributedText = NSAttributedString(string: genreTxt[7] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleEight.image = UIImage(named: genreImage[7] as! String)
        genreCircleEight.contentMode = .scaleAspectFill
        genreCircleEight.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleEight.borderWidth = 1
        genreCircleEight.cornerRadius = 110/2
        genreCircleEight.clipsToBounds = true
        genreCircleEight.style.preferredSize = .init(width: 110, height: 110)
        genreCircleEight.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
        genreTxtNine.attributedText = NSAttributedString(string: genreTxt[8] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleNine.image = UIImage(named: genreImage[8] as! String)
        genreCircleNine.contentMode = .scaleAspectFill
        genreCircleNine.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleNine.borderWidth = 1
        genreCircleNine.cornerRadius = 110/2
        genreCircleNine.clipsToBounds = true
        genreCircleNine.style.preferredSize = .init(width: 110, height: 110)
        genreCircleNine.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
        genreTxtTen.attributedText = NSAttributedString(string: genreTxt[9] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleTen.image = UIImage(named: genreImage[9] as! String)
        genreCircleTen.contentMode = .scaleAspectFill
        genreCircleTen.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleTen.borderWidth = 1
        genreCircleTen.cornerRadius = 110/2
        genreCircleTen.clipsToBounds = true
        genreCircleTen.style.preferredSize = .init(width: 110, height: 110)
        genreCircleTen.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
        genreTxtEleven.attributedText = NSAttributedString(string: genreTxt[10] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleEleven.image = UIImage(named: genreImage[10] as! String)
        genreCircleEleven.contentMode = .scaleAspectFill
        genreCircleEleven.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleEleven.borderWidth = 1
        genreCircleEleven.cornerRadius = 110/2
        genreCircleEleven.clipsToBounds = true
        genreCircleEleven.style.preferredSize = .init(width: 110, height: 110)
        genreCircleEleven.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
        genreTxtTweleve.attributedText = NSAttributedString(string: genreTxt[11] as! String, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        genreCircleTweleve.image = UIImage(named: genreImage[11] as! String)
        genreCircleTweleve.contentMode = .scaleAspectFill
        genreCircleTweleve.borderColor = CGColor.init(red: 255, green: 250, blue: 250, alpha: 1)
        genreCircleTweleve.borderWidth = 1
        genreCircleTweleve.cornerRadius = 110/2
        genreCircleTweleve.clipsToBounds = true
        genreCircleTweleve.style.preferredSize = .init(width: 110, height: 110)
        genreCircleTweleve.addTarget(self, action: #selector(genreClicked), forControlEvents: .touchUpInside)
        
    }
    
    @objc func genreClicked() {
        //print("hashtag song id is: \(hashtagSong.id)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
