//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Zohaib Maqsood on 3/15/15.
//  Copyright (c) 2015 Xeb. All rights reserved.
//

import UIKit
import AVFoundation;

class RecordSoundsViewController: ViewController {

    @IBOutlet weak var recordingLabel: UILabel!, recordButton: UIButton!, stopButton: UIButton!
    var stopped = false, paused = false;
    var recordedAudio: RecordedAudio!;
    
    @IBAction func Record(sender: AnyObject) {
        if !paused {
            stopButton.hidden = false;
            recordingLabel.hidden = false;
            changeRecordLabelAndIcon(IMG_PAUSE, text: LABEL_RECORDING);
            recordMe();
            stopped = false;
        } else {
            changeRecordLabelAndIcon(IMG_PAUSE, text: LABEL_PAUSED);
        }
        paused = !paused;
        log("recording....")
    }
    
    @IBAction func stop(sender: AnyObject) {
        stopAudioRecording(&stopButton);
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        audioRecorderDidFinishRecording(recorder, successfully: flag, recordedAudio: &recordedAudio);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        performStopAction();
        if(segue.identifier == STOP_RECORDING){
            var playSoundsViewController:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController;
            playSoundsViewController.receivedAudio = sender as RecordedAudio;
        }
    }
    
    private func changeRecordLabelAndIcon(icon: String, text: String){
        recordButton.setImage(UIImage(named: icon), forState: UIControlState.Normal);
        recordingLabel.text = text;
    }
    
    private func performStopAction(){
        paused = false;
        changeRecordLabelAndIcon(IMG_RECORD, text: LABEL_TAP_TO_RECORD);
        log("stopped....");
    }
}

