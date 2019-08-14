//
//  MeshLibrary.swift
//  GPU Testing
//
//  Created by Roman Esin on 11.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

protocol Mesh {
    var vertexBuffer: MTLBuffer { get }
    var vertexCount: Int { get }
}

enum MeshType {
    case triangle
    case quad
}

class MeshLibrary {
    private static var meshes: [MeshType: Mesh] = [:]
    
    public static func mesh(_ type: MeshType) -> Mesh {
        return meshes[type]!
    }
    
    public static func `init`() {
        meshes.updateValue(TriangleMesh(), forKey: .triangle)
        meshes.updateValue(QuadMesh(), forKey: .quad)
    }
}

class TriangleMesh: Mesh {
    var vertexArray = [Vertex]()
    
    var vertexBuffer: MTLBuffer
    var vertexCount: Int {
        return vertexArray.count
    }
    
    init() {
        vertexArray =
        [
            Vertex(pos: simd_float3(0, 1.0, 0), color: simd_float4(0, 1, 0, 1)),
            Vertex(pos: simd_float3(-1.0, -1.0, 0), color: simd_float4(1, 0, 0, 1)),
            Vertex(pos: simd_float3(1.0, -1.0, 0), color: simd_float4(0, 0, 1 , 1))
        ]
        
        vertexBuffer = Engine.device.makeBuffer(bytes: vertexArray, length: MemoryLayout<Vertex>.stride * vertexArray.count, options: [])!
    }
}

class QuadMesh: Mesh {
    var vertexArray = [Vertex]()
    
    var vertexBuffer: MTLBuffer
    var vertexCount: Int {
        return vertexArray.count
    }
    
    init() {
        vertexArray =
        [
            Vertex(pos: simd_float3(-0.7, -0.7, 0), color: simd_float4(1, 0, 0, 1)), //bl
            Vertex(pos: simd_float3(-0.7, 0.7, 0),  color: simd_float4(0, 1, 0, 1)), //tl
            Vertex(pos: simd_float3(0.7, 0.7, 0),   color: simd_float4(0, 0, 1, 1)), //tr
            
            Vertex(pos: simd_float3(-0.7, -0.7, 0), color: simd_float4(1, 0, 0, 1)), //bl
            Vertex(pos: simd_float3(0.7, -0.7, 0),  color: simd_float4(1, 0, 1, 1)), //br
            Vertex(pos: simd_float3(0.7, 0.7, 0),   color: simd_float4(0, 0, 1, 1))  //tr
        ]
        
        vertexBuffer = Engine.device.makeBuffer(bytes: vertexArray, length: MemoryLayout<Vertex>.stride * vertexArray.count, options: [])!
    }
}
