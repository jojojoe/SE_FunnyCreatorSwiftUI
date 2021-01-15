//
//  StoreView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/7.
//

import Foundation
import SwiftUI
import DynamicColor
import SwiftUIX
import ToastUI

struct FCStoreView: View {
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var coinManager: CoinManager
    
    @State var presentingToast_load = false
    
    @State var presentingToast_success = false
    @State var presentingToast_fail = false
    
    
    
    var body: some View {
        
        VStack {
            topBanner
            ccontentView
            Spacer()
        }
        
        Spacer()
        
        
    }
}


extension FCStoreView {
    var topBanner: some View {
        HStack {
            backBtn
            Spacer()
            coinView
            Spacer()
                .frame(width: 24)
        }
    }
    
    
    var backBtn: some View {
        Button(action: {
            backBtnClick()
        }, label: {
            Image("home_back_ic")
        }).frame(width: 80, height: 64, alignment: .center)
    }
    
    var coinView: some View {
        HStack {
            Image("store_coins_ic")
                .resizable()
                .frame(width: 22, height: 22, alignment: .center)
            Spacer()
                .frame(width: 2)
            Text("\(coinManager.coinCount)")
                .font((Font.custom("Avenir-Black", size: 16)))
        }
    }
    
    var ccontentView: some View {
        GeometryReader { geo in
            QGrid(coinManager.coinIpaItemList,
                  columns: Int(2),
                  vSpacing: 15,
                  hSpacing: 15,
                  vPadding: 10,
                  hPadding: 28) {
                storeCell(storeItem: $0)
                    .frame(height: 106)
            }
            
        }
            
        
        
    }
    
    
    
}

extension FCStoreView {
    func backBtnClick() {
        mode.dismiss()
    }
    
    
    
    
    
    
}


extension FCStoreView {
    func clickAction(storeItem: StoreItem) {
        presentingToast_load = true
        debugPrint("iapid = \(storeItem.iapId)")
        CoinManager.default.purchaseIapId(iap: storeItem.iapId) { (success, errorString) in
            presentingToast_load = false
            if success {
                CoinManager.default.addCoin(coin: storeItem.coin)
                presentingToast_success = true
            } else {
                presentingToast_fail = true
            }
        }
        
    }
    
    func storeCell(storeItem: StoreItem) -> some View {
        contentBtnsView(storeItem: storeItem)
    }
    
    func contentBtnsView( storeItem: StoreItem) -> some View {
        Button(action: {
            clickAction(storeItem: storeItem)
        }) {
            ZStack {
                Color(DynamicColor(hexString: storeItem.color))
                    .cornerRadius(8)
                
                ZStack {
                    Color(DynamicColor(hexString: "#FFFFFF"))
                        .border(Color.black, width: 0.8, cornerRadius: 10)
                    HStack {
                        VStack {
                            Spacer()
                            Image("store_coins_ic")
                                .resizable()
                                .frame(width: 39,
                                       height: 39,
                                       alignment: .center)
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Spacer().frame(width: 10, height: 18, alignment: .center)
                            VStack(alignment: .trailing, spacing: nil, content: {
                                Text("\(storeItem.coin) coins")
                                    .foregroundColor(.black)
                                    .font(Font.custom("Avenir-MediumOblique", size: 18))
                                Spacer().frame(width: 10, height: 5, alignment: .center)
                                Text(storeItem.price)
                                    .foregroundColor(.black)
                                    .font(Font.custom("Avenir-BlackOblique", size: 16))
                            })
                            
                            Spacer()
                        }
                        Spacer().frame(width: 20, height: 10, alignment: .center)
                    }
                }
                .padding(.all, 10)
            }
        }
        .toast(isPresented: $presentingToast_load, content: {
            ToastView("Loading...") {
                // EmptyView()
              } background: {
                // EmptyView()
              }.toastViewStyle(IndefiniteProgressToastViewStyle())
              
        })
        .alert(isPresented: $presentingToast_success, content: {
            Alert(title: Text("Success"), message: Text(""), dismissButton: .default(Text("OK")))
        })
        .alert(isPresented: $presentingToast_fail, content: {
            Alert(title: Text("Error"), message: Text(""), dismissButton: .default(Text("OK")))
        })
         
        
    }
}
//
//
//struct StoreCell: View {
//    var storeItem: StoreItem
//
//    var body: some View {
//
//
//
//
//
//    }
//
//
//
//
//
//}


struct FCStoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FCStoreView().environmentObject(CoinManager.default)
        }
    }
}
 

