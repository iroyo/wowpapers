//
//  PanelMode.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 18/3/21.
//

import Foundation

enum PanelMode {
    case close(PanelType? = nil)
    case expanded(PanelType)
    
    func isClosed() -> Bool {
        switch self {
        case .close(_): return true
        default: return false
        }
    }
    
    func expandedType() -> PanelType? {
        switch self {
        case .expanded(let result): return result
        default: return nil
        }
    }
            
    func isExpanded(for type: PanelType) -> Bool {
        switch self {
        case .expanded(let result):
            if case type = result {
                return true
            } else {
                return false
            }
        default: return false
        }
    }
}
