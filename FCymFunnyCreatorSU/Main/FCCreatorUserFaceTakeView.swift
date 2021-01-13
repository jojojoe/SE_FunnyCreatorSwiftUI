//
//  FCCreatorUserFaceTakeView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/13.
//

import Foundation
import SwiftUI
import DynamicColor

var maskShapeNameDefault_creator: String = "shape_big_1"
var bgImageNameDefault_creator: String = "background_big_3"
var stickerNameDefault_creator: String = "sticker_big_1"


struct FCCreatorUserFaceTakeView: View {
    @Environment(\.presentationMode) var mode
    
    
    @ObservedObject var events = UserEvents()

    @State private var maskShapeName: String = maskShapeNameDefault_creator
    @State private var bgImageName: String = bgImageNameDefault_creator
    @State private var stickerName: String = stickerNameDefault_creator
    
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



extension FCCreatorUserFaceTakeView {
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

extension FCCreatorUserFaceTakeView {
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


extension FCCreatorUserFaceTakeView: CameraActions {
    
    var cameraInterfaceView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                rotateButton
                Spacer()
                captureButton
                Spacer()
                randomButton
                    
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
    
    var randomButton: some View {
        Button(action: {
            randomBtnClick()
        }, label: {
            Image("random_mask_ic")
                .resizable()
                .frame(width: 31, height: 25, alignment: .center)
                
        })
        .frame(width: 60, height: 60, alignment: .center)
    }
    
    func userPhoto() -> UIImage {
        let canvasView = UIView()
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        canvasView.frame = frame
        let bgImageView = UIImageView()
        bgImageView.frame = frame
        bgImageView.image = events.resultImage
        canvasView.addSubview(bgImageView)
        
        let overlayerView = FCMaskOverlayerUIView(frame: frame, bgImageName: bgImageName, stickerName: stickerName, maskShapeName: maskShapeName)
        
        canvasView.addSubview(overlayerView)
        
        return canvasView.screenshot ?? UIImage()
        
    }
    
//    func userPhoto() -> UIImage {
//        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
//        let canvas = UIView()
//        canvas.backgroundColor = .white
//        canvas.frame = frame
//        let userImage = c
//        let userImageView = UIImageView(image: userImage)
//        userImageView.frame = frame
//        canvas.addSubview(userImageView)
//
//        let overlayerView = FCMaskOverlayerView(maskShapeName: $maskShapeName, bgImageName: $bgImageName, stickerName: $stickerName)
//
//        let overlayerViewChild = UIHostingController(rootView: overlayerView)
//        overlayerViewChild.view.frame = frame
//        canvas.addSubview(overlayerViewChild.view)
//
//        return canvas.screenshot ?? UIImage()
//    }
    
    var captureButton: some View {
        VStack {
            
            NavigationLink(destination: FCCreatorEmojiStickerEditView(contentIconList: [], currentEmojiImage: userPhoto())
                            
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
    
    func randomBtnClick() {
        let item = CFResourceModelManager.default.stickerItemList.randomElement()
        stickerName = item?.bigName ?? ""
        
        
    }
    
    
    func captureBtnClick() {
        self.takePhoto(events: events)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            
             
        }

    }
    
}


struct FCCreatorUserFaceTakeView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCCreatorUserFaceTakeView()
        }
    }
}
 

 



