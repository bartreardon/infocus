//
//  checkDND.swift
//  checkDND
//
//  Created by Bart Reardon on 14/9/21.
//

import Foundation
import Intents
import SystemConfiguration


func checkDND() -> Bool {

    if #available(macOS 12.0, *) {
        // Request authorization to check Focus Status
        
        INFocusStatusCenter.default.requestAuthorization { status in

        }
        
        let focusStatusisFocused = INFocusStatusCenter.default.focusStatus.isFocused ?? false
        
        return focusStatusisFocused
        
    } else {
        
        let bundlePath = Bundle.main.bundlePath
                
        let infocusCLIPath = "\(bundlePath)/Contents/Resources/infocuscli"
        
        print("Running the Infocus app bundle is not supported under macOS 11 or older due to the DND settings being not available from the app sandbox.")
        print("Call the cli utility directly instead,which is located at:")
        print(infocusCLIPath)
        
    }
    return false
}
