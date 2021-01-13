//
//  QRMaker.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/12.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins


class QRMaker {
    func generateQRCode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return nil
    }
}





