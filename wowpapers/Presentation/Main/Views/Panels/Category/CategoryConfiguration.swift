//
//  CategoryConfiguration.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 12/3/21.
//

import SwiftUI

struct CategoryConfiguration: View {
        
    @StateObject var vm: CategoryViewModel
    
    let closeCallback: () -> Void
    
    var body: some View {
        ConfigurationBox(name: "Category", closeCallback) {
            Spacer().frame(height: 8)
            TextField("Add new category", text: $vm.inputData, onEditingChanged: vm.onEditChanged, onCommit: vm.onCommit)
                .font(Font.system(size: 12, weight: .semibold, design: .default))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.vertical, 6)
                .padding(.horizontal, 8)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(6)
            
            Spacer()
            Button {
                print("")
            } label: {
                Text("Apply")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.primary)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(vm.isDisabled)

        }.onAppear {
            vm.updateQueries()
        }
    }
    
}
