//
//  FCEditShapeView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/11.
//

import Foundation
import SwiftUI
import DynamicColor


struct FCEditShapeView: View {
    
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var events: UserEvents
    
    @State var maskShapeName: String
    @State var bgImageName: String
    @State var stickerName: String
    
    
    @State var shapeList: [ShapeItem] = CFResourceModelManager.default.shapeItemList
    @State var selectionKeeper: Int = 0
    @State var isShowPurchaseView: Bool = false
    @State var isShowStickerAndBgView: Bool = false
    
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
                    shapeListView
                    Spacer()
                }
                purchaseAlertView
                    .hidden(!isShowPurchaseView)
                    .animation(.easeInOut)
            }
        }.navigationBarHidden(true)
    }
}

extension FCEditShapeView {
    
    
    
    var topBackBgView: some View {
        HStack {
            Button(action: {
                topBackClick()
            }, label: {
                Image("home_back_ic")
                    .frame(width: 44, height: 44, alignment: .center)
            })
            
            Spacer()

            NavigationLink(destination: FCEditStickerAndBgView(events: events, maskShapeName: maskShapeName, bgImageName: bgImageName, stickerName: stickerName)
                            .navigationBarHidden(true)
                           , isActive: $isShowStickerAndBgView) {
                Button(action: {
                    isShowStickerAndBgView = true
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
            Image(uiImage: events.resultImage!)
//            Image("background_big_4")
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
    
    func randomBtnClick() {
        let item = shapeList.randomElement()
        maskShapeName = item?.bigName ?? ""
        selectionKeeper = item?.id ?? 0
    }
    
}

extension FCEditShapeView {
    func changeSelection(_ index: Int) {
        // select index
        selectionKeeper = index
        maskShapeName = shapeList[index].bigName
        if shapeList[index].isPro {
            isShowPurchaseView = true
        }
    }
    
    var shapeListView: some View {
        GeometryReader { geo in
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<shapeList.count) { index in
                        FCShapeCell(rowItem: shapeList[index], selectAction: {
                            changeSelection(index)
                        }, isCurrentSelectIndex: $selectionKeeper)
                        .frame(width: 65, height: 65, alignment: .center)
                        
                        
                    }.padding(5)
                }
                .frame( height: 90, alignment: .center)
                
            }
            .frame(height: 100, alignment: .center)

            
        }
        
    }
    
}


// Action
extension FCEditShapeView {
    func topBackClick() {
        mode.dismiss()
    }
    
     
}

extension FCEditShapeView {
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


struct FCShapeCell: View {
    var rowItem: ShapeItem
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

struct FCEditShapeView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCEditShapeView(events: UserEvents(), maskShapeName: "shape_big_1", bgImageName: "background_big_3", stickerName: "sticker_big_1")
        }
    }
}
