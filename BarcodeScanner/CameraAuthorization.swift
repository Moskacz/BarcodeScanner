//
//  CameraAuthorization.swift
//  BarcodeScanner
//
//  Created by Michal Moskala on 05/11/2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
import AVFoundation

protocol CameraAuthorization {
    static var cameraAuthorizationStatus: AVAuthorizationStatus { get }
    static func requestCameraAccess(completion: @escaping (Bool) -> Void)
}

extension AVCaptureDevice: CameraAuthorization {
    static var cameraAuthorizationStatus: AVAuthorizationStatus {
        return authorizationStatus(for: .video)
    }
    
    static func requestCameraAccess(completion: @escaping (Bool) -> Void) {
        requestAccess(for: .video, completionHandler: completion)
    }
}
