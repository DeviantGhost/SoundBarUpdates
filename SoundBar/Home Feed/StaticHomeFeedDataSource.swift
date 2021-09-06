//
//  StaticHomeFeedDataSource.swift
//  SoundBar
//
//  Created by Justin Cose on 2/22/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit

var hotBarsDataSourceStatic: [SongPresentation] = [
    
    SongPresentation(fullLink: "HotGirlBummerFull", snippetLink: "HotGirlBummerClip", artistID: "blackbear", songName: "Hot Girl Bummer", imageLink: "HotGirlBummerImage", profileImageLink: "BlackbearPfp", comments: Optional(525), likes: Optional(29231), listens: Optional(482194), songCaption: "LETS GO", shares: Optional(6326), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "KikaFull", snippetLink: "KikaClip", artistID: "6ix9ine", songName: "KIKA(feat. Tory Lanez)", imageLink: "KikaImage", profileImageLink: "6ix9inePfp", comments: Optional(421), likes: Optional(9425), listens: Optional(48294), songCaption: "LETS GO", shares: Optional(4152), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "SavageLoveFull", snippetLink: "SavageLoveClip", artistID: "Jason Derulo x Jawsh 685", songName: "Savage Love(Siren Beat)", imageLink: "SavageLoveImage", profileImageLink: "JasonDeruloPfp", comments: Optional(421), likes: Optional(9425), listens: Optional(48281), songCaption: "LETS GO", shares: Optional(4152), hashtags: Optional(["#LETSGO"]), id: ""),
                                             
    SongPresentation(fullLink: "RockstarFULL", snippetLink: "RockstarCLIP", artistID: "DaBaby", songName: "ROCKSTAR(feat. Roddy Ricch)", imageLink: "RockstarImage", profileImageLink: "DababyPfp", comments: Optional(7428), likes: Optional(78331), listens: Optional(2848214), songCaption: "LETS GO", shares: Optional(13491), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "WallsCouldTalkFull", snippetLink: "WallsCouldTalkClip", artistID: "Halsey", songName: "Walls Could Talk", imageLink: "WallsCouldTalkImage", profileImageLink: "HalseyPfp", comments: Optional(492), likes: Optional(8592), listens: Optional(82941), songCaption: "LETS GO", shares: Optional(744), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "MoodFull", snippetLink: "MoodClip", artistID: "24kGolden", songName: "Mood(feat. Iann dior)", imageLink: "MoodImage", profileImageLink: "24kPfp", comments: Optional(53762), likes: Optional(402510), listens: Optional(2849214), songCaption: "LETS GO", shares: Optional(25161), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "OopsFull", snippetLink: "OopsClip", artistID: "Yung Gravy", songName: "oops!", imageLink: "OopsImage", profileImageLink: "YungGravyPfp", comments: Optional(525), likes: Optional(29231), listens: Optional(572941), songCaption: "LETS GO", shares: Optional(6326), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "HymmForTheWeekendFull", snippetLink: "HymmForTheWeekendClip", artistID: "Coldplay", songName: "Hymn for the Weekend", imageLink: "HymmForTheWeekendImage", profileImageLink: "ColdplayPfp", comments: Optional(7428), likes: Optional(78331), listens: Optional(172941), songCaption: "LETS GO", shares: Optional(13491), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "MiamiFull", snippetLink: "MiamiClip", artistID: "Luke Gawne", songName: "Miami(feat. Seppi)", imageLink: "MiamiImage", profileImageLink: "LukeGawnePfp", comments: Optional(31), likes: Optional(982), listens: Optional(5284), songCaption: "LETS GO", shares: Optional(121), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "BegginFull", snippetLink: "BegginClip", artistID: "Madcon", songName: "Beggin", imageLink: "BegginImage", profileImageLink: "MadconPfp", comments: Optional(353), likes: Optional(43951), listens: Optional(7284194), songCaption: "LETS GO", shares: Optional(4214), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "RuthlessFull", snippetLink: "RuthlessClip", artistID: "MarMar Oso", songName: "Ruthless", imageLink: "RuthlessImage", profileImageLink: "MarmarOsoPfp", comments: Optional(421), likes: Optional(9425), listens: Optional(492482), songCaption: "LETS GO", shares: Optional(4152), hashtags: Optional(["#LETSGO"]), id: ""),
     
    SongPresentation(fullLink: "DanceMonkeyFull", snippetLink: "DanceMonkeyClip", artistID: "Tones and I", songName: "Dance Monkey", imageLink: "DanceMonkeyImage", profileImageLink: "TonesAndIPfp", comments: Optional(85372), likes: Optional(428159), listens: Optional(914815), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "Intro2Full", snippetLink: "Intro2Clip", artistID: "NF", songName: "Intro 2", imageLink: "Intro2Image", profileImageLink: "NFPfp", comments: Optional(9), likes: Optional(241), listens: Optional(958315), songCaption: "LETS GO", shares: Optional(42), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "CodeineFull", snippetLink: "CodeineClip", artistID: "Kodak Black", songName: "Codeine Dreaming", imageLink: "CodeineImage", profileImageLink: "KodakBlackPfp", comments: Optional(31), likes: Optional(982), listens: Optional(9482), songCaption: "LETS GO", shares: Optional(121), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "WhatsPoppinFull", snippetLink: "WhatsPoppinClip", artistID: "Jack Harlow", songName: "WHATS POPPIN (Remix)", imageLink: "WhatsPoppinImage", profileImageLink: "JackHarlowPfp", comments: Optional(85372), likes: Optional(428159), listens: Optional(5285832), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "DamnFull", snippetLink: "DamnClip", artistID: "SEPPI", songName: "Damn", imageLink: "DamnImage", profileImageLink: "SeppiPfp", comments: Optional(421), likes: Optional(9425), listens: Optional(925838), songCaption: "LETS GO", shares: Optional(4152), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "PaniniFull", snippetLink: "PaniniClip", artistID: "Lil Nas X DaBaby", songName: "Panini(DaBaby Remix)", imageLink: "PaniniImage", profileImageLink: "LilNasXPfp", comments: Optional(492), likes: Optional(8592), listens: Optional(95832), songCaption: "LETS GO", shares: Optional(744), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "SuckerForPainFull", snippetLink: "SuckerForPainClip", artistID: "Lil Wayne & Wiz Khalifa", songName: "Sucker for Pain", imageLink: "SuckerForPainImage", profileImageLink: "SuicideSquadPfp", comments: Optional(53762), likes: Optional(402510), listens: Optional(958321), songCaption: "LETS GO", shares: Optional(25161), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "LegendaryFull", snippetLink: "LegendaryClip", artistID: "Welshly Arms", songName: "Legendary", imageLink: "LegendaryImage", profileImageLink: "WelshlyArmsPfp", comments: Optional(492), likes: Optional(8592), listens: Optional(9583), songCaption: "LETS GO", shares: Optional(744), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "ILoveCollegeFull", snippetLink: "ILoveCollegeClip", artistID: "Asher Roth", songName: "I Love College", imageLink: "ILoveCollegeImage", profileImageLink: "AsherRothPfp", comments: Optional(9), likes: Optional(241), listens: Optional(952), songCaption: "LETS GO", shares: Optional(42), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "FallingFull", snippetLink: "FallingClip", artistID: "Trevor Daniel", songName: "Falling", imageLink: "FallingImage", profileImageLink: "TrevorDanielPfp", comments: Optional(9), likes: Optional(241), listens: Optional(5352), songCaption: "LETS GO", shares: Optional(42), hashtags: Optional(["#LETSGO"]), id: ""),

    SongPresentation(fullLink: "HomicideFull", snippetLink: "HomicideClip", artistID: "Project Youngin", songName: "Homicide(feat. YNW Melly)", imageLink: Optional("HomicideImage"), profileImageLink: "ProjectYounginPfp", comments: Optional(85372), likes: Optional(428159), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "RadioactiveWarriorsRemixFull", snippetLink: "RadioactiveWarriorsRemixClip", artistID: "Jack Turner", songName: "Warriors X Centuries REMIX", imageLink: "RadioactiveWarriorsRemixImage", profileImageLink: "WarriorPic", comments: Optional(5745), likes: Optional(634), listens: Optional(7547), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "BopFull", snippetLink: "BopClip", artistID: "DaBaby", songName: "BOP", imageLink: "BopImage", profileImageLink: "DababyPfp", comments: Optional(4324), likes: Optional(5323), listens: Optional(643636), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "WhooptyFull", snippetLink: "WhooptyClip", artistID: "CJ", songName: "Whoopty", imageLink: "WhooptyImage", profileImageLink: "CJPic", comments: Optional(424), likes: Optional(64363), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "RadioactiveStarsRemixFull", snippetLink: "RadioactiveStarsRemixClip", artistID: "Kate Lenna", songName: "Radioactive X Counting Stars REMIX", imageLink: "RadioactiveStarsRemixImage", profileImageLink: "StarsPic", comments: Optional(6436), likes: Optional(53255), listens: Optional(523535), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "BelieverFull", snippetLink: "BelieverClip", artistID: "Imagine Dragons", songName: "Believer", imageLink: "BelieverImage", profileImageLink: "ImageinDragonsPic", comments: Optional(532), likes: Optional(6436), listens: Optional(414252), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "CantStopMeNowFull", snippetLink: "CantStopMeNowClip", artistID: "Oh The Larceny", songName: "Cant Stop Me Now", imageLink: "CantStopMeNowImage", profileImageLink: "LarcenyPic", comments: Optional(421), likes: Optional(2532), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "TheBoxFull", snippetLink: "TheBoxClip", artistID: "Roddy Ricch", songName: "The Box", imageLink: "TheBoxImage", profileImageLink: "RoddyRicchPic", comments: Optional(5745), likes: Optional(634), listens: Optional(7547), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "FireFull", snippetLink: "FireClip", artistID: "Barns Courtney", songName: "Fire", imageLink: "FireImage", profileImageLink: "BarnsPic", comments: Optional(4324), likes: Optional(5323), listens: Optional(643636), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "FallOutHighHopesRemixFull", snippetLink: "FallOutHighHopesRemixClip", artistID: "Jack Jordan", songName: "High Hopes REMIX", imageLink: "FallOutHighHopesRemixImage", profileImageLink: "KevinPfp", comments: Optional(424), likes: Optional(64363), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "DimeFull", snippetLink: "DimeClip", artistID: "Amp Live", songName: "Penny Nickel Dime", imageLink: Optional("DimeImage"), profileImageLink: "AmpLivePfp", comments: Optional(32715), likes: Optional(924824), listens: Optional(8493825), songCaption: "LETS GO", shares: Optional(56231), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "AstronautFull", snippetLink: "AstronautClip", artistID: "Masked Wolf", songName: "Astronaut In The Ocean", imageLink: Optional("AstronautImage"), profileImageLink: "MaskedWolfPfp", comments: Optional(492), likes: Optional(8592), listens: Optional(9583), songCaption: "LETS GO", shares: Optional(744), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "DevilEyesFull", snippetLink: "DevilEyesClip", artistID: "Hippie Sabotage", songName: "Devil Eyes", imageLink: Optional("DevilEyesImage"), profileImageLink: "hippiesabotage", comments: Optional(9), likes: Optional(241), listens: Optional(5352), songCaption: "LETS GO", shares: Optional(42), hashtags: Optional(["#LETSGO"]), id: ""),

    SongPresentation(fullLink: "SwervinFull", snippetLink: "SwervinClip", artistID: "A Boogie wit da Hoodie", songName: "Swervin(feat. 6ix9ine)", imageLink: Optional("SwervinImage"), profileImageLink: "ABoogiePfp", comments: Optional(85372), likes: Optional(428159), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "RaiseHellFull", snippetLink: "RaiseHellClip", artistID: "Dorothy", songName: "Raise Hell", imageLink: Optional("RaiseHellImage"), profileImageLink: "DorothyPfp", comments: Optional(32715), likes: Optional(924824), listens: Optional(8493825), songCaption: "LETS GO", shares: Optional(56231), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "FindMyWayFull", snippetLink: "FindMyWayClip", artistID: "DaBaby", songName: "Find My Way", imageLink: Optional("FindMyWayImage"), profileImageLink: "DababyPfp", comments: Optional(492), likes: Optional(8592), listens: Optional(9583), songCaption: "LETS GO", shares: Optional(744), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "RunItUpFull", snippetLink: "RunItUpClip", artistID: "NAV", songName: "Run It Up", imageLink: Optional("RunItUpImage"), profileImageLink: "NavPfp", comments: Optional(9), likes: Optional(241), listens: Optional(952), songCaption: "LETS GO", shares: Optional(42), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "TheSearchFull", snippetLink: "TheSearchClip", artistID: "NF", songName: "The Search", imageLink: Optional("TheSearchImage"), profileImageLink: "NFPfp", comments: Optional(9), likes: Optional(241), listens: Optional(5352), songCaption: "LETS GO", shares: Optional(42), hashtags: Optional(["#LETSGO"]), id: ""),

    SongPresentation(fullLink: "RoxanneFull", snippetLink: "RoxanneClip", artistID: "Arizona Zervas", songName: "Roxanne", imageLink: Optional("RoxanneImage"), profileImageLink: "ArizonaPfp", comments: Optional(85372), likes: Optional(428159), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "SayAFull", snippetLink: "SayAClip", artistID: "A Boogie wit da Hoodie", songName: "Say A'", imageLink: Optional("SayAImage"), profileImageLink: "ABoogiePfp", comments: Optional(32715), likes: Optional(924824), listens: Optional(8493825), songCaption: "LETS GO", shares: Optional(56231), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "ShapOfYouFull", snippetLink: "ShapeOfYouClip", artistID: "Ed Sheeran", songName: "Shape of You", imageLink: Optional("ShapeOfYouImage"), profileImageLink: "EdSheeranPfp", comments: Optional(492), likes: Optional(8592), listens: Optional(9583), songCaption: "LETS GO", shares: Optional(744), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "SleepingAtNightFull", snippetLink: "SleepingAtNightClip", artistID: "Caught a Ghost", songName: "Sleeping At Night", imageLink: Optional("SleepingAtNightImage"), profileImageLink: "GhostPfp", comments: Optional(9), likes: Optional(241), listens: Optional(952), songCaption: "LETS GO", shares: Optional(42), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "StrongerFull", snippetLink: "StrongerClip", artistID: "Kanye West", songName: "Stronger", imageLink: Optional("StrongerImage"), profileImageLink: "KanyePfp", comments: Optional(9), likes: Optional(241), listens: Optional(5352), songCaption: "LETS GO", shares: Optional(42), hashtags: Optional(["#LETSGO"]), id: ""),

    SongPresentation(fullLink: "StereoHeartsFull", snippetLink: "StereoHeartsClip", artistID: "Gym Class Heroes", songName: "Stereo Hearts", imageLink: Optional("StereoHeartsImage"), profileImageLink: "GymClassHeroesPfp", comments: Optional(85372), likes: Optional(428159), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "ValentinoFull", snippetLink: "ValentinoClip", artistID: "24kGoldn", songName: "Valentino", imageLink: Optional("ValentinoImage"), profileImageLink: "24kPfp", comments: Optional(32715), likes: Optional(924824), listens: Optional(8493825), songCaption: "LETS GO", shares: Optional(56231), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "CocoFull", snippetLink: "CocoClip", artistID: "24kGoldn", songName: "Coco(feat. DaBaby)", imageLink: Optional("CocoImage"), profileImageLink: "24kPfp", comments: Optional(492), likes: Optional(8592), listens: Optional(9583), songCaption: "LETS GO", shares: Optional(744), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "FmlFull", snippetLink: "FmlClip", artistID: "Arizona Zervas", songName: "FML", imageLink: Optional("FmlImage"), profileImageLink: "ArizonaPfp", comments: Optional(9), likes: Optional(241), listens: Optional(5352), songCaption: "LETS GO", shares: Optional(42), hashtags: Optional(["#LETSGO"]), id: ""),

    SongPresentation(fullLink: "RideRemixFull", snippetLink: "RideRemixClip", artistID: "Jack Jordan", songName: "Ride X High Hopes REMIX", imageLink: Optional("RideRemixImage"), profileImageLink: "KevinPfp", comments: Optional(85372), likes: Optional(428159), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "ColdplayBastilleRemixFull", snippetLink: "ColdplayBastilleRemixClip", artistID: "Jane Sara", songName: "Pompeii X Viva la Vida REMIX", imageLink: "ColdplayBastilleRemixImage", profileImageLink: "ColdplayRemixPic", comments: Optional(532), likes: Optional(6436), listens: Optional(414252), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "StressedOutRemixFull", snippetLink: "StressedOutRemixClip", artistID: "Jack Ryan", songName: "Stressed Out REMIX", imageLink: "StressedOutRemixImage", profileImageLink: "StressedOutRemixPic", comments: Optional(421), likes: Optional(2532), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "LightRadioactiveRemixFull", snippetLink: "LightRadioactiveRemixClip", artistID: "Jack Ryan", songName: "Radioactive Lights Remix", imageLink: "LightRadioactiveRemixImage", profileImageLink: "StressedOutRemixPic", comments: Optional(532), likes: Optional(235352), listens: Optional(643636), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "ComingInHotFull", snippetLink: "ComingInHotClip", artistID: "Andy Mineo", songName: "Coming In Hot", imageLink: "ComingInHotImage", profileImageLink: "AndyPfp", comments: Optional(6436), likes: Optional(53255), listens: Optional(523535), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "LoveMeAgainFull", snippetLink: "LoveMeAgainClip", artistID: "John Newman", songName: "Love Me Again", imageLink: "LoveMeAgainImage", profileImageLink: "JohnPfp", comments: Optional(532), likes: Optional(6436), listens: Optional(414252), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "CloseBrokenDreamsFull", snippetLink: "CloseBrokenDreamsClip", artistID: "Jack Smith", songName: "Broken Dreams Remix", imageLink: "CloseBrokenDreamsImage", profileImageLink: "RemixPfp", comments: Optional(421), likes: Optional(2532), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "WhateverItTakesFull", snippetLink: "WhateverItTakesClip", artistID: "Imagine Dragons", songName: "Whatever It Takes", imageLink: "WhateverItTakesImages", profileImageLink: "ImageinDragonsPic", comments: Optional(5745), likes: Optional(634), listens: Optional(7547), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "DontLetMeDownFull", snippetLink: "DontLetMeDownClip", artistID: "Kate Lenna", songName: "Dont Let Me Down REMIX", imageLink: "DontLetMeDownImage", profileImageLink: "StarsPic", comments: Optional(4324), likes: Optional(5323), listens: Optional(643636), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "HappierRemixFull", snippetLink: "HappierRemixClip", artistID: "Jack Ryan", songName: "Happier REMIX", imageLink: "HappierRemixImage", profileImageLink: "StressedOutRemixPic", comments: Optional(424), likes: Optional(64363), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "WhoDoYouLoveRemixFull", snippetLink: "WhoDoYouLoveRemixClip", artistID: "Jane Sara", songName: "Who Do You Love REMIX", imageLink: "WhoDoYouLoveRemixImage", profileImageLink: "ColdplayRemixPic", comments: Optional(532), likes: Optional(235352), listens: Optional(643636), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "VibesFull", snippetLink: "VibesClip", artistID: "DaBaby", songName: "VIBEZ", imageLink: "VibesImage", profileImageLink: "DababyPfp", comments: Optional(6436), likes: Optional(53255), listens: Optional(523535), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "WayDownWeGoFull", snippetLink: "WayDownWeGoClip", artistID: "KALEO", songName: "Way Down We Go", imageLink: "WayDownWeGoImage", profileImageLink: "KaleoPic", comments: Optional(532), likes: Optional(6436), listens: Optional(414252), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "RadioactiveKendrickFull", snippetLink: "RadioactiveKendrickClip", artistID: "Imagine Dragons", songName: "Radioactive(feat. Kendrick Lamar)", imageLink: "RadioactiveKendrickImage", profileImageLink: "ImageinDragonsPic", comments: Optional(421), likes: Optional(2532), listens: Optional(573253), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "SoTiedUpFull", snippetLink: "SoTiedUpClip", artistID: "Cold War Kids", songName: "So Tied Up", imageLink: "SoTiedUpImage", profileImageLink: "ColdWarKidsPic", comments: Optional(5745), likes: Optional(634), listens: Optional(7547), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "RaptureFull", snippetLink: "RaptureClip", artistID: "Tom Walker", songName: "Rapture", imageLink: "RaptureImage", profileImageLink: "TomImage", comments: Optional(4324), likes: Optional(5323), listens: Optional(643636), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "7yearsFull", snippetLink: "7yearsClip", artistID: "Lukas Graham", songName: "7 Years", imageLink: "7YearsImage", profileImageLink: "lukasGrahamPfp", comments: Optional(7234), likes: Optional(513), listens: Optional(32542352), songCaption: "LETS GO", shares: Optional(234523), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "UsedToKnowFull", snippetLink: "UsedToKnowClip", artistID: "Gotye", songName: "Somebody That I Used To Know", imageLink: "UsedToKnowImage", profileImageLink: "gotyePfp", comments: Optional(4324), likes: Optional(254325), listens: Optional(2435423), songCaption: "LETS GO", shares: Optional(2345), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "SomebodyLoveFull", snippetLink: "SomebodyLoveClip", artistID: "Flight School", songName: "Somebody's Gonna Love You", imageLink: "SomebodyLoveImage", profileImageLink: "klergyPfp", comments: Optional(23452), likes: Optional(243542), listens: Optional(765437), songCaption: "LETS GO", shares: Optional(735), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "ParisFull", snippetLink: "ParisClip", artistID: "The Chainsmokers", songName: "Paris", imageLink: "ParisImage", profileImageLink: "chainSmokerPfp", comments: Optional(8467), likes: Optional(2363), listens: Optional(345633), songCaption: "LETS GO", shares: Optional(6523), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "WithoutYouFull", snippetLink: "WithoutYouClip", artistID: "The Kid LAROI", songName: "Without You", imageLink: "WithoutYouImage", profileImageLink: "theKidLaroiPfp", comments: Optional(4324), likes: Optional(86521), listens: Optional(6443636), songCaption: "LETS GO", shares: Optional(8754), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "DNAFull", snippetLink: "DNAClip", artistID: "Kendrick Lamar", songName: "DNA", imageLink: "DnaImage", profileImageLink: "kendrickLamarPfp", comments: Optional(12434), likes: Optional(32123), listens: Optional(3756235), songCaption: "LETS GO", shares: Optional(5423), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "FeelingWhitneyFull", snippetLink: "FeelingWhitneyClip", artistID: "Post Malone", songName: "Feeling Whitney", imageLink: "FeelingWhitneyImage", profileImageLink: "postMalonePfp", comments: Optional(32443), likes: Optional(56344), listens: Optional(95887), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "HumbleFull", snippetLink: "HumbleClip", artistID: "Kendrick Lamar", songName: "Humble", imageLink: "HumbleImage", profileImageLink: "kendrickLamarPfp", comments: Optional(4535), likes: Optional(23424), listens: Optional(545445), songCaption: "LETS GO", shares: Optional(2543), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "SomethingJustLikeThisFull", snippetLink: "SomethingJustLikeThisClip", artistID: "The Chainsmokers", songName: "Something Just Like This", imageLink: "LikeThisImage", profileImageLink: "chainSmokerPfp", comments: Optional(7865), likes: Optional(23543), listens: Optional(6534634), songCaption: "LETS GO", shares: Optional(64543), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "BloodWaterFull", snippetLink: "BloodWaterClip", artistID: "grandson", songName: "Blood // Water", imageLink: "BloodWaterImage", profileImageLink: "grandsonPfp", comments: Optional(23543), likes: Optional(324576), listens: Optional(875476), songCaption: "LETS GO", shares: Optional(73465), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "BetterNowFull", snippetLink: "BetterNowClip", artistID: "Post Malone", songName: "Better Now", imageLink: "BetterNowImage", profileImageLink: "postMalonePfp", comments: Optional(467), likes: Optional(785784), listens: Optional(6436326), songCaption: "LETS GO", shares: Optional(3243), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "OverNowFull", snippetLink: "OverNowClip", artistID: "Post Malone", songName: "Over Now", imageLink: "OverNowImages", profileImageLink: "postMalonePfp", comments: Optional(3742), likes: Optional(5234323), listens: Optional(543543543), songCaption: "LETS GO", shares: Optional(34536), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "HallOfFameFull", snippetLink: "HallOfFameClip", artistID: "The Script", songName: "Hall of Fame", imageLink: "HallOfFameImage", profileImageLink: "theScriptPfp", comments: Optional(42342), likes: Optional(86553), listens: Optional(6345435234), songCaption: "LETS GO", shares: Optional(32425), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "WeatherStormFull", snippetLink: "WeatherStormClip", artistID: "DJ Khaled", songName: "Weather the Storm", imageLink: "StormImageNew", profileImageLink: "DJKhalidPfp", comments: Optional(9567), likes: Optional(26234), listens: Optional(734654367), songCaption: "LETS GO", shares: Optional(3265326), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "WhiteFlagFull", snippetLink: "WhiteFlagClip", artistID: "Biship Briggs", songName: "White Flag", imageLink: "WhiteFlagImageNew", profileImageLink: "bishopBriggsPfp", comments: Optional(8456), likes: Optional(23452), listens: Optional(21341), songCaption: "LETS GO", shares: Optional(2352), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "DreamsAndNightFull", snippetLink: "DreamsAndNightClip", artistID: "Meek Mill", songName: "Dreams and Nightmares", imageLink: "DreamsImage", profileImageLink: "meekMillPfp", comments: Optional(4324), likes: Optional(5323), listens: Optional(643636), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "ArcadeRemixFull", snippetLink: "ArcadeRemixClip", artistID: "Zac Brown", songName: "Arcade Remix", imageLink: "ArcadeImage", profileImageLink: "zacBrownPfp", comments: Optional(4324), likes: Optional(5323), listens: Optional(643636), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "RealGoodFeelingFull", snippetLink: "RealGoodFeelingClip", artistID: "Oh The Larceny", songName: "Real Good Feeling", imageLink: "RealGoodImage", profileImageLink: "duncanLaurencePfp", comments: Optional(2431), likes: Optional(54357), listens: Optional(34262456), songCaption: "LETS GO", shares: Optional(125378), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "DrivingToChurchRemixFull", snippetLink: "DrivingToChurchRemixClip", artistID: "Rita Ora", songName: "Driving To Church REMIX", imageLink: "DrivingToChurchImage", profileImageLink: "ritaOraPfp", comments: Optional(123461), likes: Optional(263), listens: Optional(5436312), songCaption: "LETS GO", shares: Optional(42865), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "KeepingMeAliveFull", snippetLink: "KeepingMeAliveClip", artistID: "Jonathan Roy", songName: "Keeping Me Alive", imageLink: "KeepingMeAliveImage", profileImageLink: "jonathanRoyPfp", comments: Optional(12423), likes: Optional(26523), listens: Optional(8476343), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "FightBackFull", snippetLink: "FightBackClip", artistID: "Konata", songName: "Fight Back", imageLink: "FightBackImage", profileImageLink: "NEFFEXPfp", comments: Optional(25723), likes: Optional(27456), listens: Optional(563472), songCaption: "LETS GO", shares: Optional(1235), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "KingKuntaFull", snippetLink: "KingKuntaClip", artistID: "Kendrick Lamar", songName: "King Kunta", imageLink: "KuntaImage", profileImageLink: "kendrickLamarPfp", comments: Optional(4324), likes: Optional(5323), listens: Optional(643636), songCaption: "LETS GO", shares: Optional(120424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "BelieverOnFireRemix", snippetLink: "BelieverOnFireRemixClip", artistID: "Calvin Harris", songName: "Believer On Fire REMIX", imageLink: "BelieverOnFireRemixImage", profileImageLink: "calvinHarrisPfp", comments: Optional(29429), likes: Optional(43214), listens: Optional(654363), songCaption: "LETS GO", shares: Optional(262), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "NatrualFull", snippetLink: "NatrualClip", artistID: "Imagine Dragons", songName: "Natrual", imageLink: "NatrualImage", profileImageLink: "imagineDragonsPfp", comments: Optional(213), likes: Optional(12552), listens: Optional(876534), songCaption: "LETS GO", shares: Optional(2134), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "AshesFull", snippetLink: "AshesClip", artistID: "Stellar", songName: "Ashes", imageLink: "AshesImageNew", profileImageLink: "stellarPfp", comments: Optional(234), likes: Optional(2432), listens: Optional(54325432), songCaption: "LETS GO", shares: Optional(6543), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "WhereverIGoFull", snippetLink: "WhereverIGoClip", artistID: "Dan Bremnes", songName: "Wherever I Go", imageLink: "WhereverIGoImage", profileImageLink: "danBrenesPfp", comments: Optional(1231), likes: Optional(5435), listens: Optional(7224212), songCaption: "LETS GO", shares: Optional(3243), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "DeathBedFull", snippetLink: "DeathBedClip", artistID: "Powfu", songName: "death bed", imageLink: "DeathBedImage", profileImageLink: "powfuPfp", comments: Optional(1344), likes: Optional(865442), listens: Optional(73575442), songCaption: "LETS GO", shares: Optional(23453), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "CityOfAngelsFull", snippetLink: "CityOfAngelsClip", artistID: "24kGoldn", songName: "City Of Angels", imageLink: "AngelsImage", profileImageLink: "24kPfp", comments: Optional(6352), likes: Optional(367354), listens: Optional(346354325), songCaption: "LETS GO", shares: Optional(32432), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "StartAWarFull", snippetLink: "StartAWarClip", artistID: "Klergy", songName: "Start a War", imageLink: "StartAWarImage", profileImageLink: "klergyPfp", comments: Optional(987856), likes: Optional(74652), listens: Optional(7634563), songCaption: "LETS GO", shares: Optional(123), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "ProjectDreamsFull", snippetLink: "ProjectDreamsClip", artistID: "Marshmello", songName: "Project Dreams", imageLink: "ProjectDreamsImage", profileImageLink: "marshmelloImage", comments: Optional(4324), likes: Optional(45624), listens: Optional(658563), songCaption: "LETS GO", shares: Optional(523424), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "ToesFull", snippetLink: "ToesClip", artistID: "DaBaby", songName: "Toes", imageLink: "ToesImage", profileImageLink: "DababyPfp", comments: Optional(234), likes: Optional(85473), listens: Optional(67354), songCaption: "LETS GO", shares: Optional(32543), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "PlayDirtyFull", snippetLink: "PlayDirtyClip", artistID: "Jack Jordan", songName: "Play Dirty", imageLink: "PlayDirtyImageNew", profileImageLink: "KevinPfp", comments: Optional(25), likes: Optional(262623), listens: Optional(8765436), songCaption: "LETS GO", shares: Optional(1234), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "WhenIGrowUpFull", snippetLink: "WhenIGrowUpClip", artistID: "NF", songName: "When I Grow Up", imageLink: "GrowUpImage", profileImageLink: "NFPfp", comments: Optional(234523), likes: Optional(32545), listens: Optional(95434853), songCaption: "LETS GO", shares: Optional(2342), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "RIPFull", snippetLink: "RIPClip", artistID: "Arizona Zervas", songName: "RIP", imageLink: "RipImage", profileImageLink: "ArizonaPfp", comments: Optional(43536), likes: Optional(362345), listens: Optional(34532326), songCaption: "LETS GO", shares: Optional(6346), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "LoveOfTheGameFull", snippetLink: "LoveOfTheGameClip", artistID: "Welshly Arms", songName: "Love Of The Game", imageLink: "LoveOfTheGameImage", profileImageLink: "WelshlyArmsPfp", comments: Optional(48456), likes: Optional(2345), listens: Optional(543743), songCaption: "LETS GO", shares: Optional(8467), hashtags: Optional(["#LETSGO"]), id: ""),
    
    SongPresentation(fullLink: "CantHoldUsRemixFull", snippetLink: "CantHoldUsRemixClip", artistID: "Jack Jordan", songName: "Cant Hold Us Remix", imageLink: "CantHoldUsImage", profileImageLink: "KevinPfp", comments: Optional(1314), likes: Optional(345235), listens: Optional(153435), songCaption: "LETS GO", shares: Optional(2342), hashtags: Optional(["#LETSGO"]), id: ""),

]

var playlistsStatic: [SongPlaylists] = [
    
    SongPlaylists(imageLink: "RelaxPlaylist", playlistName: "Workout Playlist", songs: Array(hotBarsDataSourceStatic[1...30]), creator: "Lukas Theo"),
    
    SongPlaylists(imageLink: "DrivingPlaylist", playlistName: "Driving Vibes", songs: Array(hotBarsDataSourceStatic[15...45]), creator: "You"),
    
    SongPlaylists(imageLink: "CalmPlaylist", playlistName: "Party Playlist", songs: Array(hotBarsDataSourceStatic[30...55]), creator: "Carlon R"),
    
    SongPlaylists(imageLink: "OldiesPlaylist", playlistName: "Oldies", songs: Array(hotBarsDataSourceStatic[10...30]), creator: "Ryan R"),
    
    SongPlaylists(imageLink: "RockPlaylist", playlistName: "Rock Out", songs: Array(hotBarsDataSourceStatic[5...60]), creator: "Nicole"),
    
    SongPlaylists(imageLink: "VibingPlaylist", playlistName: "Vibez", songs: Array(hotBarsDataSourceStatic[40...63]), creator: "Harrison"),
    
    SongPlaylists(imageLink: "OldiesPlaylist", playlistName: "Best of 2021", songs: Array(hotBarsDataSourceStatic[10...30]), creator: "Lucas Cose"),
    
    SongPlaylists(imageLink: "RockPlaylist", playlistName: "Soundbar Favorites", songs: Array(hotBarsDataSourceStatic[5...60]), creator: "You"),
    
    SongPlaylists(imageLink: "VibingPlaylist", playlistName: "Chill Mix", songs: Array(hotBarsDataSourceStatic[40...63]), creator: "Eric Issakson"),
    
    SongPlaylists(imageLink: "OldiesPlaylist", playlistName: "Wake Up!", songs: Array(hotBarsDataSourceStatic[10...30]), creator: "You"),
    
    SongPlaylists(imageLink: "RockPlaylist", playlistName: "Remixes & Mashups", songs: Array(hotBarsDataSourceStatic[5...60]), creator: "Austin T"),
    
]

var artistProfilesStatic: [ProfileHeader] = [

    ProfileHeader(profileLink: "marshmelloImage", username: "@marshmello", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Marshmello", listens: 64364),

    ProfileHeader(profileLink: "WelshlyArmsPfp", username: "@welshlyarms", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Welshly Arms", listens: 64364),

    ProfileHeader(profileLink: "DababyPfp", username: "@dababyofficial", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "DaBaby", listens: 64364),

    ProfileHeader(profileLink: "NFPfp", username: "@nfofficial", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "NF", listens: 64364),

    ProfileHeader(profileLink: "jonathanRoyPfp", username: "@jonathanroy", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Jonathan Roy", listens: 64364),

    ProfileHeader(profileLink: "postMalonePfp", username: "@postmalone", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Post Malone", listens: 64364),

    ProfileHeader(profileLink: "ABoogiePfp", username: "@therealboogie", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "A Booke Wit Da Hoodie", listens: 64364),

    ProfileHeader(profileLink: "RoddyRicchPic", username: "@roddyricch", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Roddy Ricch", listens: 64364),

    ProfileHeader(profileLink: "24kPfp", username: "@24kgolden", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "24kgolden", listens: 64364),

    ProfileHeader(profileLink: "6ix9inePfp", username: "@6ix9ine", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "6ix9ine", listens: 64364),

    ProfileHeader(profileLink: "BlackbearPfp", username: "@blackbear", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Blackbear", listens: 64364),

    ProfileHeader(profileLink: "ArizonaPfp", username: "@arizonazervas", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Arizone Zervas", listens: 64364),

    ProfileHeader(profileLink: "KanyePfp", username: "@kanyewest", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Kanye West", listens: 64364),

    ProfileHeader(profileLink: "powfuPfp", username: "@powfuofficial", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Powfu", listens: 64364),

    ProfileHeader(profileLink: "AndyPfp", username: "@andymayer", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Andy Mayer", listens: 64364),

    ProfileHeader(profileLink: "HalseyPfp", username: "@halseyofficial", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Halsey", listens: 64364),

    ProfileHeader(profileLink: "YungGravyPfp", username: "@yunggravy", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Yung Gravy", listens: 64364),

    ProfileHeader(profileLink: "NavPfp", username: "@navofficial", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "NAV", listens: 64364),

    ProfileHeader(profileLink: "JasonDeruloPfp", username: "@thejasonderulo", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Jason Derulo", listens: 64364),

    ProfileHeader(profileLink: "ColdplayPfp", username: "@coldplay", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Coldplay", listens: 64364),

    ProfileHeader(profileLink: "LukeGawnePfp", username: "@officiallukegawne", followersCount: 535, followingCount: 43634, likesCount: 6436, bio: "Check out the lastest song", fullName: "Luke Gawne", listens: 64364)

]

extension UIColor {
    
    func soundbarColorScheme() -> UIColor {
        return UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1)
    }
    
    func topBackgroundGray() -> UIColor {
        return UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 1)
    }
    
    func buttonsGray() -> UIColor {
        return UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
    }
    
    func cellBackgroundGray() -> UIColor {
        return UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
    }
    
    func backgroundGray() -> UIColor {
        return UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
    }
    
}

extension ASImageNode {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 1
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 6

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = 1
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

extension String {
    func sizeOfString( font: UIFont) -> CGSize {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute)  // for Single Line
       return size;
    }
}

extension ASTextNode {
    func sizeOfString( font: UIFont) -> CGSize {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.attributedText?.string.size(withAttributes: fontAttribute) // for Single Line
        return size ?? CGSize(width: 0, height: 0);
    }
}


var globalTiktokData = ["TikTokOne", "TikTokTwo", "TikTokThree", "TikTokFour", "TikTokFive", "TikTokSix", "TikTokSeven", "TikTokEight", "TikTokNine", "TikTokTen"]

var globalCommentData = ["Sick beat", "Beat drop goes hard", "song is the vibe", "woah woah woah", "nice brotha!", "sick track", "nice beat", "Lets gooo", "song is fuckin fire bruh","clean fire", "love it!!!", "Killin it bro!", "song is the vibe", "Awesome track dude", "Broooooo", "goes HARD!", "fireeeee", "clean fire", "goes hard!", "sickkkkkk", "This ain’t the og version", "please check out my profile!;)", "song is the vibe", "Wont let go", "someone hmu plz", "song is the vibe", "Collab?", "go stupid!", "nice", "song is fuckin fire bruh", "clean fire", "So good", "Not the og version", "niceeeee", "song is the vibe", "Wont let go", "someone hmu plz", "Like if u love this song", "who likes @ the kid laroi", "Love this song!!!", "check my last song pls", "Like the beat", "please check out my tracks", "song is the vibe", "Collab??!?", "Keep up the good work brotha!", "Love the track", "song is fuckin fire bruh", "clean fire", "vibes to the max","yooooo", "This ain’t the og version", "please check out my profile!", "song is the vibe", "Wont let go", "someone hmu plz", "song is the vibe", "Your last track hit!", "niceeee","pretty good"]

var globalLikeCountData = ["525", "747", "2453", "63", "3", "7", "743", "25", "5325", "7347", "4", "1", "26", "453", "4", "532", "532", "754", "532", "64", "643", "12", "64", "85", "6373", "53", "2", "6", "75", "432", "643", "7547", "6", "8", "352", "6", "9", "3253", "15", "64", "62", "212", "5", "51", "74", "8658", "46", "53", "73", "532"]

var globalProfileImageData = ["commentsPfp1", "commentsPfp2", "commentsPfp3", "commentsPfp4", "commentsPfp5", "commentsPfp6", "commentsPfp7", "commentsPfp8", "commentsPfp9", "commentsPfp10", "commentsPfp11", "commentsPfp12", "commentsPfp13", "commentsPfp14", "commentsPfp13", "commentsPfp16", "commentsPfp17", "commentsPfp18", "commentsPfp19", "commentsPfp20", "commentsPfp21", "commentsPfp22", "commentsPfp50", "commentsPfp24", "commentsPfp25", "commentsPfp26", "commentsPfp27", "commentsPfp28", "commentsPfp27", "commentsPfp28", "commentsPfp29", "commentsPfp32", "commentsPfp33", "commentsPfp34", "commentsPfp35", "commentsPfp36", "commentsPfp37", "commentsPfp38", "commentsPfp49", "commentsPfp40", "commentsPfp41", "commentsPfp42", "commentsPfp43", "commentsPfp44", "commentsPfp45", "commentsPfp46", "commentsPfp47", "commentsPfp48", "commentsPfp49", "commentsPfp50", ]

var globalNameData = ["Charlie", "Katie L", "Carson", "Ryan R", "Carlon R", "Austin T", "Grace Dowser", "Jack S", "John Smith", "Logan Dain", "Danesh", "Eric Issakson", "Lukas Theo", "Ari Fritz", "Jake Druckman", "Nicole R", "James", "Rachel R", "Oliver Dover", "Justin", "Ray", "Lia Oakley", "Kate Sear", "Faye", "Liam Conlon", "Anna Lynn", "Kaitlyn", "Aiden", "Mick Swanson", "Ethan", "Harvey", "Lily", "TJ", "Jeremiah", "Shane Raywood", "Walker R", "Julia K", "Dani White", "Avery", "Arthur", "Caden Condon", "Erika Bailey", "Louis", "Cayla", "Reese", "Emma C", "Tanner", "Ty Lowe", "Dave L", "Laila", "Mike Perla", "Rainer", "Hannah Wyatt", "Sam Battenberg", "Emma McKinney", "Lucas", "Audrey", "Erin", "Emily", "Kyle"]

var globalUsernameData = ["taylor.balenci", "jack_ralph", "goatxd", "havochadley", "quentin_custodio", "andonov_13", "mathewporras", "athompson", "savannaKinnane", "ryan.salter", "john_lent", "theguy4", "jamesonlind", "cristian.laraa", "itz_isrie", "cooper_weinert", "ezell_w", "cosma.712", "playboy.andreww", "billy_moore", "abby_moore", "andy_song", "grace.mover", "carlonrosales", "finncaswell", "rae.lessed", "rekei_", "dominick_quezada", "lewis_midleton", "c_ofarrow", "awesome.one", "mason_borrero", "nicolas.cicala", "godfather50000", "joshcernec", "kirito909_420", "stayford.compte", "drake_eyy", "eric.carr", "jayeon02", "jaden.garn", "ben1fletcher", "nathan_plantier", "ryleih_safe", "ashley.keating", "fortins.55", "ark_iwnl", "teunthaens", "joane.pendergast", "j.wroblewski", ]

var globalTimeStampData = ["2h", "8m", "3m", "8h", "4d", "8d", "3d", "5h", "1h", "4h", "4m", "3d", "1d", "43m", "39m", "25m", "1d", "1d", "3h", "3h", "8d", "2m", "23h", "43m", "32m", "14h", "1d", "2h", "19h", "3h", "59m", "23h", "3h", "1h", "2h", "1h", "1h", "19m", "1d", "1d", "11m", "1d", "5h", "13m", "4m", "3h", "32m", "1d", "1h", "5h", ]

