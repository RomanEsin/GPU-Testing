//
//  Player.swift
//  GPU Testing
//
//  Created by Roman Esin on 11.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

class Player: GameObject {
    init() {
        super.init(.triangle)
    }
    
    override func update(_ deltaTime: Float) {
        let pos = Mouse.GetMouseViewportPosition()
        
        self.rotation.z = -atan2(pos.x - position.x, pos.y - position.y)
        
        super.update(deltaTime)
    }
}
