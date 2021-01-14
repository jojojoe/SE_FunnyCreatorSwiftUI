//
//  FCCameraTakeView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/8.
//

import Foundation
import SwiftUI
import DynamicColor

var maskShapeNameDefault: String = "shape_big_1"
var bgImageNameDefault: String = "background_big_1"
var stickerNameDefault: String = "sticker_big_1"


struct FCCameraTakeView: View {
    @Environment(\.presentationMode) var mode
    
    
    @ObservedObject var events = UserEvents()

    @State private var maskShapeName: String = maskShapeNameDefault
    @State private var bgImageName: String = bgImageNameDefault
    @State private var stickerName: String = stickerNameDefault
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                Color(DynamicColor(hexString: "#F4F4FA"))
                    .ignoresSafeArea()
                VStack {
                    topBackBgView
                    cameraPreviewView
                        .frame(width: geo.size.width, height: geo.size.width, alignment: .center)
                        .backgroundFill(.white)
                    cameraInterfaceView
                }
                .navigationBarHidden(true)
            }
        }
        
    }
}



extension FCCameraTakeView {
    var topBackBgView: some View {
        HStack {
            Button(action: {
                topBackClick()
            }, label: {
                Image("home_back_ic")
                    .frame(width: 44, height: 44, alignment: .center)
            })
            
            Spacer()
        }.backgroundFill(Color(DynamicColor(hexString: "#F4F4FA")))
    }
    
    func topBackClick() {
        mode.dismiss()
    }
    
    
    
}

extension FCCameraTakeView {
    var cameraPreviewView: some View {
        GeometryReader { geo in
            ZStack {
                //
                CameraView(events: events, applicationName: "SwiftUICam", canvasSize: CGSize.init(width: geo.size.width, height: geo.size.height))
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
//                backgroundPreviewView
                
                FCMaskOverlayerView(maskShapeName: $maskShapeName, bgImageName: $bgImageName, stickerName: $stickerName)
                
            }
        }
        
        
    }
    
    var backgroundPreviewView: some View {
        GeometryReader { geo in
            Image("background_big_4")
                .resizable()
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
    
}


extension FCCameraTakeView: CameraActions {
    
    var cameraInterfaceView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                rotateButton
                    .hidden(true)
                Spacer()
                captureButton
                Spacer()
                rotateButton
                    
                Spacer()
            }
            Spacer()
        }.backgroundFill(Color(DynamicColor(hexString: "#F4F4FA")))

    }
    
    var rotateButton: some View {
        Button(action: {
            rotateBtnClick()
        }, label: {
            Image("camera_flip_ic")
                .resizable()
                .frame(width: 31, height: 25, alignment: .center)
                
        })
        .frame(width: 60, height: 60, alignment: .center)
    }
    
    var captureButton: some View {
        VStack {
            
            NavigationLink(destination: FCEditShapeView(events: events, maskShapeName: maskShapeName, bgImageName: bgImageName, stickerName: stickerName)
                            .navigationBarHidden(true)
                           , isActive: $events.didTakeCapturePhoto) {

                Button(action: {
                    
                    captureBtnClick()
                }, label: {
                    Image("take_photo_ic")
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                        
                })
                .frame(width: 60, height: 60, alignment: .center)
            }
        }
        
        
    }
    
   
    
    func rotateBtnClick() {
        self.rotateCamera(events: events)
    }
    
    func captureBtnClick() {
        self.takePhoto(events: events)
         

    }
    
}


struct FCCameraTakeView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCCameraTakeView()
        }
    }
}
 

struct FCMaskOverlayerView: View {
    @Binding var maskShapeName: String
    @Binding var bgImageName: String
    @Binding var stickerName: String
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(bgImageName)
                    .resizable()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .mask(Image(maskShapeName)
                            .resizable()
                            .frame(width: geo.size.width, height: geo.size.height, alignment: .center))
                Image(stickerName)
                    .resizable()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    
            }
        }
        
        
    }
}

class FCMaskOverlayerUIView: UIView {
    var maskShapeName: String
    var bgImageName: String
    var stickerName: String
    
    init(frame: CGRect, bgImageName: String, stickerName: String, maskShapeName: String) {
        self.maskShapeName = maskShapeName
        self.bgImageName = bgImageName
        self.stickerName = stickerName
        
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    func setupView() {
        self.backgroundColor = .clear
        
        let bgImageView = UIImageView()
        bgImageView.frame = self.bounds
        bgImageView.image = UIImage(named: bgImageName)
        self.addSubview(bgImageView)
        
        let maskShapeImageView = UIImageView()
        maskShapeImageView.frame = self.bounds
        maskShapeImageView.image = UIImage(named: maskShapeName)
        bgImageView.mask = maskShapeImageView
        
        let stickerImageView = UIImageView()
        stickerImageView.frame = self.bounds
        stickerImageView.image = UIImage(named: stickerName)
        self.addSubview(stickerImageView)
        
    }
    
}









//struct CameraInterfaceView: View, CameraActions {
//    @ObservedObject var events: UserEvents
//
//    @State private var maskShapeName: String = maskShapeNameDefault
//    @State private var bgImageName: String = bgImageNameDefault
//    @State private var stickerName: String = stickerNameDefault
//
//    var body: some View {
//        VStack {
//            Spacer()
//            HStack {
//                Spacer()
//                rotateButton
//                    .hidden(true)
//                Spacer()
//                captureButton
//                Spacer()
//                rotateButton
//
//                Spacer()
//            }
//            Spacer()
//        }.backgroundFill(Color(DynamicColor(hexString: "#F4F4FA")))
//
//    }
//}
//
//extension CameraInterfaceView {
//
//
//
//
//}




