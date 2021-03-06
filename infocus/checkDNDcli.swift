//
//  checkDNDcli.swift
//  infocuscli
//
//  Created by Bart Reardon on 18/9/21.
//

import Foundation
import SystemConfiguration

func checkDNDcli() -> Bool {

    if #available(macOS 12.0, *) {
        // Request authorization to check Focus Status
        
        print("The CLI utility is not supported under macOS 12 or above. Use the app bundle binary instead")
                
    } else {
                
        // Fallback on earlier versions
        print("checking older version")
                
        let consoleUser = SCDynamicStoreCopyConsoleUser(nil, nil , nil)
        let consoleUserHomeDir = FileManager.default.homeDirectory(forUser: consoleUser! as String)?.path ?? ""
    
        let ncprefsUrl = URL(
            fileURLWithPath: String("\(consoleUserHomeDir)/Library/Preferences/com.apple.ncprefs.plist")
        )
                
        do {
            let prefsList = try plistFromData(try Data(contentsOf: ncprefsUrl))
            let dndPrefsData = prefsList["dnd_prefs"] as! Data
            let dndPrefsList = try plistFromData(dndPrefsData)
            
            if let userPref = dndPrefsList["userPref"] as? [String:Any] {
                return userPref["enabled"] as! Bool
            }
        } catch {
            print("DND Prefs unavailable")
        }
    }
    return false
}
