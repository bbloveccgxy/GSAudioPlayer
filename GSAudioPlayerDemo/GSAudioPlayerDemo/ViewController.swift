//
//  ViewController.swift
//  GSAudioPlayerDemo
//
//  Created by gxy on 2017/3/22.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let player: GSShortAudioPlayer = GSShortAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.playMode = .Sound
        player.fileName = "kakao"
        player.fileType = "caf"
        player.repeatTimes = 3

        let button = UIButton(type: UIButtonType.custom)
        button.backgroundColor = UIColor.red
        button.frame = CGRect(x: 50, y: 50, width: 80, height: 40)
        button.setTitle("play", for: UIControlState.normal)
        button.addTarget(self, action: #selector(play), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
        NotificationCenter.default.addObserver(self, selector: #selector(finish), name: Notification.Name(rawValue: GSAudioPlayerDidFinishPlayingNotification), object: nil)
        
        
        let aplayer = GSAudioPlayer.sharePlayer
        let path = Bundle.main.path(forResource: "kakao", ofType: "caf")
        aplayer.filePath = path
        
    }
    
    @objc func finish () {
        print("finish")
    }

    @objc func play () {
        self.player.play()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

