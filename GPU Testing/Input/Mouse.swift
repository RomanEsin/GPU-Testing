//
//  Mouse.swift
//  GPU Testing
//
//  Created by Roman Esin on 12.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

import MetalKit

enum MOUSE_BUTTON_CODES: Int {
    case LEFT = 0
    case RIGHT = 1
    case CENTER = 2
}

class Mouse {
    private static var MOUSE_BUTTON_COUNT = 12
    private static var mouseButtonList = [Bool].init(repeating: false, count: MOUSE_BUTTON_COUNT)

    private static var overallMousePosition = simd_float2(repeating: 0)
    private static var mousePositionDelta = simd_float2(repeating: 0)

    private static var scrollWheelPosition: Float = 0
    private static var lastWheelPosition: Float = 0.0

    private static var scrollWheelChange: Float = 0.0

    public static func SetMouseButtonPressed(button: Int, isOn: Bool) {
        mouseButtonList[button] = isOn
    }

    public static func IsMouseButtonPressed(button: MOUSE_BUTTON_CODES)-> Bool {
        return mouseButtonList[Int(button.rawValue)] == true
    }

    public static func SetOverallMousePosition(position: simd_float2) {
        self.overallMousePosition = position
    }

    ///Sets the delta distance the mouse had moved
    public static func SetMousePositionChange(overallPosition: simd_float2, deltaPosition: simd_float2) {
        self.overallMousePosition = overallPosition
        self.mousePositionDelta += deltaPosition
    }

    public static func ScrollMouse(deltaY: Float) {
        scrollWheelPosition += deltaY
        scrollWheelChange += deltaY
    }

    //Returns the overall position of the mouse on the current window
    public static func GetMouseWindowPosition()-> simd_float2 {
        return overallMousePosition
    }

    ///Returns the movement of the wheel since last time getDWheel() was called
    public static func GetDWheel()->Float{
        let position = scrollWheelChange
        scrollWheelChange = 0
        return position
    }

    ///Movement on the y axis since last time getDY() was called.
    public static func GetDY()->Float{
        let result = mousePositionDelta.y
        mousePositionDelta.y = 0
        return result
    }

    ///Movement on the x axis since last time getDX() was called.
    public static func GetDX()->Float{
        let result = mousePositionDelta.x
        mousePositionDelta.x = 0
        return result
    }

    //Returns the mouse position in screen-view coordinates [-1, 1]
    public static func GetMouseViewportPosition()-> simd_float2 {
        let x = (overallMousePosition.x - Renderer.screenSize.x * 0.5) / (Renderer.screenSize.x * 0.5)
        let y = (overallMousePosition.y - Renderer.screenSize.y * 0.5) / (Renderer.screenSize.y * 0.5)
        return simd_float2(x, y)
    }
}
