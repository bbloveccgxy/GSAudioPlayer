//
//  GSAudioPlayer.swift
//  GSAudioPlayerDemo
//
//  Created by gxy on 2017/3/22.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

import Foundation
import AVFoundation

class GSAudioPlayer {
    //singleton
    static let sharePlayer = GSAudioPlayer()
    
    //This prevents others from using the default '()' initializer for this class.
    private init() {
    }

    var filePath:String? {
        willSet {
            if let newPath = newValue {
                self.fileHandler = FileHandle(forReadingAtPath: newPath)
                let url = URL(fileURLWithPath: newPath)
                let manager = GSAudioFileManager(url: url)
                manager.open()
            }
        }
    }
    //var fileType:String?
    var status:GSAudioPlayStatus = .stop
    
    func play(){
        self.status = .playing
    }
    
    func pause(){
        self.status = .pause
    }
    
    func stop(){
        self.status = .stop
    }
    
    private lazy var fileHandler : FileHandle? = nil
    
    
    
    
    
}


