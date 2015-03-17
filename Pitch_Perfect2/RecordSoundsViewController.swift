//
//  RecordSoundsViewController.swift
//  Pitch_Perfect2
//
//  Created by robjohn on 3/6/15.
//  Copyright (c) 2015 Robert Johnston. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
 
    
    @IBOutlet weak var recordButton: UIButton!

    @IBOutlet weak var tapToRecord: UILabel!
    
    @IBOutlet weak var recordingInProgress: UILabel!
    
    @IBOutlet weak var stopbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //Hide the stop button
        stopbutton.hidden = true
        //Enable the record button
        recordButton.enabled = true
        //Unhide tapToRecord when coming back from Playsounds
        tapToRecord.hidden = false

    }
    @IBAction func recordaudio(sender: UIButton) {
        // DONE: Show Text "Recording in progress"
        tapToRecord.hidden = true
        recordingInProgress.hidden = false
        stopbutton.hidden = false
        recordButton.enabled = false
        // DONE: Record user's voice
        println("In Recording")
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        //Initialize the Audiorecorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()

        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            //DONE: Step 1 save the recorded audio - DONE
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)

        
            //DONE: Step 2 Move to the next scene aka perform a sequeway
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            println("We were successful at recording audio")
            
            
        }else{
            println("Recording was not successful")
            recordButton.enabled = true
            stopbutton.hidden = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaysoundsViewController = segue.destinationViewController as PlaysoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.recievedAudio = data
        }
    }
    
    @IBAction func stoprecording(sender: UIButton) {
        recordingInProgress.hidden = true
        stopbutton.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)


    }
}

