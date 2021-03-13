//
//  Animations.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 12/3/21.
//

import SwiftUI

// Use this variable to make all animations super slow, good for debugging transitions
var debugAnimations = false

extension Animation {
    
    static var scaleDown: Animation { debugAnimations ? debug : .interactiveSpring(response: 0.6, dampingFraction: 0.75, blendDuration: 0.25) }
    
    static var scaleUp: Animation { debugAnimations ? debug : .interactiveSpring(response: 0.6, dampingFraction: 0.95, blendDuration: 0.25) }

    static var debug: Animation { .easeInOut(duration: 2.5) }

}
