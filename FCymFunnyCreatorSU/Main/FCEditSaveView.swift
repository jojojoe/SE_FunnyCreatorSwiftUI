//
//  FCEditSaveView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/12.
//

import Foundation
import SwiftUI
import DynamicColor
import TextView


enum FCEditSaveViewAlertType {
    case photoDeniedAlert
    case saveImageSuccessAlert
    case saveImageFailedAlert
    case coinNotEnoughAlert
}

struct FCEditSaveView: View {
    @Environment(\.presentationMode) var mode
    @State var resultImage: UIImage
    
    @State var text = ""
    @State var isEditing = true
    @State var isShowMakeQRView: Bool = false
    @State var qrImage: UIImage? = nil
    @State var isShouldCostCoin: Bool
    
    
    @State var isShowAlert = false
    
//    @State var isShowSaveResultAlert = false
//    @State var isSaveSuccessStatus = false
//    @State var isShowPhotoDeniedAlert = false
//    @State var isShowCoinNotEnoughAlert = false
    @State var alertType: FCEditSaveViewAlertType = .photoDeniedAlert
    
    @State var isShowCoinStore = false
    @State var isShowPurchaseView: Bool = false
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(DynamicColor(hexString: "#F4F4FA"))
                    .ignoresSafeArea()
                VStack {
                    topBackBgView
                    Image(uiImage: resultImage)
                        .resizable()
                        .frame(width: geo.size.width, height: geo.size.width, alignment: .center)
                        .backgroundFill(.white)
                        
                    Spacer()
                    bottomBtnView
                    Spacer()
                    Spacer()
                        .frame(height: 40)

                }
                makeQREditView
                    .hidden(!isShowMakeQRView)
                purchaseAlertView
                    .offset(y: isShowPurchaseView ? 0 : UIScreen.main.bounds.height)
                    .animation(.easeInOut)
                    .transition(.opacity)
                
            }.navigationBarHidden(true)
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
        if alertType == .photoDeniedAlert {
           return Alert(title: Text("Oops!"), message: Text("You have declined access to photos, please active it in Settings>Privacy>Photos."), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("Ok"), action: {
                PrivacyAuthorizationManager.default.openSettingPage()
            }))
            
        } else if alertType == .saveImageSuccessAlert {
            return Alert(title: Text("Photo storage successful."), message: Text(""), dismissButton: .default(Text("OK")))
        } else if alertType == .saveImageFailedAlert {
            return Alert(title: Text("Photo storage failure."), message: Text(""), dismissButton: .default(Text("OK")))
        } else if alertType == .coinNotEnoughAlert {
            return Alert(title: Text("Coins shortage.Click and Jump to Store Page."), message: Text(""), primaryButton: .default(
                    Text("OK")

                    , action: {
                        isShowCoinStore = true

                    }), secondaryButton: .cancel(Text("Cancel")))
        } else {
            return Alert(title: Text("Photo storage failure."), message: Text(""), dismissButton: .default(Text("OK")))
        }
    }
    
    
    
}

extension FCEditSaveView {
    var topBackBgView: some View {
        HStack {
            Button(action: {
                topBackClick()
            }, label: {
                Image("home_back_ic")
                    .frame(width: 44, height: 44, alignment: .center)
            })
            
            Spacer()
        }.backgroundFill(Color(DynamicColor(hexString: "#F4F4FA")))
    }
    
    func topBackClick() {
        mode.dismiss()
    }

}

extension FCEditSaveView {
    var bottomBtnView: some View {
        HStack {
            Spacer()
            saveBtn
            Spacer()
            makeBtn
            Spacer()
        }
    }
    
    var saveBtn: some View {
        Button(action: {
            saveBtnClick()
        }, label: {
            ZStack {
                Color(DynamicColor(hexString: "#FFDCEC"))
                    .cornerRadius(8)
                ZStack {
                    Color(.white)
                        .border(Color.black, width: 1, cornerRadius: 8)
                    HStack {
                        Image("save_ic")
                        Text("Save")
                            .foregroundColor(.black)
                            .font(Font.custom("Avenir-BlackOblique", size: 16))
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
                    }.hidden(!isShouldCostCoin)
                }.padding(8)
                
            }
            
        }).frame(width: 150, height: 72, alignment: .center)
        
        
    }
   
    var makeBtn: some View {
        Button(action: {
            makeBtnClick()
        }, label: {
            ZStack {
                Color(DynamicColor(hexString: "#C9FFEE"))
                    .cornerRadius(8)
                ZStack {
                    Color(.white)
                        .border(Color.black, width: 1, cornerRadius: 8)
                    HStack {
                        Image("home_code_ic")
                        Text("Make")
                            .foregroundColor(.black)
                            .font(Font.custom("Avenir-BlackOblique", size: 16))
                    }
                    
                }.padding(8)
                
            }
            
        }).frame(width: 150, height: 72, alignment: .center)
        
    }
    
    
    func saveBtnClick() {
        
        PrivacyAuthorizationManager.default.requestPhotosPermission {
            if let saveImage = (resultImage.jpegData(compressionQuality: 1)) {
                if isShouldCostCoin == true {
                    
                    if CoinManager.default.coinCount >= CoinManager.default.coinCostCount {
                        isShowPurchaseView = true
                    } else {
                        alertType = .coinNotEnoughAlert
                        isShowAlert = true
                    }
                    
                    
                    
                } else {
                    WWAlbumHelper.default.savePhoto(saveImage) { (success, error) in
                        if success {
                            alertType = .saveImageSuccessAlert
                            isShowAlert = true
                        } else {
                            alertType = .saveImageFailedAlert
                            isShowAlert = true
                        }
                    }
                }
            }
        } deniedBlock: {
            alertType = .photoDeniedAlert
            isShowAlert = true
            
        }
        
        
        
    }
    
    func saveImageAction(saveImage: Data) {
        WWAlbumHelper.default.savePhoto(saveImage) { (success, error) in
            if success {
                alertType = .saveImageSuccessAlert
                isShowAlert = true
                CoinManager.default.costCoin(coin: CoinManager.default.coinCostCount)
            } else {
                alertType = .saveImageFailedAlert
                isShowAlert = true
            }
            
        }
    }
    
    func makeBtnClick() {
        text = ""
        isShowMakeQRView = true
        isEditing = true
    }
 
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
                        Text("Save the picture and cost \(CoinManager.default.coinCostCount) coins")
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
            if let saveImage = (resultImage.jpegData(compressionQuality: 1)) {
                saveImageAction(saveImage: saveImage)
            }
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


extension FCEditSaveView {
    // purchase alert view
    var makeQREditView: some View {
        
        ZStack {
            Color(.clear)
            VStack {
                Spacer()
                ZStack {
                    RoundedCorners(color: .white, tl: 16, tr: 16, bl: 0, br: 0)
                        .shadow(color: Color(DynamicColor.black.withAlphaComponent(0.5)), radius: 10, x: 0.0, y: 0.0)
                        .edgesIgnoringSafeArea(.bottom)
                    VStack {
                        
                        makeBtn_Close
                        Text("Make QRcode")
                            .font(Font.custom("Avenir-Black", size: 14))
                        
                        TextView(
                            text: $text,
                            isEditing: $isEditing,
                            placeholder: "Put in your text...",
                            textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                            backgroundColor: (DynamicColor(hexString: "#EFEFEF"))
                        ).frame(width: 280, height: 56, alignment: .center)
                        .cornerRadius(6)
                        .padding(10)
                        
                        
                        Spacer()
                            .frame(height: 30)
                        
                        makeBtn_Ok
                            .disabled(!(text.count >= 1))
                        
                        Spacer(minLength: 60)
                        Spacer()
                    }
                }.frame(height: 475)
                
            }
        }
    }
    
    var makeBtn_Close: some View {
        HStack {
            Spacer()
            Button(action: {
                isShowMakeQRView = false
                isEditing = false
                hideKeyboard()
            }, label: {
                Image("setting_close_ic")
            }).frame(width: 50, height: 50, alignment: .center)
        }
        
    }
    
    func qrResultImage() -> UIImage {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        
        let canvasView = UIView()
        canvasView.frame = frame
        canvasView.backgroundColor = .white
        
        let qrImg = LBXScanWrapper.createCode(codeType: "CIQRCodeGenerator", codeString: text, size: frame.size, qrColor: UIColor.black, bkColor: UIColor.white)

        
//        let qrImgBlend = LBXScanWrapper.addImageLogo(srcImg: qrImg!, logoImg: logoImg, logoSize: CGSize(width: 62, height: 62))
        
        let qrImageView = UIImageView()
        let padding: CGFloat = 10
        qrImageView.frame = CGRect(x: padding, y: padding, width: frame.size.width - padding * 2, height: frame.size.height - padding * 2)
        qrImageView.image = qrImg
        canvasView.addSubview(qrImageView)
        
        let addImageView = UIImageView()
        addImageView.frame = CGRect(x: 0, y: 0, width: 62, height: 62)
        addImageView.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addImageView.image = resultImage
        canvasView.addSubview(addImageView)
        
        return canvasView.screenshot ?? UIImage()
        
    }
    
    var makeBtn_Ok: some View {
        
        
        NavigationLink(destination: FCEditQRcodePreview(qrImage: qrImage ?? UIImage())
                        
                       , isActive: .constant(qrImage != nil)) {

            Button(action: {
                qrImage = qrResultImage()
                isShowMakeQRView = false
                isEditing = false
                hideKeyboard()
                
//
                
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
}

struct FCEditSaveView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCEditSaveView(resultImage: UIImage(named: "background_ic_5")!, isShouldCostCoin: false)
        }
    }
}





