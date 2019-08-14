//
//  Node.swift
//  GPU Testing
//
//  Created by Roman Esin on 11.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

protocol Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder)
}

struct ModelConstants {
    var matrix = matrix_identity_float4x4
    
    static var stride: Int {
        return MemoryLayout<Self>.stride
    }
}

class Node {
    
    var position = simd_float3(0, 0, 0)
    var scale = simd_float3(1, 1, 1)
    var rotation = simd_float3(0, 0, 0)
    
    var modelMatrix: simd_float4x4 {
        var matrix = matrix_identity_float4x4
        matrix.translate(position)
        matrix.scale(scale)
        matrix.rotate(rotation.x, simd_float3(1, 0, 0))
        matrix.rotate(rotation.y, simd_float3(0, 1, 0))
        matrix.rotate(rotation.z, simd_float3(0, 0, 1))
        return matrix
    }
    
    var children: [Node] = []
    
    func addChild(_ child: Node) {
        children.append(child)
    }
    
    func update(_ deltaTime: Float) {
        for child in children {
            child.update(deltaTime)
        }
    }
    
    func render(encoder renderCommandEncoder: MTLRenderCommandEncoder) {
        for child in children {
            child.render(encoder: renderCommandEncoder)
        }
        
        if let renderable = self as? Renderable {
            renderable.doRender(renderCommandEncoder)
        }
    }
}
