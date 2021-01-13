//
//  ContentView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/5.
//

import SwiftUI

struct ContentView: View {
    @State var isActive = false
    
    var body: some View {
//        FCMainView()
        
        FCCreatorSaveView()
        
//        FCCreatorEmojiStickerEditView( contentIconList: CFResourceModelManager.default.creatorEmojiItemList)
        
        
//        FCEditQRcodePreview(qrImage: UIImage(named: "background_ic_5")!, contentImage: UIImage(named: "background_ic_4")!)
//
//        FCEditSaveView(resultImage: UIImage(named: "background_ic_5")!)
        
//        FCEditStickerAndBgView(events: UserEvents(), maskShapeName: "shape_big_1", bgImageName: "background_big_3", stickerName: "sticker_big_1")
        
//        ForEach(0..<CFResourceModelManager.default.shapeItemList.count) { index in
//            HStack {
//                FCShapeCell(rowItem: CFResourceModelManager.default.shapeItemList.first!, selectAction: {
//
//                }, isCurrentSelectIndex: .constant(0))
//                .frame(width: 65, height: 65, alignment: .center)
//            }
//            .frame(width: 315, height: 100, alignment: .center)
//
//        }
        
        
        
        
        
        
//        FCStoreView().environmentObject(CoinManager.default)
//        FCCameraTakeView()
        
//        SidebarView(selectionKeeper: 2)
        
//        NavigationView {
//            VStack {
//                NavigationLink(destination: FCCameraTakeView()
//                                , isActive: $isActive) {
//
//                    Button {
//                        request()
//                    } label: {
//                        Text("跳转")
//                    }
//                }
//            }
//        }
         
    }
    
    func request() {
        PrivacyAuthorizationManager.default.requestCameraPermission {
            
            self.isActive = true
        } deniedBlock: {

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
