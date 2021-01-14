//
//  FCEditQRcodePreview.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/12.
//

import Foundation
import SwiftUI
import DynamicColor
import ActivityView

struct FCEditQRcodePreview: View {
    
    @Environment(\.presentationMode) var mode
    @State var qrImage: UIImage
    
    @State var isShowSaveResultAlert = false
    @State var isSaveSuccessStatus = false
    
    
    @State private var isPresentedShare = false
    @State private var contentPreviewViewRect: CGRect = .zero
        
    
    
    
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                Color(DynamicColor(hexString: "#F4F4FA"))
                    .ignoresSafeArea()
                VStack {
                    topBackBgView
                    contentPreviewView
                        .getRect($contentPreviewViewRect)
                        
                        .frame(width: geo.size.width, height: geo.size.width, alignment: .center)
                        .backgroundFill(.white)
                    Spacer()
                        
                    saveQRImageBtn
                    Spacer()
                    
                }
                .navigationBarHidden(true)
                .activity(
                    isPresented: $isPresentedShare,
                    items: [qrImage]
                )
            }
            
        }
        
        
    }
    
     
}

extension FCEditQRcodePreview {
    
    var topBackBgView: some View {
        HStack {
            Button(action: {
                topBackClick()
            }, label: {
                Image("home_back_ic")
                    .frame(width: 44, height: 44, alignment: .center)
            })
            
            Spacer()
            
            Button(action: {
                isPresentedShare = true
                
            }, label: {
                Image("share_ic")
                    .frame(width: 44, height: 44, alignment: .center)
                
            })
            .frame(width: 76, height: 30, alignment: .center)
            
            
            Spacer()
                .frame(width: 0)
        }.backgroundFill(Color(DynamicColor(hexString: "#F4F4FA")))
    }
    
    func topBackClick() {
        mode.dismiss()
    }
    
 

    func saveBtnClick(resultImage: UIImage) {
        if let saveImage = (resultImage.jpegData(compressionQuality: 1)) {
            WWAlbumHelper.default.savePhoto(saveImage) { (success, error) in
                isShowSaveResultAlert = true
                isSaveSuccessStatus = success
                
            }
        }
    }
    
    func generatePreviewImage() -> UIImage {
        
        
        let resultImage = self.contentPreviewViewRect.uiImage
        
        return resultImage ?? UIImage()
    }
}

extension FCEditQRcodePreview {
    var contentPreviewView: some View {
        GeometryReader { geo in
            ZStack {
                Color(.white)
                Image(uiImage: qrImage)
                    .resizable()
                    .padding(40)
                
                 
                
            }
        }
        
    }
    
    var saveQRImageBtn: some View {
        
        Button(action: {
            let resultImage = qrImage
            saveBtnClick(resultImage: resultImage)
        }, label: {
            ZStack {
                Color(DynamicColor(hexString: "#C9FFEE"))
                    .cornerRadius(8)
                ZStack {
                    Color(.white)
                        .border(Color.black, width: 1, cornerRadius: 8)
                    Text("OK")
                        .foregroundColor(.black)
                        .font(Font.custom("Avenir-BlackOblique", size: 16))
                }.padding(8)
                
            }
            
        }).frame(width: 150, height: 72, alignment: .center)
        .alert(isPresented: $isShowSaveResultAlert, content: {
            
            Alert(title: Text(isSaveSuccessStatus ? "Save Success" : "Save Error"), message: Text(""), dismissButton: .default(Text("OK")))
        })
        
        
        
    }
    
}



struct FCEditQRcodePreview_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCEditQRcodePreview(qrImage: UIImage(named: "background_ic_5")!)
            
        }
    }
}



