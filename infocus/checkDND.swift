//
//  checkDND.swift
//  checkDND
//
//  Created by Bart Reardon on 14/9/21.
//

import Foundation
import Intents
import SystemConfiguration

func plistFromData(_ data: Data) throws -> [String:Any] {
    try PropertyListSerialization.propertyList(
        from: data,
        format: nil
    ) as! [String:Any]
}

func checkDND() -> Bool {

    if #available(macOS 12.0, *) {
        // Request authorization to check Focus Status
        INFocusStatusCenter.default.requestAuthorization { status in

        }
        
        let focusStatusisFocused = INFocusStatusCenter.default.focusStatus.isFocused ?? false
        
        return focusStatusisFocused
        
    } else {
        // Fallback on earlier versions
        
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
