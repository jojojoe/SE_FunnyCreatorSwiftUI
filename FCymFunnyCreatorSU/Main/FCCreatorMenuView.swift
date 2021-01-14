//
//  FCCreatorMenuView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/12.
//

import Foundation
import SwiftUI
import DynamicColor


struct FCCreatorMenuView: View {
    @Environment(\.presentationMode) var mode
    
    @State var emojiList: [CreatorEmojiStickerItem] = []
    @State var isShowWallpaperView_emoji: Bool = false
    @State var isShowWallpaperView_sticker: Bool = false
    @State var isShowUserPhotoTakeView: Bool = false
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    VStack {
                        topBackBgView
                        Spacer()
                    }
    //
                    VStack {
                        Spacer()
                        emojiBtn
                            .frame(width: 314, height: 106, alignment: .center)
                        Spacer()
                            .frame(height: 10)
                        stickerBtn
                            .frame(width: 314, height: 106, alignment: .center)
                        Spacer()
                            .frame(height: 10)
                        photoBtn
                            .frame(width: 314, height: 106, alignment: .center)
                        Spacer()
                    }
                }
                
            }.navigationBarHidden(true)
        } .navigationBarHidden(true)
        
        
    }
    
}

extension FCCreatorMenuView {
    var topBackBgView: some View {
        HStack {
            Spacer()
            Button(action: {
                mode.dismiss()
            }, label: {
                Image("setting_close_ic")
                    .frame(width: 76, height: 44, alignment: .center)
            })
        }.frame(height: 44)
    }
}

extension FCCreatorMenuView {
    
    var emojiBtn: some View {
        NavigationLink(destination: FCCreatorEmojiStickerEditView(contentIconList: CFResourceModelManager.default.creatorEmojiItemList, currentEmojiImage: UIImage(named: "emoji_sticker_ic_1")!)
                        .navigationBarHidden(true)
                       , isActive: $isShowWallpaperView_emoji) {
            contentBtn(icon: "emoji_madker_ic", title: "Emoji Maker", colorHex: "#FFDCEC")
                .onTapGesture {
                    isShowWallpaperView_emoji = true
                }
        }
        
    }
    var stickerBtn: some View {
        
        NavigationLink(destination: FCCreatorEmojiStickerEditView(contentIconList: CFResourceModelManager.default.creatorStickerItemList, currentEmojiImage: UIImage(named: "wall_sticker_ic_1")!)
                        .navigationBarHidden(true)
                       , isActive: $isShowWallpaperView_sticker) {
            contentBtn(icon: "sticker_maker_ic", title: "Sticker Maker", colorHex: "#C9FFEE")
                .onTapGesture {
                    isShowWallpaperView_sticker = true
                }
        }
    }
    var photoBtn: some View {
        //FCCameraTakeView()
        NavigationLink(destination: FCCreatorUserFaceTakeView()
                        , isActive: $isShowUserPhotoTakeView) {

            Button(action: {
                isShowUserPhotoTakeView = true
            }) {
                contentBtn(icon: "photo_maker_ic", title: "Photo Maker", colorHex: "#F7F7FC")
            }.cornerRadius(5)
        }
        
//        NavigationLink(destination: FCCreatorUserFaceTakeView()
//                        .navigationBarHidden(true)
//                       , isActive: $isShowUserPhotoTakeView) {
//            Button(action: {
//                isShowUserPhotoTakeView = true
//            }, label: {
//                contentBtn(icon: "photo_maker_ic", title: "Photo Maker", colorHex: "#F7F7FC")
//            })
//            
//                 
//        }
        
        
        
    }
    
    
    
    func contentBtn(icon: String, title: String, colorHex: String) -> some View {
        ZStack {
            Color(DynamicColor(hexString: colorHex))
                .cornerRadius(8)
            ZStack {
                Color(.white)
                    .border(Color.black, width: 1, cornerRadius: 8)
                HStack {
                    Spacer()
                        .frame(width: 38)
                    Image(icon)
                    Spacer()
                        .frame(width: 24)
                    Text(title)
                        .foregroundColor(.black)
                        .font(Font.custom("Avenir-BlackOblique", size: 18))
                    Spacer()
                }
                
            }.padding(8)
            
        }
        
         
        
    }
    
    
    
}








struct FCCreatorMenuView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCCreatorMenuView()
            
        }
    }
}







