//
//  SoundControl.swift
//  Time2
//
//  Created by abhishek on 9/11/17.
//  Copyright © 2017 abhishek. All rights reserved.
//
import UIKit
import Foundation
import AudioToolbox
import AVFoundation

class SoundControl: UIResponder, UIApplicationDelegate, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?

    public func playAudio(play file: String) {
/*
    //vibrate phone first
    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    //set vibrate callback
    AudioServicesAddSystemSoundCompletion(SystemSoundID(kSystemSoundID_Vibrate),nil,
    nil,
    { (_:SystemSoundID, _:UnsafeMutableRawPointer?) -> Void in
    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    },
    nil)
 */ 
 let url = URL(fileURLWithPath: Bundle.main.path(forResource: "Relax2", ofType: "mp3")!)
    
    var error: NSError?
    
    do {
    audioPlayer = try AVAudioPlayer(contentsOf: url)
    } catch let error1 as NSError {
    error = error1
    audioPlayer = nil
    }
    
    if let err = error {
        print("audioPlayer error \(err.localizedDescription)")
        return
    } else {
    audioPlayer!.delegate = self
    audioPlayer!.prepareToPlay()
    }
    
    //negative number means loop infinity
    audioPlayer!.numberOfLoops = -1
    audioPlayer!.play()
    }
    public func StopAudio() {
        audioPlayer!.stop()
        audioPlayer = nil
    }
   /*
     private var audioPlayer: AVAudioPlayer?
     public func playAudio(play file: String) {
        print("file: ",file)
        let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: file, ofType: "mp4")!)
        print(alertSound)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        try! audioPlayer = AVAudioPlayer(contentsOf: alertSound)
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()

    }
    
   */

}
