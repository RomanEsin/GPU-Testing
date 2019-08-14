//
//  VertexLibrary.swift
//  GPU Testing
//
//  Created by Roman Esin on 11.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

enum VertexDescriptorType {
    case basic
}

protocol VertexDescriptor {
    var name: String { get }
    var descriptor: MTLVertexDescriptor { get }
}

class VertexDescriptorLibrary {
    private static var descriptors: [VertexDescriptorType: VertexDescriptor] = [:]
    
    public static func `init`() {
        let defaultDescriptor = DefaultVertexDescriptor()
        descriptors.updateValue(defaultDescriptor, forKey: .basic)
    }
    
    public static func descriptor(_ type: VertexDescriptorType) -> MTLVertexDescriptor {
        return descriptors[type]!.descriptor
    }
}

class DefaultVertexDescriptor: VertexDescriptor {
    var name = "DefaultVertexDescriptor"
    var descriptor: MTLVertexDescriptor = {
        let vertexDescriptor = MTLVertexDescriptor()
        
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = MemoryLayout<simd_float3>.stride
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        
        return vertexDescriptor
    }()
}
