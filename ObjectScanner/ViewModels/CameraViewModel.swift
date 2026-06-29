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
    
    @Published var detectionResult: ClassifierResult?
    let cameraManager: CameraManager
    private let classifier: ObjectClassifier
    private var lastIdentifier: String?
    private var isDetecting = false
    
    init() {
        self.cameraManager = CameraManager()
        self.classifier = ObjectClassifier()
    }
    
    func startCamera() {
        cameraManager.onFrameCaptured = { [weak self] pixelBuffer in
            guard let self else { return }
            guard !self.isDetecting else { return }
            self.isDetecting = true
            self.classifier.detect(in: pixelBuffer) { [weak self] result in
                guard let self else { return }
                defer {
                    self.isDetecting = false
                }
                guard let result else { return }
                
                guard result.identifier != self.lastIdentifier else { return }
                
                self.lastIdentifier = result.identifier
                
                Task { @MainActor in
                    self.detectionResult = result
                }
            }
        }
        cameraManager.configure()
        cameraManager.start()
    }
}

