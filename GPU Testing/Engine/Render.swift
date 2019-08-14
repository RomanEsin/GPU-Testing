//
//  Render.swift
//  GPU Testing
//
//  Created by Roman Esin on 11.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

class Renderer: NSObject {
    
    public static var screenSize = simd_float2(0, 0)
    
    var scene = SandboxScene()
    
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        Renderer.screenSize = simd_float2(Float(size.width), Float(size.height))
    }
    
    func draw(in view: MTKView) {
        guard
            let drawable = view.currentDrawable,
            let renderPassDescriptor = view.currentRenderPassDescriptor else {
                return
        }
        
        guard let commandBuffer = Engine.commandQueue.makeCommandBuffer() else { return }
        guard let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else { return }
        
        scene.renderAndUpdate(encoder: renderCommandEncoder, deltaTime: 1 / Float(view.preferredFramesPerSecond))
        
        renderCommandEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
    
    
}
