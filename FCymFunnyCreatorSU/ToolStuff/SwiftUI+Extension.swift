//
//  SwiftUI+Extension.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/12.
//

import Foundation
import SwiftUI


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

extension UIView {
    func uiviewAsImage() -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        return UIGraphicsImageRenderer(size: self.layer.frame.size, format: format).image { context in
            self.drawHierarchy(in: self.layer.bounds, afterScreenUpdates: true)
//            layer.render(in: context.cgContext)

        }
    }
}


extension View {
    func viewAsImage(size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: self)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        //UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        let image = controller.view.uiviewAsImage()
        //controller.view.removeFromSuperview()
        return image
    }
}
