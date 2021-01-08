//
//  SettingView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/7.
//

import Foundation
import SwiftUI
import DynamicColor
import SwiftUIX

enum SettingContentBtnType: Equatable {
    case feedback
    case privacy
    case instructions
}

struct FCSettingView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                bottomRightBgView
            }
            VStack {
                closeBtn
                topTitleLabel
                HStack {
                    Spacer()
                        .frame(width: 40)
                    VStack(alignment: .leading, spacing: nil, content: {
                        Spacer()
                            .frame(height: 50)
                        contentBtn(btnType: .feedback)
                        Spacer()
                            .frame(width: 10, height: 18, alignment: .center)
                        contentBtn(btnType: .privacy)
                        Spacer()
                            .frame(width: 10, height: 18, alignment: .center)
                        contentBtn(btnType: .instructions)
                        Spacer()
                    })
                    
                    Spacer()
                }
            }
        }
    }
}

extension FCSettingView {
    var bottomRightBgView: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Image("monster_slash_3")
                    .resizable()
                    .frame(width: 241,
                           height: 214,
                           alignment: .bottomLeading)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(height: 214,
               alignment: .bottomLeading)
        
    }
    
    var closeBtn: some View {
        HStack {
            Spacer()
            VStack {
                Button(action: {
                    closeBtnClick()
                }) {
                    Image("setting_close_ic")
                }
                .padding(.trailing, 0)
                .frame(width: 44,
                        height: 44,
                        alignment: .center)
            }.frame(width: 80, height: 44, alignment: .top)
        }
    }
    
    var topTitleLabel: some View {
        HStack (alignment: .top, spacing: nil, content: {
            Spacer().frame(width: 30, height: 10, alignment: .center)
            VStack (alignment: .leading, spacing: 0, content: {
                Text("SETTING")
                    .foregroundColor(.black)
                    .bold()
                    .font(Font.custom("Avenir-BookOblique", size: 33))
                    .fontWeight(.medium)
                  
            })
            Spacer()
        }).padding(.top, 20)
    }
    
    
    func contentBtn(btnType: SettingContentBtnType) -> some View {
        Button(action: {
            contentBtnClick(btnType: btnType)
        }, label: {
            if btnType == .feedback {
                contentBtnText(title: "Feedback")
            } else if btnType == .privacy {
                contentBtnText(title: "Privacy link")
            } else if btnType == .instructions {
                contentBtnText(title: "Instructions for use")
            }
        })
        .frame(height: 50)
    }
    
    func contentBtnText(title: String) -> some View {
        Text(title)
            .foregroundColor(.black)
            .font(Font.custom("Avenir-MediumOblique", size: 18))
    }
     
    
}

extension FCSettingView {
    func closeBtnClick() {
        
    }
    
    func contentBtnClick(btnType: SettingContentBtnType) {
        if btnType == .feedback {
            
        } else if btnType == .privacy {
            
        } else if btnType == .instructions {
            
        }
    }
    
}

struct FCSettingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FCSettingView()
        }
    }
}
 
