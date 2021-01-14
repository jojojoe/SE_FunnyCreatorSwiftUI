//
//  RectGetter.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/14.
//

import Foundation
import SwiftUI

//struct RectGetter: View {
//    @Binding var rect: CGRect
//
//    var body: some View {
//        GeometryReader { proxy in
//            self.createView(proxy: proxy)
//        }
//    }
//
//    func createView(proxy: GeometryProxy) -> some View {
//        DispatchQueue.main.async {
//            self.rect = proxy.frame(in: .global)
//        }
//
//        return Rectangle().fill(Color.clear)
//    }
//}

extension CGRect {
    var uiImage: UIImage? {
        UIApplication.shared.windows
            .filter{ $0.isKeyWindow }
            .first?.rootViewController?.view
            .asImage(rect: self)
    }
}


extension View {
    func getRect(_ rect: Binding<CGRect>) -> some View {
        self.modifier(GetRect(rect: rect))
    }
}

struct GetRect: ViewModifier {

    @Binding var rect: CGRect

    var measureRect: some View {
        GeometryReader { proxy in
            Rectangle().fill(Color.clear)
                .preference(key: RectPreferenceKey.self, value:  proxy.frame(in: .global))
        }
    }

    func body(content: Content) -> some View {
        content
            .background(measureRect)
            .onPreferenceChange(RectPreferenceKey.self) { (rect) in
                if let rect = rect {
                    self.rect = rect
                }
            }

    }
}

extension GetRect {
    struct RectPreferenceKey: PreferenceKey {
        static func reduce(value: inout CGRect?, nextValue: () -> CGRect?) {
            value = nextValue()
        }

        typealias Value = CGRect?

        static var defaultValue: CGRect? = nil
    }
}

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}



