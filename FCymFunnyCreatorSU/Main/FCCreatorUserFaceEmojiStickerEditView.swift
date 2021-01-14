//
//  FCCreatorUserFaceEmojiStickerEditView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/14.
//

import Foundation
import SwiftUI
import DynamicColor
 


struct FCCreatorUserFaceEmojiStickerEditView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var events: UserEvents
//    @ObservedObject var creatorTakePhoto: FCCreatorTakePhoto
    @ObservedObject var creatorPhoto = FCCreatorPhoto()
    
    
    @State var contentIconList: [CreatorEmojiStickerItem]

    @State var isShowContentSelectView = false
    @State var overlayerImage: UIImage = UIImage()
    @State var isShowSaveView: Bool = false
    @State var previewRect: CGRect = .zero
    
    @State private var rect1: CGRect = .zero
    @State private var uiImage: UIImage? = nil
    @State var imageData: Data?
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(DynamicColor(hexString: "#F4F4FA"))
                    .ignoresSafeArea()
                VStack {
                    topBackBgView
                    preview
                        
                    
                }
                
                 
                VStack{
                    
                    if uiImage != nil {
                        VStack {
                            Text("Captured Image")
                            Image(uiImage: self.uiImage!).padding(20).border(Color.black)
                        }.padding(20)
                    }
                    
                }
                
            }
            
        }
        
    }
    
    var preview: some View {
        GeometryReader { geo in
            HStack {
                Spacer()
                FCCreatorPreviewUserFace(userfaceImage: $events.resultImage, overlayerImage: $overlayerImage)
                    .frame(width: previewWidth(), height: previewHeight())
                    .background(.white)
                    .mask(Color(.black).frame(width: previewWidth(), height: previewHeight()))
                    .onTapGesture {
                        if contentIconList.count >= 1 {
                            isShowContentSelectView = true
                        }
                    }
                Spacer()
            }
        }
        
        
    }
    
     
}

extension FCCreatorUserFaceEmojiStickerEditView {
    
//    func resultImage() -> UIImage {
//        let image = self.previewRect.uiImage
//        return image ?? UIImage()
//    }
    
    func previewWidth() -> CGFloat {
        UIScreen.main.bounds.width - 30 * 2
    }
    
    func previewHeight() -> CGFloat {
        UIScreen.main.bounds.height - 160
    }
    
}

extension FCCreatorUserFaceEmojiStickerEditView {
    var topBackBgView: some View {
        HStack {

            Button(action: {
                mode.dismiss()
            }, label: {
                Image("home_back_ic")
                    .frame(width: 76, height: 44, alignment: .center)
            })
            Spacer()
            NavigationLink(
                destination:
                    
                    FCCreatorSaveView(creatorPhoto: creatorPhoto)
                    .navigationBarHidden(true),
                isActive: $isShowSaveView) {
                Button(action: {
                    
                    convertViewToData(view: preview, size: .init(width: previewWidth(), height: previewHeight())) {
                        creatorPhoto.resultImage = UIImage(data: $0 ?? Data())
                        isShowSaveView = true
                    }
                }, label: {
                    ZStack {
                        Color(DynamicColor(hexString: "#FFDCEC"))
                            .cornerRadius(2)
                        ZStack {
                            Color(.white)
                                .border(Color.black, width: 1, cornerRadius: 2)
                            Text("Next")
                                .foregroundColor(.black)
                                .font(Font.custom("Avenir-BlackOblique", size: 12))
                        }.padding(2)

                    }

                }).frame(width: 76, height: 30, alignment: .center)
            }
            
            Spacer()
                .frame(width: 10)
        }.frame(height: 44)
    }
    
    func nextBackClick() {
        
    }
}
 

extension FCCreatorUserFaceEmojiStickerEditView {
     
    
    
}

 

struct FCCreatorUserFaceEmojiStickerEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCCreatorUserFaceEmojiStickerEditView(events: UserEvents(), contentIconList: [])
             
            
        }
    }
}










struct FCCreatorPreviewUserFace: View {
    @Binding var userfaceImage: UIImage?
    @Binding var overlayerImage: UIImage
    var itemPadding_h: CGFloat = 25
    var itemPadding_v: CGFloat = 5
    var body: some View {
        GeometryReader { geo in
            VStack {
                lineView
                    .frame(width: geo.size.width, height: geo.size.width / 4 + itemPadding_v)
                    .offset(x: -((geo.size.width / 4 ) / 2))
                lineView
                    .frame(width: geo.size.width, height: geo.size.width / 4 + itemPadding_v)
                    .offset(x: ((geo.size.width / 4 ) / 4))
                lineView
                    .frame(width: geo.size.width, height: geo.size.width / 4 + itemPadding_v)
                    .offset(x: -((geo.size.width / 4) / 2))
                lineView
                    .frame(width: geo.size.width, height: geo.size.width / 4 + itemPadding_v)
                    .offset(x: ((geo.size.width / 4 ) / 4))
                lineView
                    .frame(width: geo.size.width, height: geo.size.width / 4 + itemPadding_v)
                    .offset(x: -((geo.size.width / 4) / 2))
                lineView
                    .frame(width: geo.size.width, height: geo.size.width / 4 + itemPadding_v)
                    .offset(x: ((geo.size.width / 4 ) / 4))
                lineView
                    .frame(width: geo.size.width, height: geo.size.width / 4 + itemPadding_v)
                    .offset(x: -((geo.size.width / 4) / 2))
                lineView
                    .frame(width: geo.size.width, height: geo.size.width / 4 + itemPadding_v)
                    .offset(x: ((geo.size.width / 4 ) / 4))
                
            }
        }
        
        
    }
    
    
    var lineView: some View {
        GeometryReader { geo in
            HStack(alignment: .center, spacing: itemPadding_h , content: {
                ForEach(0..<4) { index in
                    //
//                    Image(uiImage: UIImage(named: "emoji_sticker_ic_1")!)
                    ZStack {
                        if userfaceImage != nil {
                            Image(uiImage: userfaceImage!)
                                .resizable()
                                .frame(width: geo.size.width / 4 - 10, height: geo.size.width / 4 - 10, alignment: .center)
                        }
                        
                        Image(uiImage: overlayerImage)
                            .resizable()
                            .frame(width: geo.size.width / 4 - 10, height: geo.size.width / 4 - 10, alignment: .center)
                    }
                    
                }.padding(5)
                .frame(height: geo.size.width / 4)
            })
            
        }
        
    }
    
    
}





