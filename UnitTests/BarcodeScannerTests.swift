//
//  BarcodeScannerTests.swift
//  UnitTests
//
//  Created by Michal Moskala on 05/11/2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
import AVFoundation

class BarcodeScannerTests: XCTestCase {

    func test_requestPermissions_whenAuthorizationStatusIsDeniedOrRestricted_thenItFailsImmediately() {
        let authorization = FakeCameraAuthorization.self
        authorization.cameraAuthorizationStatus = .denied
        let sut = BarcodeScanner(cameraAuthorization: authorization)
        sut.askForCameraPermissions { result in
            XCTAssertFalse(result)
        }
        
        authorization.cameraAuthorizationStatus = .restricted
        sut.askForCameraPermissions { result in
            XCTAssertFalse(result)
        }
    }
    
    func test_requestPermissions_whenAuthorizationStatusIsAuthorized_thenItCompletedImmediately() {
        let authorization = FakeCameraAuthorization.self
        authorization.cameraAuthorizationStatus = .authorized
        let sut = BarcodeScanner(cameraAuthorization: authorization)
        sut.askForCameraPermissions { result in
            XCTAssertTrue(result)
        }
    }
    
    func test_requestPermissions_whenAuthorizationStatusIsNotDetermined_thenShouldBeRequested() {
        let authorization = FakeCameraAuthorization.self
        authorization.cameraAuthorizationStatus = .notDetermined
        let sut = BarcodeScanner(cameraAuthorization: authorization)
        sut.askForCameraPermissions(completion: { _ in })
        XCTAssertTrue(authorization.requestCameraCalled)
    }
}

private class FakeCameraAuthorization: CameraAuthorization {
    
    static var requestCameraCalled = false
    static var cameraAuthorizationStatus: AVAuthorizationStatus = .restricted
    
    static func requestCameraAccess(completion: @escaping (Bool) -> Void) {
        requestCameraCalled = true
    }
}
