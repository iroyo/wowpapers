//
//  Transitions.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 12/3/21.
//

import SwiftUI

extension AnyTransition {
    
    static var hero: AnyTransition {
        AnyTransition.modifier(
            active: HeroModifier(pct: 0),
            identity: HeroModifier(pct: 1)
        )
    }
    

    struct HeroModifier: AnimatableModifier {
        var pct: Double
        
        var animatableData: Double {
            get { pct }
            set { pct = newValue }
        }
        
        
        func body(content: Content) -> some View {
            content.opacity(1)
        }
    }
    
    
    static var invisible: AnyTransition {
        AnyTransition.modifier(
            active: InvisibleModifier(pct: 0),
            identity: InvisibleModifier(pct: 1)
        )
    }
    

    struct InvisibleModifier: AnimatableModifier {
        var pct: Double
        
        var animatableData: Double {
            get { pct }
            set { pct = newValue }
        }
        
        
        func body(content: Content) -> some View {
            content.opacity(pct == 1 ? 1 : 0)
        }
    }
}
