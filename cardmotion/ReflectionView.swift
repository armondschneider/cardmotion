//
//  ReflectionView.swift
//  cardmotion
//
//  Created by Armond Schneider on 10/23/24.
//

import SwiftUI
import AVFoundation

struct ReflectionView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let captureSession = AVCaptureSession() // Camera access
        
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else { return view }
        
        captureSession.addInput(videoInput)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
