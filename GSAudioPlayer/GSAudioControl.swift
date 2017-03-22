//
//  GSAudioControl.swift
//  GSAudioPlayerDemo
//
//  Created by gxy on 2017/3/22.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

import Foundation

let GSAudioPlayerDidFinishPlayingNotification = "GSAudioPlayerDidFinishPlayingNotification"

class GSAudioControl{
    func startPlaying() {
    }
    func pausePlaying() {
    }
    func stopPlaying() {
    }
    func finishPlaying() {
        let notificationName = Notification.Name(rawValue: GSAudioPlayerDidFinishPlayingNotification)
        NotificationCenter.default.post(name: notificationName, object: nil,
                                        userInfo: nil)
    }
}
