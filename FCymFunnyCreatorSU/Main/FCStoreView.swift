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

struct FCStoreView: View {
    
    @EnvironmentObject var coinManager: CoinManager
    
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
        }).frame(width: 80, height: 44, alignment: .center)
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
                StoreCell(storeItem: $0)
                    .frame(height: 106)
            }
            
        }
            
        
        
    }
    
    
    
}

extension FCStoreView {
    func backBtnClick() {
        
    }
    
    
    
    
    
    
}


struct StoreCell: View {
    var storeItem: StoreItem
    
    var body: some View {
        
        
            contentBtnsView(bgColor: storeItem.color, coin: storeItem.coin, price: storeItem.price)
        
        
    }
    
    func clickAction() {
        debugPrint("iapid = \(storeItem.iapId)")
        
    }
    
    func contentBtnsView(bgColor: String, coin: Int, price: String) -> some View {
        Button(action: {
            clickAction()
        }) {
            ZStack {
                Color(DynamicColor(hexString: bgColor))
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
                                Text("\(coin) coins")
                                    .foregroundColor(.black)
                                    .font(Font.custom("Avenir-MediumOblique", size: 18))
                                Spacer().frame(width: 10, height: 5, alignment: .center)
                                Text(price)
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
       
        
    }
    
}


struct FCStoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FCStoreView().environmentObject(CoinManager.default)
        }
    }
}
 

