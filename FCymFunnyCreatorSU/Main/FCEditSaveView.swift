//
//  FCEditSaveView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/12.
//

import Foundation
import SwiftUI
import DynamicColor


struct FCEditSaveView: View {
    @Environment(\.presentationMode) var mode
    @State var resultImage: UIImage
    @State var isShowSaveResultAlert = false
    @State var isSaveSuccessStatus = false
    
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
                .navigationBarHidden(true)
            }
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
        
    }
    
}


struct FCEditSaveView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FCEditSaveView(resultImage: UIImage(named: "background_ic_5")!)
        }
    }
}




