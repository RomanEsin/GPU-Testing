//
//  Engine.swift
//  GPU Testing
//
//  Created by Roman Esin on 10.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

class Engine {
    public static var commandQueue: MTLCommandQueue!
    public static var device: MTLDevice! {
        didSet {
            guard let commandQueue = device.makeCommandQueue() else {
                fatalError("Unable to create command queue.")
            }
            self.commandQueue = commandQueue
            
            let lib = device.makeDefaultLibrary()!
            ShaderLibrary.default = lib
        }
    }
}
