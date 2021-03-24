//
//  CategoryViewModel.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 20/3/21.
//

import Combine
import Foundation

class CategoryViewModel: ObservableObject {
    
    private let queryRepository: QueryRepository
    private let notifyQueryCount: (Bool) -> Void
    
    @Published var inputData: String = ""
    @Published var queries: [Query] = []
    
    var isDisabled: Bool {
        queries.count == 0
    }
    
    init(queryRepository: QueryRepository, queryCallback: @escaping (Bool) -> Void) {
        self.queryRepository = queryRepository
        self.notifyQueryCount = queryCallback
    }
    
    func onEditChanged(isEditing: Bool) {
        
    }
    
    func onCommit() {
        let name = inputData.trimmingCharacters(in: .whitespaces)
        action(queryRepository.addQuery(with: name)) {
            inputData = ""
        }
    }
    
    func remove(_ query: Query) {
        action(queryRepository.remove(query: query))
    }
    
    func updateQueries() {
        queries = queryRepository.getQueries()
        print("is disabled \(isDisabled)")
        notifyQueryCount(isDisabled)
    }
    
    private func action(_ isSuccessful: Bool, onSuccess: () -> Void = {}) {
        if isSuccessful {
            onSuccess()
            updateQueries()
        }
    }
    
}
