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

struct FCEditSaveView: View {
    @Environment(\.presentationMode) var mode
    @State var resultImage: UIImage
    @State var isShowSaveResultAlert = false
    @State var isSaveSuccessStatus = false
    @State var text = ""
    @State var isEditing = true
    @State var isShowMakeQRView: Bool = true
    @State var qrImage: UIImage? = nil
    
    
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
                
            }.navigationBarHidden(true)
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
                    
                }.padding(8)
                
            }
            
        }).frame(width: 150, height: 72, alignment: .center)
        .alert(isPresented: $isShowSaveResultAlert, content: {
            
            Alert(title: Text(isSaveSuccessStatus ? "Save Success" : "Save Error"), message: Text(""), dismissButton: .default(Text("OK")))
        })
        
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
        if let saveImage = (resultImage.jpegData(compressionQuality: 1)) {
            WWAlbumHelper.default.savePhoto(saveImage) { (success, error) in
                isShowSaveResultAlert = true
                isSaveSuccessStatus = success
                
            }
        }
        
    }
    
    func makeBtnClick() {
        text = ""
        isShowMakeQRView = true
        isEditing = true
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
                    }
                }.frame(height: 375)
                
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
    
    var makeBtn_Ok: some View {
        
        NavigationLink(destination: Text("")
                        .frame(height: 400)
                       , isActive: .constant(qrImage != nil)) {

            Button(action: {
                isShowMakeQRView = false
                isEditing = false
                hideKeyboard()
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
            FCEditSaveView(resultImage: UIImage(named: "background_ic_5")!)
        }
    }
}





