//
//  GSAudioFileInfo.swift
//  GSAudioPlayerDemo
//
//  Created by gxy on 2017/3/23.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

import Foundation
import AudioToolbox

struct GSAudioFileInfo {
    init(audioFileID:AudioFileID) {
        fileID = audioFileID
    }
    var fileID : AudioFileID
    
    /// seconds
    var duration: Float64 {
        var d : Float64 = 0
        var durationSize : UInt32 = UInt32(MemoryLayout<Float64>.size)
        let status = AudioFileGetProperty(fileID, kAudioFilePropertyEstimatedDuration, &durationSize, &d)
        if status == noErr {
            return d
        }
        else {
            print("get audio file duration failed")
            print("OSStatus:\(status)")
            return 0
        }
    }
    
    /// bitRate
    var bitRate: UInt32 {
        var r : UInt32 = 0
        var bitRateSize : UInt32 = UInt32(MemoryLayout<UInt32>.size)
        let status = AudioFileGetProperty(fileID, kAudioFilePropertyBitRate, &bitRateSize, &r);
        if status == noErr
        { 
            return r
        }
        else {
            print("get audio file bit rate failed")
            print("OSStatus:\(status)")
            return 0
        }
    }
    
    ///sample rate
    var sampleRate: UInt32 {
        var r : UInt32 = 0
        var sampleRateSize : UInt32 = UInt32(MemoryLayout<UInt32>.size)
        let status = AudioFileGetProperty(fileID, kAudioFilePropertyDataFormat, &sampleRateSize, &r);
        if status == noErr
        {
            return r
        }
        else {
            print("get audio file sample rate failed")
            print("OSStatus:\(status)")
            return 0
        }
    }
    
    //var ioNumPackets
}
