//
//  RADCafPlayerSw.swift
//  SWSwift
//
//  Created by RAMON ALBERTI DANES on 1/8/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class RADCafPlayerSw {
    
    var myplayer = AVAudioPlayer()
    
    class func cafPlayer() -> RADCafPlayerSw?{
        return self.init()
    }
    
    func playSoundData(data: NSData?){
        
        if let soundData = data{
            let miSoundData: NSData! = data!
            myplayer = AVAudioPlayer(data: miSoundData, fileTypeHint: AVFileTypeCoreAudioFormat, error: nil)
            myplayer.numberOfLoops = 0
            myplayer.play()
        }
    }
    
}
