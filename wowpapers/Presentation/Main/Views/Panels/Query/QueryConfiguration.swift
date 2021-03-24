//
//  QueryConfiguration.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 12/3/21.
//

import SwiftUI

struct QueryConfiguration: View {
     
    @State private var ready = false
    @StateObject var vm: QueryViewModel
    
    let closeCallback: () -> Void
    
    var body: some View {
        ConfigurationBox(name: "Query") {
            Spacer().frame(height: 8)
            TextField("Add new category", text: $vm.inputData, onEditingChanged: vm.onEditChanged, onCommit: vm.onCommit)
                .font(Font.system(size: 12, weight: .semibold, design: .default))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.vertical, 6)
                .padding(.horizontal, 8)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(6)
            
            if ready {
                FlexibleView(vm.queries) { data in
                    ClickableQueryChip(category: data, onClick: vm.remove)
                }
            }
            
            Spacer()

            Button {
                closeCallback()
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                ready = true
            }
        }
    }
    
}
