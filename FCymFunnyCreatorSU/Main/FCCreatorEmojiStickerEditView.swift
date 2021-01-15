//
//  FCCreatorEmojiStickerEditView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/12.
//

import Foundation
import SwiftUI
import DynamicColor
import UIKit

class FCCreatorPhoto: ObservableObject {
    @Published public var resultImage: UIImage? = nil
}

let emojiIconWidth: CGFloat = 60
let emojiPadding: CGFloat = 20
struct FCCreatorEmojiStickerEditView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var creatorPhoto = FCCreatorPhoto()
    
    @State var contentIconList: [CreatorEmojiStickerItem]

    @State var isShowContentSelectView = false
    @State var currentEmojiImage: UIImage = UIImage()
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
                contentSelectView
                    .offset(y: isShowContentSelectView ? 0 : UIScreen.main.bounds.height)
                    .animation(.easeInOut)
                    .transition(.opacity)
                
//                contentSelectView
//                    .animation(.easeInOut)
//                    .transition(.customTransition)
//                    .hidden(!isShowContentSelectView)
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
                preivew
                    .onTapGesture {
                        if contentIconList.count >= 1 {
                            isShowContentSelectView = true
                        }
                    }
                Spacer()
            }
        }
        
        
    }
    
    var preivew: some View {
        
        FCCreatorEmojiWallpaperViewSwiftUI(canvasSize: CGSize(width: previewWidth(), height: previewHeight()) ,iconImage: currentEmojiImage , bgColor: UIColor.white , iconWidth: 60, padding: 20)
            .frame(width: previewWidth(), height: previewHeight())
            .background(.white)
            .mask(Color(.black).frame(width: previewWidth(), height: previewHeight()))
//        FCCreatorPreview(iconImage: $currentEmojiImage)
            
    }
}

extension FCCreatorEmojiStickerEditView {
    
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

extension FCCreatorEmojiStickerEditView {
    func wallpaperPreviewImage() -> UIImage  {
        let scale: CGFloat = 3
        let view = FCCreatorEmojiWallpaperView(frame: CGRect(x: 0, y: 0, width: previewWidth() * scale, height: previewHeight() * scale), iconImage: currentEmojiImage, bgImage: UIImage(), bgColor: UIColor.white, iconWidth: emojiIconWidth * scale, padding: emojiPadding * scale)
        
        return view.screenshot ?? UIImage()
    }
    
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
                    //
                    creatorPhoto.resultImage = wallpaperPreviewImage()
                    isShowSaveView = true
                    
                    
//                    FCCreatorEmojiWallpaperViewSwiftUI(canvasSize: CGSize(width: previewWidth(), height: previewHeight()) ,iconImage: currentEmojiImage , bgColor: UIColor.white , iconWidth: 60, padding: 20)
//                        .frame(width: previewWidth(), height: previewHeight())
//                        .background(.white)
//                        .mask(Color(.black).frame(width: previewWidth(), height: previewHeight()))
                    
                    
                    
//                    convertViewToData(view: preivew, size: .init(width: previewWidth(), height: previewHeight())) {
//                        creatorPhoto.resultImage = UIImage(data: $0 ?? Data())
//                        isShowSaveView = true
//                    }
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
    
     
}
 

extension FCCreatorEmojiStickerEditView {
    var contentSelectView: some View {
        
        ZStack {
            Color(.clear)
                 
            VStack {
                Button(action: {
                    isShowContentSelectView = false
                }, label: {
                    Color(.clear)
                })
                Spacer()
                ZStack {
                    RoundedCorners(color: .white, tl: 16, tr: 16, bl: 0, br: 0)
                        .shadow(color: Color(DynamicColor.black.withAlphaComponent(0.5)), radius: 10, x: 0.0, y: 0.0)
                        .edgesIgnoringSafeArea(.bottom)
                    VStack {
                        
                        btn_Close
                        iconCcontentView
                        Spacer()
                         
                    }
                }.frame(height: 375)
                
            }
        }
    }
    
    var btn_Close: some View {
        HStack {
            Spacer()
            Button(action: {
                isShowContentSelectView = false
            }, label: {
                Image("setting_close_ic")
            }).frame(width: 50, height: 50, alignment: .center)
        }
        
    }
    
    var iconCcontentView: some View {
        GeometryReader { geo in
            QGrid(contentIconList,
                  columns: Int(4),
                  vSpacing: 15,
                  hSpacing: 15,
                  vPadding: 10,
                  hPadding: 28) {
//                FCEmojiCell(emojiItem: $0)
//                    .frame(height: 60)
                emojiCell(item: $0)
                    .frame(width: 60, height: 60, alignment: .center)
                    
            }
        }
    }
    
    
    func emojiCell(item: CreatorEmojiStickerItem) -> some View {
        Button(action: {
            if let image = UIImage(named: item.bigName) {
                currentEmojiImage = image
            }
            
        }, label: {
            Image(item.thumbName)
                .resizable()
        })
    }
    
    
}

 

struct FCCreatorEmojiStickerEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCCreatorEmojiStickerEditView(contentIconList: CFResourceModelManager.default.creatorEmojiItemList, currentEmojiImage: UIImage(named: "emoji_sticker_ic_1")!)
            
        }
    }
}







struct FCCreatorPreview: View {
    @Binding var iconImage: UIImage
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
                    Image(uiImage: iconImage)
                        .resizable()
                        .frame(width: geo.size.width / 4 - 10, height: geo.size.width / 4 - 10, alignment: .center)
                }.padding(5)
                .frame(height: geo.size.width / 4)
            })
            
        }
        
    }
    
    
}








