//
//  BarcodeScanner.swift
//  BarcodeScanner
//
//  Created by Michal Moskala on 03/11/2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import UIKit
import AVFoundation

class BarcodeScanner {
    
    enum Error {
        case noCamera
        case cameraUsageDanied
        case cameraUsageNotAuthorized
    }
    
    static func askForCameraPermissions(completion: @escaping (Bool) -> Void) {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authorizationStatus {
        case .authorized:
            completion(true)
        case .restricted, .denied:
            completion(false)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: completion)
        }
    }
}
