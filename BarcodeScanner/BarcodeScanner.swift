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
    
    private let cameraAuthorization: CameraAuthorization.Type
    
    init(cameraAuthorization: CameraAuthorization.Type) {
        self.cameraAuthorization = cameraAuthorization
    }
    
    enum Error {
        case noCamera
        case cameraUsageDanied
        case cameraUsageNotAuthorized
    }
    
    func askForCameraPermissions(completion: @escaping (Bool) -> Void) {
        let authorizationStatus = cameraAuthorization.cameraAuthorizationStatus
        
        switch authorizationStatus {
        case .authorized:
            completion(true)
        case .restricted, .denied:
            completion(false)
        case .notDetermined:
            cameraAuthorization.requestCameraAccess(completion: completion)
        }
    }
}
