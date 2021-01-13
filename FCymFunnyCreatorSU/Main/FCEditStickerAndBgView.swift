//
//  FCEditStickerAndBgView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/11.
//

import Foundation
import SwiftUI
import DynamicColor
import SwifterSwift


struct FCEditStickerAndBgView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var events: UserEvents
    
    @State var maskShapeName: String
    @State var bgImageName: String
    @State var stickerName: String
    
    
    @State var stickerList: [StickerItem] = CFResourceModelManager.default.stickerItemList
    @State var selectionKeeper_sticker: Int = 0
    
    @State var bgList: [BackgroundItem] = CFResourceModelManager.default.backgroundItemList
    @State var selectionKeeper_bg: Int = 0
    
    @State var isStickerType: Bool = true
    @State var isShowPurchaseView: Bool = false
    
    var body: some View {

        GeometryReader { geo in
            ZStack {
                Color(DynamicColor(hexString: "#F4F4FA"))
                    .ignoresSafeArea()
                VStack {
                    topBackBgView
                    contentPreviewView
                        .frame(width: geo.size.width, height: geo.size.width, alignment: .center)
                        .backgroundFill(.white)
                    Spacer()
                        .frame(height: 40)
                    ZStack {
                        stickerListView
                            .hidden(!isStickerType)
                        bgListView
                            .hidden(isStickerType)
                    }
                    
                    Spacer()
                    bottomTabView
                }
                purchaseAlertView
                    .hidden(!isShowPurchaseView)
                    .animation(.easeInOut)
                
            }.navigationBarHidden(true)
        }
    }
}


extension FCEditStickerAndBgView {
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
                .frame(width: 24)
        }.backgroundFill(Color(DynamicColor(hexString: "#F4F4FA")))
    }
    
    var contentPreviewView: some View {
        GeometryReader { geo in
            ZStack {
                
                backgroundPreviewView
                
                FCMaskOverlayerView(maskShapeName: $maskShapeName, bgImageName: $bgImageName, stickerName: $stickerName)
                randomBtn
            }
        }
    }
    
    var backgroundPreviewView: some View {
        GeometryReader { geo in
//            Image(uiImage: events.resultImage!)
            Image("background_big_4")
                .resizable()
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
    
    var randomBtn: some View {
        
        HStack {
            Spacer()
            VStack {
                Spacer()
                Button {
                    randomBtnClick()
                } label: {
                    Image("random_sticker_ic")
                        .resizable()
                }.frame(width: 44, height: 44, alignment: .center)
                .padding(.trailing, 10)
                .padding(.bottom, 10)
            }
        }
    }
    
    var bottomTabView: some View {
        HStack {
            Spacer()
            bottomTabBtn_sticker
                .onTapGesture {
                    stickerTapBtnClick()
                }
            Spacer()
            bottomTabBtn_bg
                .onTapGesture {
                    bgTapBtnClick()
                }
            Spacer()
        }
    }

    var bottomTabBtn_sticker: some View {
        VStack {
            Spacer()
                .frame(height: 8)
            ZStack {
                Image("edit_sticker_ic")
                    .frame(width: 20, height: 20, alignment: .center)
                    .hidden(isStickerType)
                Image("edit_sticker_select_ic")
                    .frame(width: 20, height: 20, alignment: .center)
                    .hidden(!isStickerType)
            }
            Spacer()
                .frame(height: 8)
             
            Color(DynamicColor(hexString: "#FF84B5"))
                .frame(width: 48, height: 4, alignment: .center)
                .hidden(!isStickerType)
                .cornerRadius(1)
            Spacer()
                .frame(height: 8)
        }.frame(width: 48, height: 48, alignment: .center)
    }
    
    var bottomTabBtn_bg: some View {
        VStack {
            Spacer()
                .frame(height: 8)
            ZStack {
                Image("edit_background_ic")
                    .frame(width: 20, height: 20, alignment: .center)
                    .hidden(!isStickerType)
                Image("edit_background_select_ic")
                    .frame(width: 20, height: 20, alignment: .center)
                    .hidden(isStickerType)
            }
            Spacer()
                .frame(height: 8)
             
            Color(DynamicColor(hexString: "#6DD6B4"))
                .frame(width: 48, height: 4, alignment: .center)
                .hidden(isStickerType)
                .cornerRadius(1)
            Spacer()
                .frame(height: 8)
        }.frame(width: 48, height: 48, alignment: .center)
    }
    
}

extension FCEditStickerAndBgView {
    // purchase alert view
    var purchaseAlertView: some View {
        
        ZStack {
            Color(.clear)
            VStack {
                Spacer()
                ZStack {
                    RoundedCorners(color: .white, tl: 16, tr: 16, bl: 0, br: 0)
                        .shadow(color: Color(DynamicColor.black.withAlphaComponent(0.5)), radius: 10, x: 0.0, y: 0.0)
                        .edgesIgnoringSafeArea(.bottom)
                    VStack {
                        
                        purchaseAlertBtn_Close
                        Image("store_coins_ic")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                        Spacer(minLength: 20)
                        Text("Because you are using a paid item, 50coins will be charged when saving")
                            .multilineTextAlignment(.center)
                            .font(Font.custom("Avenir-Medium", size: 14))
                            .frame(width: 300)
                        Spacer(minLength: 34)
                        purchaseAlertBtn_Ok
                        Spacer()
                    }
                }.frame(height: 375)
                
            }
        }
    }
    
    var purchaseAlertBtn_Close: some View {
        HStack {
            Spacer()
            Button(action: {
                isShowPurchaseView = false
            }, label: {
                Image("setting_close_ic")
            }).frame(width: 50, height: 50, alignment: .center)
        }
        
    }
    
    var purchaseAlertBtn_Ok: some View {
        Button(action: {
            isShowPurchaseView = false
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
            
        }).frame(width: 150, height: 54, alignment: .center)
        
    }
}

// Action
extension FCEditStickerAndBgView {
    func topBackClick() {
        mode.dismiss()
    }
    
    func nextBackClick() {
        
    }
    
    func randomBtnClick() {
        if (isStickerType) {
            // sticker
            let item = stickerList.randomElement()
            stickerName = item?.bigName ?? ""
            selectionKeeper_sticker = item?.id ?? 0
            isShowPurchaseView = item?.isPro == true
        } else {
            // bg
            let item = bgList.randomElement()
            bgImageName = item?.bigName ?? ""
            selectionKeeper_bg = item?.id ?? 0
            isShowPurchaseView = item?.isPro == true
        }
    }
    
    func stickerTapBtnClick() {
        isStickerType = true
    }
    
    func bgTapBtnClick() {
        isStickerType = false
    }
    
    
    
}


// Sticker List
extension FCEditStickerAndBgView {
    func changeSelection_sticker(_ index: Int) {
        // select index
//        stickerList[]
        stickerName = stickerList[index].bigName
        selectionKeeper_sticker = index
        isShowPurchaseView = stickerList[safe: index]?.isPro == true
    }
    
    var stickerListView: some View {
        GeometryReader { geo in
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<stickerList.count) { index in
                        FCStickerCell(rowItem: stickerList[index], selectAction: {
                            changeSelection_sticker(index)
                        }, isCurrentSelectIndex: $selectionKeeper_sticker)
                        .frame(width: 65, height: 65, alignment: .center)
                        
                        
                    }.padding(5)
                }
                .frame( height: 90, alignment: .center)
                
            }
            .frame(height: 100, alignment: .center)
        }
    }
}

struct FCStickerCell: View {
    var rowItem: StickerItem
    var selectAction: () -> Void
    @Binding var isCurrentSelectIndex: Int
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(.white)
                    .cornerRadius(5)
                Color(.clear)
                    .border(Color.black, width: 1, cornerRadius: 5)
                    .hidden(isCurrentSelectIndex != rowItem.id)
                Image(rowItem.thumbName)
                    .resizable()
                    .padding(10)
                    .onTapGesture {
                        selectAction()
                    }
                HStack {
                    Spacer()
                    VStack {
                        Image("pro_ic")
                            .frame(width: 20, height: 20, alignment: .center)
                            .padding(.trailing, -10)
                            .padding(.top, -10)
                            .hidden(!rowItem.isPro)
                        Spacer()
                    }
                }
                
            }
        }
    }
}



// Bg List
extension FCEditStickerAndBgView {
    func changeSelection_bg(_ index: Int) {
        // select index
        bgImageName = bgList[safe: index]?.bigName ?? ""
        selectionKeeper_bg = index
        
        isShowPurchaseView = bgList[safe: index]?.isPro == true
    }
    
    var bgListView: some View {
        GeometryReader { geo in
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<bgList.count) { index in
                        FCBgCell(rowItem: bgList[index], selectAction: {
                            changeSelection_bg(index)
                        }, isCurrentSelectIndex: $selectionKeeper_bg)
                        .frame(width: 65, height: 65, alignment: .center)
                        
                    }.padding(5)
                }
                .frame( height: 90, alignment: .center)
                
            }
            .frame(height: 100, alignment: .center)
        }
    }
}

struct FCBgCell: View {
    var rowItem: BackgroundItem
    var selectAction: () -> Void
    @Binding var isCurrentSelectIndex: Int
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(.white)
                    .cornerRadius(5)
                Color(.clear)
                    .border(Color.black, width: 1, cornerRadius: 5)
                    .hidden(isCurrentSelectIndex != rowItem.id)
                Image(rowItem.thumbName)
                    .resizable()
                    .padding(10)
                    .onTapGesture {
                        selectAction()
                    }
                HStack {
                    Spacer()
                    VStack {
                        Image("pro_ic")
                            .frame(width: 20, height: 20, alignment: .center)
                            .padding(.trailing, -10)
                            .padding(.top, -10)
                            .hidden(!rowItem.isPro)
                        Spacer()
                    }
                }
                
            }
        }
    }
    
    
}



struct FCEditStickerAndBgView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCEditStickerAndBgView(events: UserEvents(), maskShapeName: "shape_big_1", bgImageName: "background_big_3", stickerName: "sticker_big_1")
        }
    }
}



