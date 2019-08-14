//
//  ShaderLibrary.swift
//  GPU Testing
//
//  Created by Roman Esin on 11.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

enum VertexType {
    case basic
}

enum FragmentType {
    case basic
}

class Shader {
    public var functionName: String
    public var function: MTLFunction
    
    init(_ name: String) {
        functionName = name
        function = ShaderLibrary.default.makeFunction(name: functionName)!
    }
}

class ShaderLibrary {
    public static var `default`: MTLLibrary! {
        didSet {
            let defaultVertex = Shader("vertex_shader")
            let defaultFragment = Shader("fragment_shader")
            
            vertexShaders.updateValue(defaultVertex, forKey: .basic)
            fragmentShaders.updateValue(defaultFragment, forKey: .basic)
            
            VertexDescriptorLibrary.`init`()
            RenderPipelineDescriptorLibrary.`init`()
            RenderPipelineStateLibrary.`init`()
            MeshLibrary.`init`()
        }
    }
    
    private static var vertexShaders: [VertexType: Shader] = [:]
    private static var fragmentShaders: [FragmentType: Shader] = [:]
    
    public static func vertex(_ type: VertexType) -> MTLFunction {
        return ShaderLibrary.vertexShaders[type]!.function
    }
    
    public static func fragment(_ type: FragmentType) -> MTLFunction{
        return ShaderLibrary.fragmentShaders[type]!.function
    }
}
