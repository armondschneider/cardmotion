//
//  MetalView.swift
//  cardmotion
//
//  Created by Armond Schneider on 11/17/24.
//

import SwiftUI
import MetalKit

struct MetalShimmerView: UIViewRepresentable {
    @Binding var shimmerIntensity: Float

    func makeUIView(context: Context) -> MTKView {
        let device = MTLCreateSystemDefaultDevice()!
        let view = MTKView(frame: .zero, device: device)
        view.delegate = context.coordinator
        view.isPaused = false
        view.enableSetNeedsDisplay = true
        return view
    }

    func updateUIView(_ uiView: MTKView, context: Context) {
        context.coordinator.shimmerIntensity = shimmerIntensity
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, MTKViewDelegate {
        var parent: MetalShimmerView
        var commandQueue: MTLCommandQueue?
        var pipelineState: MTLRenderPipelineState?
        var shimmerIntensity: Float = 0.0

        init(_ parent: MetalShimmerView) {
            self.parent = parent
            super.init()
            let device = MTLCreateSystemDefaultDevice()!
            commandQueue = device.makeCommandQueue()

            let library = device.makeDefaultLibrary()!
            let vertexFunction = library.makeFunction(name: "vertexShader")
            let fragmentFunction = library.makeFunction(name: "fragmentShader")

            let pipelineDescriptor = MTLRenderPipelineDescriptor()
            pipelineDescriptor.vertexFunction = vertexFunction
            pipelineDescriptor.fragmentFunction = fragmentFunction
            pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

            pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        }

        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}

        func draw(in view: MTKView) {
            guard let drawable = view.currentDrawable,
                  let descriptor = view.currentRenderPassDescriptor else { return }

            let commandBuffer = commandQueue!.makeCommandBuffer()!
            let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor)!
            commandEncoder.setRenderPipelineState(pipelineState!)
            commandEncoder.setFragmentBytes(&shimmerIntensity, length: MemoryLayout<Float>.size, index: 0)
            commandEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
            commandEncoder.endEncoding()

            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
}
