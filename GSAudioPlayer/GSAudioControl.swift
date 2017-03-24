//
//  GSAudioControl.swift
//  GSAudioPlayerDemo
//
//  Created by gxy on 2017/3/22.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

import Foundation

let GSAudioPlayerDidFinishPlayingNotification = "GSAudioPlayerDidFinishPlayingNotification"
let GSAudioPlayerStartPlayingNotification = "GSAudioPlayerStartPlayingNotification"
let GSAudioPlayerPausePlayingNotification = "GSAudioPlayerPausePlayingNotification"
let GSAudioPlayerWillStopPlayingNotification = "GSAudioPlayerStopPlayingNotification"

class GSAudioControl{
    class func startPlaying() {
        let notificationName = Notification.Name(rawValue: GSAudioPlayerStartPlayingNotification)
        NotificationCenter.default.post(name: notificationName, object: nil,
                                        userInfo: nil)
    }
    class func pausePlaying() {
        let notificationName = Notification.Name(rawValue: GSAudioPlayerPausePlayingNotification)
        NotificationCenter.default.post(name: notificationName, object: nil,
                                        userInfo: nil)
    }
    class func stopPlaying() {
        let notificationName = Notification.Name(rawValue: GSAudioPlayerWillStopPlayingNotification)
        NotificationCenter.default.post(name: notificationName, object: nil,
                                        userInfo: nil)
    }
    class func finishPlaying() {
        let notificationName = Notification.Name(rawValue: GSAudioPlayerDidFinishPlayingNotification)
        NotificationCenter.default.post(name: notificationName, object: nil,
                                        userInfo: nil)
    }
}

enum GSAudioPlayerError : Error {
    case filePathError(String)
}

enum GSAudioPlayStatus {
    case playing,pause,stop
}
