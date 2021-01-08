//
//  SplashView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/6.
//

import Foundation
import SwiftUI
import DynamicColor
import SwiftUIX

struct SplashItem: Identifiable {
    var id: Int
    var imgName: String
    var title: String
    var content: String
    
}

struct FCSplashView: View {
    
    
    @State private var tabSelectIndex: Int = 0
    var pageNumber = 3
    
    var body: some View {
        
        VStack {
            topContentView
            pageControlView
            bottomBtn
            Spacer()
                .frame(height: 40)
        }
    }

    
    
    
}

extension FCSplashView {
    var bottomBtnTitle: String {
        if tabSelectIndex == pageNumber - 1 {
            return "Enter"
        } else {
            return "Next"
        }
    }
}

extension FCSplashView {
    
    
    var topContentView: some View {
        
        TabView(selection: $tabSelectIndex,
                content:  {
                    ForEach(enumerating: splashList) { index, item in
                        contentSplashView(imgName: item.imgName, title: item.title, content: item.content).tag(item.id)
                    }
                })
            .animation(.easeInOut)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            
    }
    
    var pageControlView: some View {
        
        PageControl(current: tabSelectIndex, numberOfPages: pageNumber, currentPageIndicatorTintColor:DynamicColor(hexString: "#6CE9B3"), pageIndicatorTintColor: UIColor.init(hexString: "#000000"))
            .frame(height: 50)
    }
    
    var bottomBtn: some View {
        Button(action: {
            bottomBtnClick()
        }, label: {
            ZStack {
                Image("splash_net_btn")
                Text(bottomBtnTitle)
                    .font(Font.custom("Avenir-Black", size: 16))
                    .foregroundColor(.white)
            }
            
        })
    }
    
}

extension FCSplashView {
    
    var splashList: [SplashItem] {
        let item1 = SplashItem.init(id: 0, imgName: "monster_slash_1", title: "Super QRCode1", content: "Welcome To The Online Best Model Winner Contest At Lookoftheyear")
        let item2 = SplashItem.init(id: 1, imgName: "monster_slash_2", title: "Super QRCode2", content: "Welcome To The Online Best Model Winner Contest At Lookoftheyear")
        let item3 = SplashItem.init(id: 2, imgName: "monster_slash_3", title: "Super QRCode3", content: "Welcome To The Online Best Model Winner Contest At Lookoftheyear")
        return [item1, item2, item3]
        
    }
     
    func contentSplashView(imgName: String, title: String, content: String) -> some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                    .width(geo.size.width)
                Image(imgName)
                    .resizable()
                    .frame(width: abs(geo.size.width - (40 * 2)),
                           height: abs(geo.size.width - (40 * 2)) * (257.0 / 298.0),
                           alignment: .center)
                Spacer()
                    .frame(height: 55)
                Text(title)
                    .font(Font.custom("Avenir-Medium", size: 24))
                    .foregroundColor(.black)
                Spacer()
                    .frame(height: 15)
                Text( content)
                    .font(Font.custom("Avenir-Medium", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(DynamicColor(hexString: "#999999")))
                    .padding(EdgeInsets(top: 10, leading: 40, bottom: 20, trailing: 40))
                    
                Spacer()
                    .frame(height: 35)
            }
        }
        
    }

}

extension FCSplashView {
    func bottomBtnClick() {
        if tabSelectIndex == (pageNumber - 1) {
            
        } else {
            tabSelectIndex += 1
        }
        
    }
    
    
}

struct FCSplashView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FCSplashView()
        }
    }
}
 

