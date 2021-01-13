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
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    topBackBgView
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    emojiBtn
                        .frame(width: geo.size.width - 30 * 2, height: 106, alignment: .center)
                    Spacer()
                        .frame(height: 10)
                    stickerBtn
                        .frame(width: geo.size.width - 30 * 2, height: 106, alignment: .center)
                    Spacer()
                        .frame(height: 10)
                    photoBtn
                        .frame(width: geo.size.width - 30 * 2, height: 106, alignment: .center)
                    Spacer()
                }
            }
            
        }
        
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
        contentBtn(icon: "emoji_madker_ic", title: "Emoji Maker", colorHex: "#FFDCEC")
            .onTapGesture {
                
            }
    }
    var stickerBtn: some View {
        contentBtn(icon: "sticker_maker_ic", title: "Sticker Maker", colorHex: "#C9FFEE")
            .onTapGesture {
                
            }
    }
    var photoBtn: some View {
        contentBtn(icon: "photo_maker_ic", title: "Photo Maker", colorHex: "#F7F7FC")
            .onTapGesture {
                
            }
        
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







