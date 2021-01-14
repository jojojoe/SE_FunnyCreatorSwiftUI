//
//  UserEvents_CamCreator.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/14.
//

import Foundation
import SwiftUI

public class UserEvents_CamCreator: ObservableObject {
    @Published public var didAskToCapturePhoto = false
    @Published public var didAskToRotateCamera = false
    @Published public var didAskToChangeFlashMode = false
    
    @Published public var didAskToRecordVideo = false
    @Published public var didAskToStopRecording = false
    
    @Published public var didTakeCapturePhoto = false
    @Published public var didTakeCapturePhoto_wallpaper = false
    @Published public var resultImage: UIImage? = nil
    public init() {
        
    }
}
