//
//  RenderPipelineStateLibrary.swift
//  GPU Testing
//
//  Created by Roman Esin on 11.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

enum RenderPipelineStateType {
    case basic
}

protocol RenderPipelineState {
    var name: String { get }
    var state: MTLRenderPipelineState { get }
}

class RenderPipelineStateLibrary {
    private static var descriptors: [RenderPipelineStateType: RenderPipelineState] = [:]
    
    public static func `init`() {
        let defaultState = DefaultRenderPipelineState()
        descriptors.updateValue(defaultState, forKey: .basic)
    }
    
    public static func state(_ type: RenderPipelineStateType) -> MTLRenderPipelineState {
        return descriptors[type]!.state
    }
}

class DefaultRenderPipelineState: RenderPipelineState {
    var name: String = "DefaultRenderPipelineState"
    var state: MTLRenderPipelineState = {
        var renderPipelineState: MTLRenderPipelineState!
        do {
            renderPipelineState = try Engine.device.makeRenderPipelineState(descriptor: RenderPipelineDescriptorLibrary.descriptor(Preferences.renderPipelineDescriptorType))
        } catch {
            print(error)
        }
        return renderPipelineState
    }()
}
