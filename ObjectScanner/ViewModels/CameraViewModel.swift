//
//
// CameraViewModel.swift
// ObjectScanner
//
// Created by sturdytea on 29.06.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Combine
import Foundation

@MainActor
final class CameraViewModel: ObservableObject {
    
    let cameraManager: CameraManager
    
    init() {
        self.cameraManager = CameraManager()
    }
    
    func startCamera() {
        cameraManager.onFrameCaptured = { pixelBuffer in
            print(pixelBuffer)
        }
        cameraManager.configure()
        cameraManager.start()
    }
}

