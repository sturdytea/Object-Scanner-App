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
        
        CameraPreview(session: viewModel.cameraManager.session)
            .ignoresSafeArea()
            .task {
                viewModel.startCamera()
            }
    }
}

//#Preview {
//    CameraView()
//}
