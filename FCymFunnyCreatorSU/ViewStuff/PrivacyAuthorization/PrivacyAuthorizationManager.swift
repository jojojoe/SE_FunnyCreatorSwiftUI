//
//  PrivacyAuthorizationManager.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/8.
//

import Foundation
import AVFoundation
import Photos
import UIKit

class PrivacyAuthorizationManager {
    static let `default` = PrivacyAuthorizationManager()
    
    func requestPhotosPermission(authorizedBlock: @escaping (()->Void), deniedBlock: @escaping (()->Void)) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            authorizedBlock()
        case .restricted, .denied:
            deniedBlock()
        case .notDetermined:
            // Show permission popup and get new status
            PHPhotoLibrary.requestAuthorization { status in
                if status != .authorized {
                    deniedBlock()
                }
                DispatchQueue.main.async {
                    if status == .authorized {
                        authorizedBlock()
                    } else {
                        deniedBlock()
                    }
                }
            }
        case .limited:
            deniedBlock()
        @unknown default:
            deniedBlock()
            return
        }
        
    }
    
    func requestCameraPermission(authorizedBlock: @escaping (()->Void), deniedBlock: @escaping (()->Void)) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            authorizedBlock()
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if granted {
                    // 授权
                    authorizedBlock()
                } else {
                    deniedBlock()
                }  
            })
            break
        default:
            // The user has previously denied access.
            deniedBlock()
            break
        }
    }
    
    func openSettingPage() {
        let url = NSURL.init(string: UIApplication.openSettingsURLString)
        let canOpen = UIApplication.shared.canOpenURL(url! as URL)
        if canOpen {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
}







