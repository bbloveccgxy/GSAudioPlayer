//
//  GSAudioFileManager.swift
//  GSAudioPlayerDemo
//
//  Created by gxy on 2017/3/23.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

import Foundation
import AudioToolbox

class GSAudioFileManager {
    
    init(url:URL) {
        fileCFURL = url as CFURL
    }
    
    var fileID : AudioFileID?
    
    private let fileCFURL: CFURL
    
    func open() {
        let status = AudioFileOpenURL(fileCFURL, AudioFilePermissions.readPermission, 0, &fileID)
        if status != noErr {
            print("audio file open failed")
            print("OSStatus:\(status)")
            return
        }
        let file = GSAudioFileInfo(audioFileID: fileID!)
        print(file.duration)
        
        let ioNumPackets:UInt32 = 2
        let inStartPacket: Int64 = 0
        
        let byteCountPerPacket: UInt32 = 144 * file.bitRate / file.sampleRate
        let descriptionSize : Int = MemoryLayout<AudioStreamPacketDescription>.size * Int(ioNumPackets)
        
        let outPacketDescriptions : AudioStreamPacketDescription = AudioStreamPacketDescription(malloc(descriptionSize))
        
        AudioFileReadPacketData(fileID!, false, <#T##ioNumBytes: UnsafeMutablePointer<UInt32>##UnsafeMutablePointer<UInt32>#>, <#T##outPacketDescriptions: UnsafeMutablePointer<AudioStreamPacketDescription>?##UnsafeMutablePointer<AudioStreamPacketDescription>?#>, <#T##inStartingPacket: Int64##Int64#>, <#T##ioNumPackets: UnsafeMutablePointer<UInt32>##UnsafeMutablePointer<UInt32>#>, <#T##outBuffer: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>)
    }
    
    func close() {
        if let id = fileID {
            AudioFileClose(id)
        }
    }
}
