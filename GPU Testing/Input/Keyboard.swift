//
//  Keyboard.swift
//  GPU Testing
//
//  Created by Roman Esin on 12.08.2019.
//  Copyright © 2019 Mariya Esina. All rights reserved.
//

class Keyboard {

    private static var KEY_COUNT: Int = 256
    private static var keys = [Bool].init(repeating: false, count: KEY_COUNT)
    
    public static func SetKeyPressed(_ keyCode: UInt16, isOn: Bool) {
        keys[Int(keyCode)] = isOn
    }

    public static func IsKeyPressed(_ keyCode: Keycode)->Bool{
        return keys[Int(keyCode.rawValue)]
    }

}
