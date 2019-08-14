//
//  Matrices.swift
//  GPU Testing
//
//  Created by Roman Esin on 12.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

extension simd_float4x4 {
    mutating func translate(_ direction: simd_float3) {
        var result = matrix_identity_float4x4
        
        result.columns.3 = simd_float4(direction, 1)
        
        self *= result
    }
    
    mutating func scale(_ size: simd_float3) {
        var result = matrix_identity_float4x4
        
        result.columns.0.x = size.x
        result.columns.1.y = size.y
        result.columns.2.z = size.z
        
        self *= result
    }
    
    mutating func rotate(_ angle: Float, _ axis: simd_float3) {
        var result = matrix_identity_float4x4
        
        let x = axis.x
        let y = axis.y
        let z = axis.z
        
        let c = cos(angle)
        let s = sin(angle)
        
        let mc = 1 - c
        
        let c1r1: Float = x * x * mc + c
        let c1r2: Float = x * y * mc + z * s
        let c1r3: Float = x * z * mc - y * s
        let c1r4: Float = 0.0
        
        let c2r1: Float = y * x * mc - z * s
        let c2r2: Float = y * y * mc + c
        let c2r3: Float = y * z * mc + x * s
        let c2r4: Float = 0.0
        
        let c3r1: Float = z * x * mc + y * s
        let c3r2: Float = z * y * mc - x * s
        let c3r3: Float = z * z * mc + c
        let c3r4: Float = 0.0
        
        let c4r1: Float = 0.0
        let c4r2: Float = 0.0
        let c4r3: Float = 0.0
        let c4r4: Float = 1.0
        
        result.columns = (
            simd_float4(c1r1, c1r2, c1r3, c1r4),
            simd_float4(c2r1, c2r2, c2r3, c2r4),
            simd_float4(c3r1, c3r2, c3r3, c3r4),
            simd_float4(c4r1, c4r2, c4r3, c4r4)
        )
        
        self *= result
    }
}
