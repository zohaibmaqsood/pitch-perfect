//f
//  Pitch Perfect
//
//  Created by Zohaib Maqsood on 4/4/15.
//  Copyright (c) 2015 Xeb. All rights reserved.
//

import UIKit;
import AVFoundation;

class ViewController: UIViewController, AVAudioRecorderDelegate{
    
    let DATE_FORMAT : String = "ddMMyyyy-HHmmss";
    let IMG_PAUSE : String = "pause.jpeg";
    let IMG_RECORD : String = "mic.png";
    let STOP_RECORDING : String = "stopRecording";
    let LABEL_RECORDING : String = "Recording...";
    let LABEL_PAUSED : String = "Paused";
    let LABEL_TAP_TO_RECORD : String = "Tap To Record";
    
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    /**
    * Stop Audio Recording
    **/
    func stopAudioRecording(inout stopButton: UIButton!){
        audioRecorder.stop();
        stopButton.hidden = true;
        var audioSession = AVAudioSession.sharedInstance();
        audioSession.setActive(false, error: nil);
    }
    
    /**
    * Audio Recorder Did Finish Recording
    **/
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool, inout recordedAudio: RecordedAudio!) {
        if flag {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url); //Step 1 - Save the recorded Audio
            self.performSegueWithIdentifier(STOP_RECORDING, sender: recordedAudio); //Step 2 - Move to the next screen Aka Perform Segue
        } else {
            log("failed to save or perform segue");
        }
    }
    
    /**
    * Record Me
    * @param: hold reference of audioRecorder
    **/
    func recordMe(){
    
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let formatter = NSDateFormatter();
        formatter.dateFormat = DATE_FORMAT;
        let pathArray = [dirPath, "Xeb"+formatter.stringFromDate(NSDate())+".wav"]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
    
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
    
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self;
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
    }

    /**
    * log to console
    **/
    func log(trace: String) {
        println("logger ---> " + trace);
    }
}
