//
//  FCCreatorSaveView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/13.
//

import Foundation
import SwiftUI
import DynamicColor

enum FCStoreAlertType {
    case saveImageSuccess
    case saveImageFail
    case coinDontEnough
}

struct FCCreatorSaveView: View {
    @Environment(\.presentationMode) var mode
    
    @State var creatorPhoto: FCCreatorPhoto
    
//    @State var previewImage: UIImage = UIImage(named: "test_screen")!
    @State var isShowPurchaseView: Bool = false
    
    
    @State var isShowAlert = false
    @State var isShowCoinStore = false
  
    @State var alertType: FCStoreAlertType = .saveImageSuccess
    
    var body: some View {
        GeometryReader { geo in
             
            ZStack {
                Color(DynamicColor(hexString: "#F4F4FA"))
                    .ignoresSafeArea()
                VStack {
                    topBackBgView
                    Image(uiImage: creatorPhoto.resultImage ?? UIImage(named: "test_screen") ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: UIScreen.main.bounds.size.height - 44 - 290)
                    
                    Spacer()
                        .frame(height: 20)
                    saveHDBtn
                    Spacer()
                        .frame(height: 20)
                    saveSmallBtn
                    Spacer()
                }
                purchaseAlertView
                    .offset(y: isShowPurchaseView ? 0 : UIScreen.main.bounds.height)
                    .animation(.easeInOut)
                    .transition(.opacity)
                
                
            }
            
            .alert(isPresented: $isShowAlert, content: {
                alert()
                

            })
            
            .sheet(isPresented: $isShowCoinStore, content: {
                FCStoreView()
                    .environmentObject(CoinManager.default)
            })
            
             
        }
        
    }
    func alert() -> Alert {
        if alertType == .saveImageSuccess {
            return Alert(title: Text("Save Success"), message: Text(""), dismissButton: .default(Text("OK")))
        } else if alertType == .saveImageFail {
            return Alert(title: Text("Save Error"), message: Text(""), dismissButton: .default(Text("OK")))
        } else if alertType == .coinDontEnough {
            return Alert(title: Text("Coin is not enough to buy coins"), message: Text(""), primaryButton: .default(
                    Text("OK")

                    , action: {
                        isShowCoinStore = true

                    }), secondaryButton: .cancel(Text("Cancel")))

        } else {
            return Alert(title: Text("Save Error"), message: Text(""), dismissButton: .default(Text("OK")))
        }
    }
     
    
    var topBackBgView: some View {
        HStack {

            Button(action: {
                mode.dismiss()
            }, label: {
                Image("home_back_ic")
                    .frame(width: 76, height: 44, alignment: .center)
            })
            Spacer()
             
        }.frame(height: 44)
    }
    
    
    var saveHDBtn: some View {
        Button(action: {
            isShowPurchaseView = true
        }, label: {
            ZStack {
                Color(DynamicColor(hexString: "#FFDCEC"))
                    .cornerRadius(8)
                ZStack {
                    Color(.white)
                        .border(Color.black, width: 1, cornerRadius: 8)
                    HStack {
                        Spacer()
                        Image("save_ic")
                        Spacer()
                            .frame(width: 10)
                        Text("Save HD Picture")
                            .foregroundColor(.black)
                            .font(Font.custom("Avenir-BlackOblique", size: 16))
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Image("pro_ic")
                                .frame(width: 20, height: 20, alignment: .center)
                                .padding(.trailing, -5)
                                .padding(.top, -5)
                                
                            Spacer()
                        }
                    }
                }
                .padding(.top, 9)
                .padding(.bottom, 9)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                
            }
            
        })
        .frame(width: 235, height: 72, alignment: .center)
        
        
    }
    
    var saveSmallBtn: some View {
        Button(action: {
            
            saveSmallBtnClick()
        }, label: {
            Text("Save Small Pic")
                .foregroundColor(.black)
                .baselineOffset(1)
                .font(Font.custom("Avenir-Medium", size: 14))
                .underline(true, color: .black)
                
        }).frame(width: 140, height: 30, alignment: .center)
        
    }
    
    
 
    func saveSmallBtnClick() {
        
        if let imageData = creatorPhoto.resultImage?.jpegData(compressionQuality: 0.6) {
            WWAlbumHelper.default.savePhoto(imageData) { (success, error) in
                
                isShowAlert = true
                if success {
                    alertType = .saveImageSuccess
                } else {
                    alertType = .saveImageFail
                }
                
            }
        }
         
    }
    
    func saveHDPictureAction() {
        
        
        
        // 金币足
        if CoinManager.default.coinCount > CoinManager.default.coinCostCount {

            if let imageData = creatorPhoto.resultImage?.jpegData(compressionQuality: 1) {
                WWAlbumHelper.default.savePhoto(imageData) { (success, error) in
                    isShowAlert = true
                    if success {
                        alertType = .saveImageSuccess
                    } else {
                        alertType = .saveImageFail
                    }

                    CoinManager.default.costCoin(coin: CoinManager.default.coinCostCount)
                }
            }

        } else {
            // 金币不足
            isShowAlert = true
            alertType = .coinDontEnough

        }
        
        
        
    }
     
}

extension FCCreatorSaveView {
    // purchase alert view
    var purchaseAlertView: some View {
        
        ZStack {
            Color(.clear)
            VStack {
                Button(action: {
                    isShowPurchaseView = false
                }, label: {
                    Color(.clear)
                })
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
            saveHDPictureAction()
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

struct FCCreatorSaveView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCCreatorSaveView(creatorPhoto: FCCreatorPhoto())
            
        }
    }
}



