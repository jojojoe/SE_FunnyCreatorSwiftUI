//
//  FCCreatorEmojiStickerEditView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/12.
//

import Foundation
import SwiftUI
import DynamicColor
 

struct FCCreatorEmojiStickerEditView: View {
    @Environment(\.presentationMode) var mode
    @State var contentIconList: [CreatorEmojiStickerItem]
    @State var isUserPhototype: Bool = false
    @State var isShowContentSelectView = false
    @State var currentEmojiImage: UIImage = UIImage()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(DynamicColor(hexString: "#F4F4FA"))
                    .ignoresSafeArea()
                VStack {
                    topBackBgView
                    
                    FCCreatorPreview(iconImage: .constant(currentEmojiImage))
                        .frame(width: geo.size.width - 30 * 2, height: geo.size.height - 80)
                        .background(.white)
                        .mask(Color(.black).frame(width: geo.size.width - 30 * 2, height: geo.size.height - 80, alignment: .center))
                        .onTapGesture {
                            isShowContentSelectView = true
                        }
                }
                
                contentSelectView
                    .hidden(!isShowContentSelectView)
            }
            
            
            
        }
        
    }
    
}

extension FCCreatorEmojiStickerEditView {
    var topBackBgView: some View {
        HStack {

            Button(action: {
                mode.dismiss()
            }, label: {
                Image("home_back_ic")
                    
                    .frame(width: 76, height: 44, alignment: .center)
            })
            Spacer()
            Button(action: {
                nextBackClick()
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
            Spacer()
                .frame(width: 10)
        }.frame(height: 44)
    }
    
    func nextBackClick() {
        
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



//struct FCEmojiCell: View {
//    var emojiItem: CreatorEmojiStickerItem
//
//    var body: some View {
//
//
//        contentView(thumbnail: emojiItem.thumbName)
//
//
//    }
//
//    func contentView(thumbnail: String) -> some View {
//        Image(thumbnail)
//    }
//    func clickAction() {
//        debugPrint("iapid = \(storeItem.iapId)")
//
//    }
//
//
//}

struct FCCreatorEmojiStickerEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCCreatorEmojiStickerEditView(contentIconList: CFResourceModelManager.default.creatorEmojiItemList)
            
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
                    Image(uiImage: iconImage)
                        .resizable()
                        .frame(width: geo.size.width / 4 - 10, height: geo.size.width / 4 - 10, alignment: .center)
                }.padding(5)
                .frame(height: geo.size.width / 4)
            })
            
        }
        
    }
    
    
}








