//
//  CameraViewControllerDelegate_CamCreator.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/14.
//

import Foundation
import UIKit

public protocol CameraViewControllerDelegate_CamCreator {
//    func cameraAccessGranted()
//    func cameraAccessDenied()
    func noCameraDetected()
    func cameraSessionStarted()
    
    func didCapturePhoto()
    func didRotateCamera()
    func didChangeFlashMode()
    func didFocusOnPoint(_ point: CGPoint)
    func didChangeZoomLevel(_ zoom: CGFloat)
    
    func didStartVideoRecording()
    func didFinishVideoRecording()
    
    //    func didSavePhoto()
    func didFinishProcessingPhoto(_ image: UIImage)
    func didFinishSavingWithError(_ image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer)
    
    func didChangeMaximumVideoDuration(_ duration: Double)
}
