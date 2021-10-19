import Foundation
import SwiftUI

extension Image {
    static let phoneWhite: Image = Image(packageResource: "PhoneWhite", ofType: "png")
    static let phoneBlack: Image = Image(packageResource: "PhoneBlack", ofType: "png")
    static let phoneFrame: Image = Image(packageResource: "PhoneFrame", ofType: "png")
    
    init(packageResource name: String, ofType type: String) {
        #if canImport(UIKit)
        guard let path = Bundle.module.path(forResource: name, ofType: type),
              let image = UIImage(contentsOfFile: path) else {
            self.init(name)
            return
        }
        self.init(uiImage: image)
        #elseif canImport(AppKit)
        guard let path = Bundle.module.path(forResource: name, ofType: type),
              let image = NSImage(contentsOfFile: path) else {
            self.init(name)
            return
        }
        self.init(nsImage: image)
        #else
        self.init(name)
        #endif
    }
}

extension View {
    func safeAreaInset(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> some View {
        let insets = EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        return self.safeAreaInset(insets)
    }
    
    @ViewBuilder func safeAreaInset(_ insets: EdgeInsets) -> some View {
        if #available(macOS 12.0, iOS 15.0, *) {
            self
                .safeAreaInset(edge: .top, content: {
                    Spacer().frame(height: insets.top)
                })
                .safeAreaInset(edge: .leading, content: {
                    Spacer().frame(width: insets.leading)
                })
                .safeAreaInset(edge: .trailing, content: {
                    Spacer().frame(width: insets.trailing)
                })
                .safeAreaInset(edge: .bottom, content: {
                    Spacer().frame(height: insets.bottom)
                })
            
        } else {
            // does nothing on macOS 11 & below
            self
        }
    }
    
}

