//
//
// CameraManager.swift
// ObjectScanner
//
// Created by sturdytea on 29.06.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation
import AVFoundation

final class CameraManager: NSObject {
    
    let session = AVCaptureSession()
    
    func configure() {
        session.beginConfiguration()
        session.sessionPreset = .high
        
        guard
            let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(input) {
                session.addInput(input)
            }
        } catch {
            print(error)
        }
        
        session.commitConfiguration()
    }
    
    func start() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }
    
    func stop() {
        session.stopRunning()
    }
}

