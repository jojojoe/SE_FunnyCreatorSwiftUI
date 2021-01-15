//
//  MainView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/6.
//

import Foundation
import SwiftUI
import DynamicColor
import SwiftUIX

extension AnyTransition {
  static var customTransition: AnyTransition {
    let transition = AnyTransition.move(edge: .bottom)
      .combined(with: .scale(scale: 0.6, anchor: .bottom))
      .combined(with: .opacity)
    return transition
  }
}


struct FCMainView: View {
    
    @EnvironmentObject var splashManager: FCSplashViewManager
    // he /*
    @EnvironmentObject var hlexManager: HLExManager
    // he */
    
    @State var isActive = false
    @State private var isShowSettingView = false
    @State var isShowCoinStore = false
    @State var isShowExploreNow = false
    @State var isShowCreator = false
    @State var isShowQRScan = false
    
    @State var isShowSplash = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    topRightBgView
                    Spacer()
                    bottomLeftBgView
                }
                .hidden(!splashManager.isShowSplash)
                VStack {
                    settingBtn
                    Spacer()
                    topTitleLabel

                    ZStack {
                        VStack {
                            Spacer()
                            contentBtnsBgView
                            Spacer()
                                .frame(width: 10, height: 18, alignment: .center)
                            scannerBtnBgView
                            Spacer()
                                .frame(width: 10, height: 18, alignment: .center)
                            storeBtnBgView
                            Spacer()
                            // he /*
                            if hlexManager.permissionStatus {
                                hlexBtn
                            }
                            
                            // he */
                            Spacer()
                        }
                    }
                }
                .hidden(!splashManager.isShowSplash)
                
                    FCSplashView()
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 80, alignment: .center)
                        
                        .environmentObject(splashManager)
                        .hidden(splashManager.isShowSplash)
            }.navigationBarHidden(true)
            
            
            .background(.white)
        }
        
        
    }
}

// he /*
extension FCMainView {
    var hlexBtn: some View {
        HStack {
            //
            Button(action: {
                hlexManager.permissionAction()
            }) {
                Image("like_btn_ic")
            }
            
        }
        .frame(width: 313 ,height: 113, alignment: .center)
    }
}
// he */


struct FCMainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FCMainView()
        }
    }
}


// Page UI
extension FCMainView {
    
    /// topRightBgView
    var topRightBgView: some View {
        HStack {
            Spacer()
            Image("home_bg_top")
                .resizable()
                .frame(width: 113,
                       height: 124,
                       alignment: .topTrailing)
        }.edgesIgnoringSafeArea(.top)
        
    }
    var bottomLeftBgView: some View {
        HStack {
            VStack {
                Spacer()
                Image("home_bg_bottom")
                    .resizable()
                    .frame(width: 113,
                           height: 124,
                           alignment: .bottomLeading)
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(height: 124,
               alignment: .bottomLeading)
        
    }
    
    /// settingBtn
    var settingBtn: some View {
        HStack {
            Spacer()
            VStack {
                Button(action: {
                    isShowSettingView = true
                }) {
                    Image("home_setting_ic")
                }
                .padding(.trailing, 0)
                .frame(width: 44,
                        height: 44,
                        alignment: .center)
//                .sheet(isPresented: $isShowSettingView, content: {
//                    FCSettingView()
//                })
                .fullScreenCover(isPresented: $isShowSettingView, content: {
                    FCSettingView()
                })
            }.frame(width: 80, height: 44, alignment: .top)
        }.frame(height: 44)
    }
    
    /// topTitleLabel
    var topTitleLabel: some View {
        HStack (alignment: .top, spacing: nil, content: {
            Spacer().frame(width: 30, height: 10, alignment: .center)
            VStack (alignment: .leading, spacing: 0, content: {
                Text("Magic creator")
                    .foregroundColor(.black)
                    .bold()
                    .font(Font.custom("Avenir-BookOblique", size: 33))
                    .fontWeight(.medium)
                    
                Text("& code scanner")
                    .foregroundColor(.black)
                    .font(Font.custom("Avenir-MediumOblique", size: 27))
                    .fontWeight(.regular)
            })
            Spacer()
        }).padding(.top, 20)
    }
    
    /// content btns
    var contentBtnsBgView: some View {
        //FCCameraTakeView ()
        //FCCreatorUserFaceTakeView
        HStack {
            Spacer()
                .frame(width: 30, height: 15, alignment: .center)
            // exploreNowBtn
            NavigationLink(destination: FCCameraTakeView()
                            , isActive: $isActive) {

                Button(action: {
                    requestExplorePhoto()
                }) {
                    contentBtnsView(bgColor: "#FFDCEC", imgName: "home_gril_ic", title1: "Explore", title2: "now")
                }.cornerRadius(5)
            }
            
            
            Spacer()
                .frame(width: 15, height: 15, alignment: .center)
             
            NavigationLink(destination: FCCreatorMenuView()
                           
                            , isActive: $isShowCreator) {

                Button(action: {
                    requestCreatorPhoto()
                    
                }) {
                    ZStack {
                        contentBtnsView(bgColor: "#C9FFEE", imgName: "home_boy_ic", title1: "Go to", title2: "Creator")
                    }
                }
                .cornerRadius(5)
            }
            
            Spacer()
                .frame(width: 30, height: 15, alignment: .center)
            
        }
        .frame(height: 106, alignment: .center)
    }
    
    var scannerBtnBgView: some View {
        
        Button(action: {
            isShowQRScan = true
        }) {
            bottomBtnsView(bgColor: "#F7F7FC", imgName: "home_code_ic", title1: "Insta code scanner")
        }.sheet(isPresented: $isShowQRScan, content: {
            QQScanViewSwiftUI()
        })
        
    }
    
    var storeBtnBgView: some View {
        Button(action: {
            storeBtnClick()
        }) {
            bottomBtnsView(bgColor: "#F7F7FC", imgName: "home_code_ic", title1: "Magic coins store")
        }
        .sheet(isPresented: $isShowCoinStore, content: {
            FCStoreView()
                .environmentObject(CoinManager.default)
                
            
        })
    }
    
}


extension FCMainView {
    
}

extension FCMainView {
    func contentBtnsView(bgColor: String, imgName: String, title1: String, title2: String) -> some View {
        ZStack {
            Color(DynamicColor(hexString: bgColor))
                .cornerRadius(8)
            ZStack {
                Color(DynamicColor(hexString: "#FFFFFF"))
                    .border(Color.black, width: 0.8, cornerRadius: 10)
                HStack {
                    VStack {
                        Spacer()
                        Image(imgName)
                            .resizable()
                            .frame(width: 85,
                                   height: 59,
                                   alignment: .topTrailing)
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    VStack {
                        Spacer().frame(width: 10, height: 10, alignment: .center)
                        VStack(alignment: .leading, spacing: nil, content: {
                            Text(title1)
                                .foregroundColor(.black)
                                .font(Font.custom("Avenir-BlackOblique", size: 16))
                            Text(title2)
                                .foregroundColor(.black)
                                .font(Font.custom("Avenir-BlackOblique", size: 16))
                        })
                         
                        Spacer()
                    }
                    Spacer().frame(width: 10, height: 10, alignment: .center)
                }
            }
            .padding(.all, 10)
        }
    }
    
    func bottomBtnsView(bgColor: String, imgName: String, title1: String) -> some View {
        HStack {
            Spacer()
                .frame(width: 30, height: 30, alignment: .center)
            ZStack {
                Color(DynamicColor(hexString: bgColor))
                    .cornerRadius(8)
                ZStack {
                    Color(DynamicColor(hexString: "#FFFFFF"))
                        .border(Color.black, width: 0.8, cornerRadius: 10)
                    HStack {
                        Spacer()
                        Image(imgName)
                            .resizable()
                            .frame(width: 28,
                                   height: 28,
                                   alignment: .topTrailing)
                        Spacer()
                            .frame(width: 24, height: 10, alignment: .center)
                        Text(title1)
                            .foregroundColor(.black)
                            .font(Font.custom("Avenir-BlackOblique", size: 16))
                        Spacer()
                    }
                }
                .padding(.all, 10)
            }
            Spacer()
                .frame(width: 30, height: 30, alignment: .center)
        }
        
        .frame(height: 106, alignment: .center)
    }
}

extension FCMainView {
    func requestExplorePhoto() {
        PrivacyAuthorizationManager.default.requestCameraPermission {
            
            self.isActive = true
        } deniedBlock: {

        }
    }
    
    func requestCreatorPhoto() {
        PrivacyAuthorizationManager.default.requestCameraPermission {
            isShowCreator = true
        } deniedBlock: {

        }
    }
    
}

/// Action
extension FCMainView {
 
    
     
    
    
    
    func storeBtnClick() {
        isShowCoinStore = true
    }
}








