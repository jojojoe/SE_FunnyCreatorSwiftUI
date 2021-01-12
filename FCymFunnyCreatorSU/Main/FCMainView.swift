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

struct FCMainView: View {
    
    @State var isActive = false
    
    
    var body: some View {
        ZStack {
            VStack {
                topRightBgView
                Spacer()
                bottomLeftBgView
            }
            VStack {
                settingBtn
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
                    }
                }
            }
        }
    }
}

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
                    settingBtnClick()
                }) {
                    Image("home_setting_ic")
                }
                .padding(.trailing, 0)
                .frame(width: 44,
                        height: 44,
                        alignment: .center)
            }.frame(width: 80, height: 44, alignment: .top)
        }
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
        HStack {
            Spacer()
                .frame(width: 30, height: 15, alignment: .center)
            // exploreNowBtn
            Button(action: {
                exploreNowBtnClick()
            }) {
                contentBtnsView(bgColor: "#FFDCEC", imgName: "home_gril_ic", title1: "Explore", title2: "now")
            }
            
            Spacer()
                .frame(width: 15, height: 15, alignment: .center)
            
            // creatorBtn
            Button(action: {
                creatorBtnClick()
            }) {
                ZStack {
                    contentBtnsView(bgColor: "#C9FFEE", imgName: "home_boy_ic", title1: "Go to", title2: "Creator")
                }
            }
            .cornerRadius(5)
            Spacer()
                .frame(width: 30, height: 15, alignment: .center)
            
        }
        .frame(height: 106, alignment: .center)
    }
    
    var scannerBtnBgView: some View {
        Button(action: {
            scannerBtnClick()
        }) {
            bottomBtnsView(bgColor: "#F7F7FC", imgName: "home_code_ic", title1: "Insta code scanner")
        }
    }
    
    var storeBtnBgView: some View {
        Button(action: {
            scannerBtnClick()
        }) {
            bottomBtnsView(bgColor: "#F7F7FC", imgName: "home_code_ic", title1: "Magic coins store")
        }
    }
    
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
    func request() {
        PrivacyAuthorizationManager.default.requestCameraPermission {
            
            self.isActive = true
        } deniedBlock: {

        }
    }
    
}

/// Action
extension FCMainView {
    func settingBtnClick() {
        debugPrint("TapSetting")
    }
    
    func exploreNowBtnClick() {
        NavigationView {
            VStack {
                NavigationLink(destination: FCCameraTakeView()
                                , isActive: $isActive) {

                    Button {
                        request()
                    } label: {
                        Text("跳转")
                    }
                }
            }
        }
    }
    
    func creatorBtnClick() {
        
    }
    
    func scannerBtnClick() {
        
    }
    
    func storeBtnClick() {
        
    }
}








