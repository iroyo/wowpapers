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
            active: HeroModifier(percentage: 1),
            identity: HeroModifier(percentage: 0)
        )
    }
    

    struct HeroModifier: AnimatableModifier {
        var percentage: Double
        
        var animatableData: Double {
            get { percentage }
            set { percentage = newValue }
        }
        
        
        func body(content: Content) -> some View {
            content.opacity(1)
        }
    }


    static var invisible: AnyTransition {
        AnyTransition.modifier(
            active: InvisibleModifier(percentage: 0),
            identity: InvisibleModifier(percentage: 1)
        )
    }
    
    struct InvisibleModifier: AnimatableModifier {
        var percentage: Double
        
        var animatableData: Double {
            get { percentage }
            set { percentage = newValue }
        }
        
        
        func body(content: Content) -> some View {
            content.opacity(percentage == 1.0 ? 1 : 0)
        }
    }
}
