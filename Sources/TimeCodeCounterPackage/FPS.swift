//
//  FPS.swift
//  
//
//  Created by 史 翔新 on 2022/11/16.
//

import Foundation

public enum FPS {
    // TODO: More FPS options support
    case f59_94_ndf
}
        
extension FPS {
    
    var framesPerSecondOnTimeCode: Int {
        switch self {
        case .f59_94_ndf:
            return 60
        }
    }
    
    var framesPer10Minutes: Int {
        let secondsIn10Minutes: Double = 60 * 10
        switch self {
        case .f59_94_ndf:
            return Int(59.94 * secondsIn10Minutes)
        }
    }
    
    public func frameCount(during elapsedTime: TimeInterval) -> Int {
        let frames = (elapsedTime / TimeInterval(secondsPer10Minutes)) * TimeInterval(framesPer10Minutes)
        let frameCount = Int(frames.rounded())
        return frameCount
    }
    
    public func formattedTimeCode(during elapsedTime: TimeInterval) -> String {
        // https://video.stackexchange.com/questions/22722/how-are-frames-in-59-94-drop-frame-timecode-dropped
        let frameCount = frameCount(during: elapsedTime)
        let ff = frameCount % framesPerSecondOnTimeCode
        let seconds = frameCount / framesPerSecondOnTimeCode
        let timePart = timeFormatter.string(seconds: seconds)
        return "\(timePart):\(ff)"
    }
    
}

private let timeFormatter: TimeFormatter = .init()

private var secondsPer10Minutes: Int {
    600
}
