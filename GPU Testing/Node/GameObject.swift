//
//  GameObject.swift
//  GPU Testing
//
//  Created by Roman Esin on 11.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

class GameObject: Node {
    var modelConstants = ModelConstants()
    
    var mesh: Mesh
    
    override func update(_ deltaTime: Float) {
        super.update(deltaTime)
//        time += deltaTime
        
//        position.x = sin(time)
//        position.y = cos(time)
//        scale = simd_float3(repeating: cos(time / 2))
//        rotation.z = sin(time * 4)
        
        updateModel()
    }
    
    func updateModel() {
        modelConstants.matrix = modelMatrix
    }
    
    init(_ meshType: MeshType) {
        mesh = MeshLibrary.mesh(meshType)
    }
}

extension GameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        if Preferences.isDebug {
            renderCommandEncoder.setTriangleFillMode(.lines)
        }
        
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 1)
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.state(Preferences.renderPipelineStateType))
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
    }
}
