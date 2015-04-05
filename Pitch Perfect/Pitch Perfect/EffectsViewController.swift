//
//  EffectsViewController.swift
//  Pitch Perfect
//
//  Created by Zohaib Maqsood on 4/4/15.
//  Copyright (c) 2015 Xeb. All rights reserved.
//

import UIKit;
import AVFoundation;

class EffectsViewController: ViewController, FileProtocol {

    var audioPlayer : AVAudioPlayer!;
    var audioEngine : AVAudioEngine!;
    var audioFile:AVAudioFile!
    
    /**
    * View did load
    **/
    override func viewDidLoad() {
        super.viewDidLoad();
        setAudioPlayer();
        setAudioFile();
    }
    
    /**
    * set AudioPlayer
    **/
    func setAudioPlayer(){
        audioPlayer = AVAudioPlayer(contentsOfURL: getFilePath()!, error: nil);
        audioPlayer.enableRate = true;
    }
    /**
    * set AudioPlayer
    **/
    func setAudioFile(){
        audioEngine = AVAudioEngine();
        audioFile = AVAudioFile(forReading: getFilePath(), error: nil);
    }
    /**
    * Stop Audio Recording
    **/
    override func stopAudioRecording(inout stopButton: UIButton!){
        reset();
        stopButton.hidden = true;
    }
    /**
    * Reset previous played audio
    **/
    private func reset(){
        audioPlayer.stop();
        audioEngine.stop();
        audioEngine.reset();
    }
    /**
    * Play Audio With Single Pitch
    * @param: pitch
    **/
    func playAudioWithSinglePitch(pitch: Float, inout stopButton: UIButton!){
        reset();
        stopButton.hidden = false;
        var audioPlayerNode = AVAudioPlayerNode();
        audioEngine.attachNode(audioPlayerNode);
        
        var changePitchEffect = AVAudioUnitTimePitch();
        changePitchEffect.pitch = pitch;
        audioEngine.attachNode(changePitchEffect);
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil);
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil);
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil);
        audioEngine.startAndReturnError(nil);
        
        audioPlayerNode.play();
    }
    
    /**
    *  Play Sound
    * @param: rate
    **/
    func playSound(rate: Float, inout stopButton: UIButton!){
        reset();
        stopButton.hidden = false;
        audioPlayer.rate = rate;
        audioPlayer.currentTime = 0;
        audioPlayer.play();
    }
    
    func getFilePath() -> NSURL!{
        return nil;
    }
}
