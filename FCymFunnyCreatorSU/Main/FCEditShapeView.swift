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
                .navigationBarHidden(true)
            }
        }
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
    
    func nextBackClick() {
        
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
