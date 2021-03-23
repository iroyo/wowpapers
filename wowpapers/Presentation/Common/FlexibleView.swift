//
//  FlexibleView.swift
//  wowpapers
//
//  Created by Isaac Royo Raso on 23/3/21.
//

import SwiftUI

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    
    private let data: Data
    private let spacing: CGFloat
    private let alignment: HorizontalAlignment
    private let content: (Data.Element) -> Content
    
    @State private var width: CGFloat = 0
    
    init(_ data: Data, spacing: CGFloat = 8, alignment: HorizontalAlignment = .leading, content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: alignment, vertical: .center)) {
            Color.clear.frame(height: 1).readSize { size in
                width = size.width
            }
            
            InnerFlexibleView(
                data: data,
                width: width,
                spacing: spacing,
                alignment: alignment,
                content: content
            )
        }
    }
}

fileprivate struct InnerFlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    
    let data: Data
    let width: CGFloat
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    
    @State var elementsSize: [Data.Element: CGSize] = [:]
    
    var body : some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { rowElements in
                HStack(spacing: spacing) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .readSize { size in
                                elementsSize[element] = size
                            }
                    }
                }
            }
        }
    }
    
    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = width
        
        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: width, height: 1)]
            
            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = width
            }
            
            remainingWidth = remainingWidth - (elementSize.width + spacing)
        }
        
        return rows
    }
    
}
