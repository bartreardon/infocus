//
//  File.swift
//  infocus
//
//  Created by Bart Reardon on 18/9/21.
//

import Foundation

func plistFromData(_ data: Data) throws -> [String:Any] {
    try PropertyListSerialization.propertyList(
        from: data,
        format: nil
    ) as! [String:Any]
}
