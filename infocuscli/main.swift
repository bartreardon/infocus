//
//  main.swift
//  infocuscli
//
//  Created by Bart Reardon on 18/9/21.
//

import Foundation

if checkDNDcli() {
    print("STATUS: Do Not Disturb is enabled")
    exit(1)
}
exit(0)

