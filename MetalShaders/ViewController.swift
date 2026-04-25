//
//  ViewController.swift
//  MetalShaders
//
//  Created by Home on 23/04/26.
//

import UIKit
import Metal
import SwiftUI

final class ViewController: UIViewController {
    
    private var device: MTLDevice!
    private var metalLayer: CAMetalLayer!
    private var commandQueue: MTLCommandQueue!
    private var pipelineState: MTLRenderPipelineState!
    
    // Vertex structure (must match ShaderTypes.h)
    struct VertexData {
        var position: SIMD4<Float>
        var color: SIMD4<Float>
    }
    
    // Triangle data
    private var vertices: [VertexData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMetal()
        setupVertices()
        setupPipeline()
        render()
    }
    
    private func setupMetal() {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Metal not supported")
        }
        
        self.device = device
        self.commandQueue = device.makeCommandQueue()
        
        metalLayer = CAMetalLayer()
        metalLayer.device = device
        metalLayer.pixelFormat = .bgra8Unorm
        metalLayer.frame = view.layer.bounds
        metalLayer.contentsScale = UIScreen.main.scale
        
        view.layer.addSublayer(metalLayer)
    }
    
    private func setupVertices() {
        vertices = [
            // Triangle centered at (0,0)
            VertexData(position: [-100, -100, 0, 1], color: [1, 0, 0, 1]), // Red
            VertexData(position: [ 100, -100, 0, 1], color: [0, 1, 0, 1]), // Green
            VertexData(position: [   0,  100, 0, 1], color: [0, 0, 1, 1])  // Blue
        ]
    }
    
    private func setupPipeline() {
//        let vertexFunction = MetalLibs.UIKitTest.vertex.vertexShader.makeMTLFunction()
//        let fragmentFunction = MetalLibs.UIKitTest.fragment.fragmentShader.makeMTLFunction()
        
        let vertexFunction = MetalLibs.DefaultMacOS.vertex.vertexShader.makeMTLFunction()
        let fragmentFunction = MetalLibs.DefaultMacOS.fragment.fragmentShader.makeMTLFunction()
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.label = "Basic Pipeline"
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError("Pipeline creation failed: \(error)")
        }
    }
    
    private func render() {
        guard
            let drawable = metalLayer.nextDrawable(),
            let commandBuffer = commandQueue.makeCommandBuffer()
        else { return }
        
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].storeAction = .store
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 1, 1, 1) // Cyan background
        
        guard let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
            return
        }
        
        encoder.setRenderPipelineState(pipelineState)
        
        // Send vertex data
        encoder.setVertexBytes(vertices,
                               length: MemoryLayout<VertexData>.stride * vertices.count,
                               index: 0)
        
        // Send viewport size
        var viewportSize = SIMD2<UInt32>(
            UInt32(view.bounds.width),
            UInt32(view.bounds.height)
        )
        
        encoder.setVertexBytes(&viewportSize,
                               length: MemoryLayout<SIMD2<UInt32>>.stride,
                               index: 1)
        
        // Draw triangle
        encoder.drawPrimitives(type: .triangle,
                               vertexStart: 0,
                               vertexCount: 3)
        
        encoder.endEncoding()
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}

struct UIKitShader: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
