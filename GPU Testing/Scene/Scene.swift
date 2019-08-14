//
//  Scene.swift
//  GPU Testing
//
//  Created by Roman Esin on 12.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

class Scene: Node {
    override init() {
        super.init()
        setup()
    }
    
    func setup() {}
    
    func renderAndUpdate(encoder: MTLRenderCommandEncoder, deltaTime: Float) {
        self.update(deltaTime)
        self.render(encoder: encoder)
    }
}

class SandboxScene: Scene {
    override func setup() {
        let count = 30
        
        for y in -count...count {
            for x in -count...count {
                let p = Player()
                p.position.y = Float(Float(y) + 0.5) / Float(count)
                p.position.x = Float(Float(x) + 0.5) / Float(count)
                p.scale = simd_float3(0.08, 0.08, 0.08)
                addChild(p)
            }
        }
    }
    
    var time: Float = 0
    
    override func renderAndUpdate(encoder: MTLRenderCommandEncoder, deltaTime: Float) {
        self.update(deltaTime)
        
        encoder.setVertexBytes(&time, length: MemoryLayout<Float>.stride, index: 2)
        
        self.render(encoder: encoder)
    }
    
    override func update(_ deltaTime: Float) {
        super.update(deltaTime)
    }
}
