//
//  ViewModelFactory.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 21/3/21.
//

import SwiftUI

struct ViewModelFactory {
    
    private let di: DependencyProvider
    
    init(di: DependencyProvider) {
        self.di = di
    }

    func get() -> MainViewModel {
        MainViewModel(
            di.queryRepository.hasQueries(),
            photoProvider: di.photoProvider,
            queryProvider: di.queryProvider,
            wallpaperProvider: di.wallpaperProvider
        )
    }
    
    func get(queryCallback: @escaping (Bool) -> Void) -> QueryViewModel {
        QueryViewModel(queryRepository: di.queryRepository, queryCallback: queryCallback)
    }
}

extension ViewModelFactory : EnvironmentKey {
    
    typealias Value = ViewModelFactory
    
    static var defaultValue = ViewModelFactory(di: DependencyProvider(context: PersistenceController.shared.container.viewContext))
    
}

extension EnvironmentValues {
    var factory: ViewModelFactory {
        get { self[ViewModelFactory.self] }
        set { self[ViewModelFactory.self] = newValue }
    }
}

