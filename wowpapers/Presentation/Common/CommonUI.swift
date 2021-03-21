//
// Created by Isaac Royo Raso on 20/1/21.
//

import SwiftUI


func BasicAsyncImage(_ url: String) -> AsyncImage<ImagePlaceholder, Text> {
    AsyncImage<ImagePlaceholder, Text>(url, failure: { Text("Error") }, placeholder: { ImagePlaceholder() }) { image in
        Image(nsImage: image).resizable()
    }
}

fileprivate struct FillParent : ViewModifier {
    let aspectRatio: CGFloat

    func body(content: Content) -> some View {
        content.frame(maxWidth: .infinity)
            .aspectRatio(aspectRatio, contentMode: .fill)
            .fixedSize(horizontal: false, vertical: true)
    }

}

fileprivate struct Chip : ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.accent)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension View {

    func fillParentWith(aspectRatio: CGFloat) -> some View {
        self.modifier(FillParent(aspectRatio: aspectRatio))
    }
    
    func chip() -> some View {
        self.modifier(Chip())
    }
    
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
