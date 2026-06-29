//
//
// ObjectClassifier.swift
// ObjectScanner
//
// Created by sturdytea on 29.06.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import CoreML
import Vision
import Foundation

final class ObjectClassifier {
    
    private let visionModel: VNCoreMLModel
    
    init() {
        guard let model = try? VNCoreMLModel(for: MobileNetV2().model) else {
            fatalError("Unable to load the model.")
        }
        self.visionModel = model
    }
    
    func detect(
        in pixelBuffer: CVPixelBuffer,
        completion: @escaping (ClassifierResult?) -> Void
    ) {
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            
            guard
                let results = request.results as? [VNClassificationObservation],
                let first = results.first
            else {
                completion(nil)
                return
            }
            
            guard first.confidence > 0.5 else {
                completion(nil)
                return
            }
            
            completion(ClassifierResult(identifier: first.identifier, confidence: first.confidence))
        }
        
        let handler = VNImageRequestHandler(
            cvPixelBuffer: pixelBuffer,
            orientation: .up,
            options: [:]
        )

        do {
            try handler.perform([request])
        } catch {
            completion(nil)
        }
    }
}
