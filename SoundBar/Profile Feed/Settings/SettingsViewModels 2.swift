//
//  SettingsViewModel.swift
//  SoundBar
//
//  Created by Justin Cose on 9/3/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class SettingsViewModel {
    
    var settingsAccount = ["Account Settings", "Privacy", "SoundCode", "Share"]
    var settingsAccountIcons = ["AccountIcon","PrivacyIcon","SoundCodeIcon","SettingsShareIcon"]
    
    var settingsGeneral = ["Push Notifications", "Language"]
    var settingsGeneralIcons = ["NotificationsIcon","LanguageIcon"]
    
    var settingsSupport = ["Help Center", "Contact Us"]
    var settingsSupportIcons = ["HelpCenterIcon","ContactIcon"]
    
    var settingsAbout = ["Terms of Use", "Community Guidelines", "Privacy Policy", "Copyright Policy", "Soundbar Beta", "Soundbar Affiliate Partner Program", "Clear Cache", "New Account"]
    var settingsAboutIcons = ["TermsIcon", "GuidlinesIcon", "PrivacyPolicyIcon", "CopyrightIcon", "SoundbarBetaIcon", "AffiliateIcon", "ClearCacheIcon", "AddAccountIcon"]

    var reloadTableView: (()->())?

    func getCellAt(cell: IndexPath) -> ASCellNode {
        
        if cell.section == 0 {
            return SettingCollectionCells(type: "Account", data: self.settingsAccount, icons: self.settingsAccountIcons)
        } else if cell.section == 1 {
            return SettingCollectionCells(type: "General", data: self.settingsGeneral, icons: self.settingsGeneralIcons)
        } else if cell.section == 2 {
            return SettingCollectionCells(type: "Support", data: self.settingsSupport, icons: self.settingsSupportIcons)
        } else {
            return SettingCollectionCells(type: "About", data: self.settingsAbout, icons: self.settingsAboutIcons)
        }
        
    }
}
