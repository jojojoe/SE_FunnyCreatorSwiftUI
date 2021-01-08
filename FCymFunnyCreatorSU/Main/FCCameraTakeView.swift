//
//  FCCameraTakeView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/8.
//

import Foundation
import SwiftUI
import DynamicColor


struct FCCameraTakeView: View {
    @Environment(\.presentationMode) var mode
    
    
    @ObservedObject var events = UserEvents()

    @State private var maskShapeName: String = "shape_big_1"
    @State private var bgImageName: String = "background_big_3"
    @State private var stickerName: String = "sticker_big_1"
    
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
                    CameraInterfaceView(events: events)
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
                
//                FCMaskOverlayerView(maskShapeName: $maskShapeName, bgImageName: $bgImageName, stickerName: $stickerName)
                
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
//
    
    
    
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

struct CameraInterfaceView: View, CameraActions {
    @ObservedObject var events: UserEvents
    
    var body: some View {
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
}

extension CameraInterfaceView {
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
            
            NavigationLink(destination: EditCotnentView(events: events)
                            .frame(height: 400)
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            
             
        }
        
        
        
        
    }
    
    
    
}




struct EditCotnentView: View {
    @ObservedObject var events: UserEvents
    var body: some View {
        GeometryReader { geo in
            VStack {
                
                if events.resultImage != nil {
                    Spacer()
                        .frame(height: 100)
                    Image(uiImage: events.resultImage!)
                        .resizable()
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .background(.orange)
                    Spacer()
                        .frame(height: 100)
                }
                
            }
        }
        
    }
}
