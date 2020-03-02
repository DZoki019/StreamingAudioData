//
//  AudioStreamer.swift
//  Go Go Encode - Streaming Audio Data
//
//  Created by Djordje Jovic.
//  Copyright © 2020 Go Go Encode.
//

import Foundation
import AVFoundation

/// Stream audio from audio data transefred via `scheduleData` function.
class AudioStreamer {
    
    private var audioEngine: AVAudioEngine = AVAudioEngine()
    private var audioBufferPlayer: AVAudioPlayerNode = AVAudioPlayerNode()
    
    private var audioFormat: AVAudioFormat
    
    init?(audioFormat: AVAudioFormat) {
        self.audioFormat = audioFormat
        do {
            let mixer = audioEngine.mainMixerNode
            audioEngine.attach(audioBufferPlayer)
            audioEngine.connect(audioBufferPlayer, to: mixer, format: self.audioFormat)
            try audioEngine.start()
            audioBufferPlayer.play()
        } catch let error {
            print(error)
        }
    }
    
    func scheduleData(audioData: Data) {
        guard let audioFileBuffer = audioData.makePCMBuffer(format: audioFormat) else { return }
        audioBufferPlayer.scheduleBuffer(audioFileBuffer)
    }
}
