//
//  RADSwChar.swift
//  SWSwift
//
//  Created by RAMON ALBERTI DANES on 1/8/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//


import Foundation
import UIKit

class RADSwChar: NSObject {
    
    // Propiedades
    var name: String?
    var alias: String?
    var wikiURL: NSURL?
    var soundData: NSData?
    var photo: UIImage?
    
    init(name: String?, alias: String?, wikiURL: NSURL?, soundData: NSData?, photo: UIImage?){
        self.name = name
        self.alias = alias
        self.wikiURL = wikiURL
        self.soundData = soundData
        self.photo = photo
    }
    
    init(alias: String?, wikiURL: NSURL?, soundData: NSData?, photo: UIImage?){
        self.name = ""
        self.alias = alias
        self.wikiURL = wikiURL
        self.soundData = soundData
        self.photo = photo
    }
}