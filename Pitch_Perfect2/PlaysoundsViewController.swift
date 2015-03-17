//
//  PlaysoundsViewController.swift
//  Pitch_Perfect2
//
//  Created by robjohn on 3/12/15.
//  Copyright (c) 2015 Robert Johnston. All rights reserved.
//

import UIKit
import AVFoundation


class PlaysoundsViewController: UIViewController {

    
    // Create a variable for the audioplayer to be called later
    var audioPlayer = AVAudioPlayer()
    var recievedAudio:RecordedAudio!
    
    // Adding audioEngine for lesson 4B
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    
    //DONE: Trying to define my own func to include in buttons.
    func commonbutton() {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        audioEngine.stop()
        audioEngine.reset()
        let session = AVAudioSession.sharedInstance()
        session.setActive(false, error: nil)
        println("commonbutton did work")
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DONE: Adding the Audio Engine
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        //This piece of code sets the sound to always play on the Speakers
        let session = AVAudioSession.sharedInstance()
        var error: NSError?
        session.setCategory(AVAudioSessionCategoryPlayback, error: &error)
//        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: &error)
        session.setActive(true, error: &error)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playback(sender: UIButton) {
        // Audio playback slowlllyyy
     
        audioPlayer.rate = 0.5
        commonbutton()
        
    }
    
    @IBAction func fastplayback(sender: UIButton) {
        audioPlayer.rate = 1.5
        commonbutton()
        
    }

    @IBAction func playChipmonkAudio(sender: UIButton) {
        //In playChipmunkAudio
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
        //New Function
        func playAudioWithVariablePitch(pitch: Float){
            audioPlayer.stop()
            audioEngine.stop()
            audioEngine.reset()
            
            var audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attachNode(audioPlayerNode)
            
            var changePitchEffect = AVAudioUnitTimePitch()
            changePitchEffect.pitch = pitch
            audioEngine.attachNode(changePitchEffect)
            
            audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
            audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
            
            audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            audioEngine.startAndReturnError(nil)
            
            audioPlayerNode.play()
            

        }
    
    @IBAction func playbackstop(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        let session = AVAudioSession.sharedInstance()
        session.setActive(false, error: nil)
    }
    



}
