//
//  GameView.swift
//  GPU Testing
//
//  Created by Roman Esin on 09.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

struct Vertex {
    var pos: simd_float3
    var color: simd_float4
}

class GameView: MTKView {
    
    var renderer: Renderer!
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        window?.acceptsMouseMovedEvents = true
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        Engine.device = device!
        self.clearColor = Preferences.clearColor
        
        self.colorPixelFormat = Preferences.colorFormat
        
        renderer = Renderer()
        delegate = renderer
    }
    
    override var acceptsFirstResponder: Bool { return true }
    
    override func keyDown(with event: NSEvent) {
        Keyboard.SetKeyPressed(event.keyCode, isOn: true)
    }
    
    override func keyUp(with event: NSEvent) {
        Keyboard.SetKeyPressed(event.keyCode, isOn: false)
    }
    
    override func mouseDown(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    override func mouseUp(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    override func rightMouseDown(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    override func rightMouseUp(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    override func otherMouseDown(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    override func otherMouseUp(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    override func mouseMoved(with event: NSEvent) {
        setupMousePositionChanged(event: event)
    }
    
    override func mouseDragged(with event: NSEvent) {
        setupMousePositionChanged(event: event)
    }
    
    override func rightMouseDragged(with event: NSEvent) {
        setupMousePositionChanged(event: event)
    }
    
    override func otherMouseDragged(with event: NSEvent) {
        setupMousePositionChanged(event: event)
    }
    
    override func scrollWheel(with event: NSEvent) {
        Mouse.ScrollMouse(deltaY: Float(event.deltaY))
    }
    
    func setupMousePositionChanged(event: NSEvent) {
        let overallLocation = simd_float2(Float(event.locationInWindow.x),
                                          Float(event.locationInWindow.y))
        let delta = simd_float2(Float(event.deltaX),
                                Float(event.deltaY))
        Mouse.SetMousePositionChange(overallPosition: overallLocation, deltaPosition: delta)
    }
    
    func setTrackingArea() {
        let area = NSTrackingArea(rect: self.bounds, options: [.activeAlways, .mouseMoved, .enabledDuringMouseDrag], owner: self, userInfo: nil)
        self.addTrackingArea(area)
    }
}
