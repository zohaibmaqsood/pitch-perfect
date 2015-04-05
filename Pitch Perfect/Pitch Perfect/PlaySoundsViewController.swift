//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Zohaib Maqsood on 4/3/15.
//  Copyright (c) 2015 Xeb. All rights reserved.
//

import UIKit

class PlaySoundsViewController: EffectsViewController {
    
    var receivedAudio : RecordedAudio!;
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func playSlowMotion(sender: AnyObject) {
        playSound(0.5, stopButton: &stopButton);
    }
    
    @IBAction func playFastMotion(sender: AnyObject) {
        playSound(1.5, stopButton: &stopButton);
    }
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithSinglePitch(1000, stopButton: &stopButton);
    }
    
    @IBAction func playDartvaderAudio(sender: AnyObject) {
        playAudioWithSinglePitch(-1000, stopButton: &stopButton);
    }
    
    @IBAction func stopSound(sender: AnyObject) {
        stopAudioRecording(&stopButton);
    }
    
    override func getFilePath() -> NSURL!{
        var nsURL : NSURL!;
        if var url = receivedAudio {
            nsURL = receivedAudio.filePathUrl;
        } else if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            nsURL = NSURL.fileURLWithPath(filePath);
        }
        return nsURL;
    }
    
}
