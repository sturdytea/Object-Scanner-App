//
//
// CameraView.swift
// ObjectScanner
//
// Created by sturdytea on 29.06.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import SwiftUI

struct CameraView: View {
    
    @StateObject private var viewModel = CameraViewModel()
    
    var body: some View {
        ZStack {
            CameraPreview(session: viewModel.cameraManager.session)
                .ignoresSafeArea()
            VStack {
                Spacer()
                if let result = viewModel.detectionResult {
                    Group {
                        Text(result.identifier)
                            .font(.title2)
                            .bold()
                        Text("\(Int(result.confidence * 100))%")
                            .font(.caption)
                    }
                    .shadow(color: .black.opacity(0.3), radius: 4)
                }
            }
            .padding(.bottom, 50)
        }
        .task {
            viewModel.startCamera()
        }
    }
}

//#Preview {
//    CameraView()
//}
