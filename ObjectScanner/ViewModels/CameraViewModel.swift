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
    private let classifier: ObjectClassifier
    
    init() {
        self.cameraManager = CameraManager()
        self.classifier = ObjectClassifier()
    }
    
    func startCamera() {
        cameraManager.onFrameCaptured = { [weak self] pixelBuffer in
            self?.classifier.detect(in: pixelBuffer) { object in
                print(object ?? "Nothing")
            }
        }
        cameraManager.configure()
        cameraManager.start()
    }
}

