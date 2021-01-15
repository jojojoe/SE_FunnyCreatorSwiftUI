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
    
    @EnvironmentObject var splashManager: FCSplashViewManager
    
    @State private var tabSelectIndex: Int = 0
    @State var isShow1: Bool = false
    @State var isShow2: Bool = false
    @State var isShow3: Bool = false
    
    var pageNumber = 3
    
    var body: some View {
        
        VStack {
            topContentView
            pageControlView
            bottomBtn
            Spacer()
                .frame(height: 40)
        }.background(.white)
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
//                    ForEach(enumerating: splashList) { index, item in
//                        contentSplashView(imgName: item.imgName, title: item.title, content: item.content).tag(item.id)
//                            .offset(x: 0, y: 20)
//
//                    }
                    contentSplashView(imgName: splashList[0].imgName, title: splashList[0].title, content: splashList[0].content).tag(splashList[0].id)
//                        .offset(x: 0, y: 20)
                        .scaleEffect(self.isShow1 ? 1:0.2)
                        .transition(.opacity)
                        .animation(.easeInOut)
                        .onAppear {
                            withAnimation{
                                self.isShow1 = true
                            }
                        }
                        
                    contentSplashView(imgName: splashList[1].imgName, title: splashList[1].title, content: splashList[1].content).tag(splashList[1].id)
//                        .offset(x: 0, y: 20)
                        .scaleEffect(self.isShow2 ? 1:0.2)
                        .transition(.opacity)
                        .animation(.easeInOut)
                        .onAppear {
                            withAnimation{
                                self.isShow2 = true
                            }
                        }
                      
                    contentSplashView(imgName: splashList[2].imgName, title: splashList[2].title, content: splashList[2].content).tag(splashList[2].id)
//                        .offset(x: 0, y: 20)
                        .scaleEffect(self.isShow3 ? 1:0.2)
                        .transition(.opacity)
                        .animation(.easeInOut)
                        .onAppear {
                            withAnimation{
                                self.isShow3 = true
                            }
                        }
                         
                })
            .animation(.easeInOut)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: tabSelectIndex) { (tabSelectIndex) in
                if tabSelectIndex == 0 {
                    withAnimation{
                        self.isShow1 = true
                        self.isShow2 = false
                        self.isShow3 = false
                    }
                    
                } else if tabSelectIndex == 1 {
                    withAnimation{
                        self.isShow2 = true
                        self.isShow1 = false
                        self.isShow3 = false
                    }
                } else if tabSelectIndex == 2 {
                    withAnimation{
                        self.isShow3 = true
                        self.isShow2 = false
                        self.isShow1 = false
                    }
                }
            }
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
        let item1 = SplashItem.init(id: 0, imgName: "monster_slash_1", title: "Magic Avatar Maker", content: "Choose your gender to quickly generate your own avatar, and the magical sticker is designed to prepare your own avatar.")
        let item2 = SplashItem.init(id: 1, imgName: "monster_slash_2", title: "Top QRcode Monster", content: "Enter information or links to customize unique QR code images for you.")
        let item3 = SplashItem.init(id: 2, imgName: "monster_slash_3", title: "Share to Friends", content: "Save and share your creations with your friends. Let’s enjoy it!")
        return [item1, item2, item3]
        
    }
     
    func contentSplashView(imgName: String, title: String, content: String) -> some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                    .width(geo.size.width)
                Image(imgName)
                    .resizable()
                    .frame(width: abs(geo.size.width - (80 * 2)),
                           height: abs(geo.size.width - (80 * 2)) * (257.0 / 298.0),
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
//                    .frame(height: 35)
            }
        }
        
    }

}

extension FCSplashView {
    func bottomBtnClick() {
        if tabSelectIndex == (pageNumber - 1) {
            splashManager.loadHasSplash()
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
 
class FCSplashViewManager: ObservableObject {
    
    var k_checkSpalshStatus: String = "k_checkSpalshStatus"
    
    @Published var isShowSplash: Bool
    
    static let `default` = FCSplashViewManager()
    
    init() {
        if let hasSplash = UserDefaults.standard.object(forKey: k_checkSpalshStatus) as? Bool, hasSplash == true {
            isShowSplash = true
        } else {
            isShowSplash = false
        }
    }
    
    func loadHasSplash() {
        UserDefaults.standard.setValue(true, forKey: k_checkSpalshStatus)
        isShowSplash = true
    }
    
}
