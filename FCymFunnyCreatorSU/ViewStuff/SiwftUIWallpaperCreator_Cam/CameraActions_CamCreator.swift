//
//  CameraActions_CamCreator.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/14.
//

import Foundation

public protocol CameraActions_CamCreator {
    func takePhoto(events: UserEvents_CamCreator)
    func toggleVideoRecording(events: UserEvents_CamCreator)
    func rotateCamera(events: UserEvents_CamCreator)
    func changeFlashMode(events: UserEvents_CamCreator)
}

public extension CameraActions_CamCreator {
    func takePhoto(events: UserEvents_CamCreator) {
        events.didAskToCapturePhoto = true
    }
    
    func toggleVideoRecording(events: UserEvents_CamCreator) {
        if events.didAskToRecordVideo {
            events.didAskToStopRecording = true
        } else {
            events.didAskToRecordVideo = true
        }
    }
    
    func rotateCamera(events: UserEvents_CamCreator) {
        events.didAskToRotateCamera = true
    }
    
    func changeFlashMode(events: UserEvents_CamCreator) {
        events.didAskToChangeFlashMode = true
    }
    
    // 清除当前 拍过的照片
    func clearCurrentCaptionPhoto(events: UserEvents_CamCreator) {
        events.didTakeCapturePhoto = false
        events.resultImage = nil
    }
    
}
