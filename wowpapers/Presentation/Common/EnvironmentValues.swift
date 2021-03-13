//
//  EnvironmentValues.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 12/3/21.
//

import SwiftUI

extension EnvironmentValues {

    var modalTransitionPercent: CGFloat {
        get { return self[ModalTransitionKey.self] }
        set { self[ModalTransitionKey.self] = newValue }
    }
}

public struct ModalTransitionKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 0
}
