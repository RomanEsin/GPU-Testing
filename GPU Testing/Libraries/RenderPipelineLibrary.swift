//
//  RenderPipelineLibrary.swift
//  GPU Testing
//
//  Created by Roman Esin on 11.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

enum RenderPipelineDescriptorType {
    case basic
}

protocol RenderPipelineDescriptor {
    var name: String { get }
    var descriptor: MTLRenderPipelineDescriptor { get }
}

class RenderPipelineDescriptorLibrary {
    private static var descriptors: [RenderPipelineDescriptorType: RenderPipelineDescriptor] = [:]
    
    public static func `init`() {
        let defaultDescriptor = DefaultRenderPipelineDescriptor()
        descriptors.updateValue(defaultDescriptor, forKey: .basic)
    }
    
    public static func descriptor(_ type: RenderPipelineDescriptorType) -> MTLRenderPipelineDescriptor {
        return descriptors[type]!.descriptor
    }
}

class DefaultRenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "BasicRenderPipelineDescriptor"
    var descriptor: MTLRenderPipelineDescriptor = {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.colorFormat
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.vertex(Preferences.vertexType)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.descriptor(Preferences.vertexDescriptorType)
        
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.fragment(Preferences.fragmentType)
        return renderPipelineDescriptor
    }()
}
