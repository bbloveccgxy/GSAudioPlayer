//
//  GSShortAudioPlayer.swift
//  GSAudioPlayerDemo
//
//  Created by gxy on 2017/3/22.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

import Foundation
import AudioToolbox

/// The maximum supported duration for an audio is 30 secs.
class GSShortAudioPlayer {
    
    var playMode:ShortAudioPlayerMode = .SoundAndVibrate {
        willSet {
            if newValue == .Vibrate {
                self.soundID = kSystemSoundID_Vibrate
            }
        }
    }
    var fileName:String?
    var fileType:String?
    var repeatTimes:Int = 0 {
        willSet {
            if newValue != 0 {
                self.times = newValue - 1
            }
        }
    }
    
    @objc func play() {
        
        if self.firstPlay {
            do {
                try self.makeSoundID()
                self.firstPlay = false
                GSAudioControl.startPlaying()
            } catch GSAudioPlayerError.filePathError(let msg) {
                print(msg)
                return
            } catch {}
        }
        
        switch self.playMode {
        case .Sound:
            self.playSound()
        case .SoundAndVibrate:
            self.playSoundAndVibrate()
        case .Vibrate:
            self.playVibrate()
        }
        
    }
    
    //MARK:private function and variable
    //建立的SystemSoundID对象
    private var soundID:SystemSoundID = 0
    
    private var firstPlay:Bool = true
    //临时变量 用于次数控制
    private var times:Int = 0
    
    private func makeSoundID() throws {
        //若是震动，忽略由路径设置soundID
        if self.soundID == kSystemSoundID_Vibrate {
            return
        }
        if let name = fileName, let type = fileType {
            //获取声音地址
            let path = Bundle.main.path(forResource: name, ofType: type)
            //地址转换
            if let p = path {
                let baseURL = URL(fileURLWithPath: p) as CFURL
                //赋值
                AudioServicesCreateSystemSoundID(baseURL, &soundID)
            }
            else {
                throw GSAudioPlayerError.filePathError("\(name).\(type) is invalid path")
            }
        }
        else {
            throw GSAudioPlayerError.filePathError("fileName or fileType not set")
        }
    }
    
    private func playSound() {
        AudioServicesPlaySystemSoundWithCompletion(soundID, self.playClosure)
    }
    
    private func playSoundAndVibrate() {
        AudioServicesPlayAlertSoundWithCompletion(soundID, self.playClosure)
    }
    
    private func playVibrate() {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, self.playClosure)
    }
    
    private lazy var playClosure: ()->Void = {
        [unowned self] in
        if self.times == 0 {
            GSAudioControl.finishPlaying()
            self.times = self.repeatTimes - 1
            self.firstPlay = true
        }else {
            self.times = self.times - 1
            self.play()
        }
    }
    
    deinit {
        AudioServicesDisposeSystemSoundID(self.soundID)
    }
}

enum ShortAudioPlayerMode {
    case Sound
    case SoundAndVibrate
    case Vibrate
}
