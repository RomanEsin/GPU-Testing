//
//  Preferences.swift
//  GPU Testing
//
//  Created by Roman Esin on 12.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

enum Preferences {
    public static var isDebug = false
    
    public static var clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    public static var colorFormat = MTLPixelFormat.bgra8Unorm
    
    public static var vertexType = VertexType.basic
    public static var fragmentType = FragmentType.basic
    public static var vertexDescriptorType = VertexDescriptorType.basic
    public static var renderPipelineDescriptorType = RenderPipelineDescriptorType.basic
    public static var renderPipelineStateType = RenderPipelineStateType.basic
}
