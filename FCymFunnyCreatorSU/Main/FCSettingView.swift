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
import MessageUI

var privateUrlString = "http://chubby-blood.surge.sh/Facial_Privacy_Policy.htm"
var termsUrlString = "http://chubby-blood.surge.sh/Terms_of_use.htm"
var feedbackString = "qrcodeslike@hotmail.com"
var AppName = "QRcode Monster"
enum SettingContentBtnType: Equatable {
    case feedback
    case privacy
    case instructions
}

struct FCSettingView: View {
    @Environment(\.presentationMode) var mode
    
    @State private var showMailSheet = false
    
    
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
            

            
        }.background(.white)
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
                    .sheet(isPresented: self.$showMailSheet) {
                        MailView(isShowing: self.$showMailSheet,
                                 resultHandler: {
                                    value in
                                    switch value {
                                    case .success(let result):
                                        switch result {
                                        case .cancelled:
                                            print("cancelled")
                                        case .failed:
                                            print("failed")
                                        case .saved:
                                            print("saved")
                                        default:
                                            print("sent")
                                        }
                                    case .failure(let error):
                                        print("error: \(error.localizedDescription)")
                                    }
                        },
                                 subject: "Feedback",
                                 toRecipients: [feedbackString],
                                 
                                 
                                 messageBody: feedbackMessageBody(),
                                 isHtml: false,
                                 attachments: nil)
                        .safe()
                        /*
                         [("Sample file content".data(using: .utf8)!,
                                        "Text",
                                        "sample.txt")]
                         */
                    }
            } else if btnType == .privacy {
                contentBtnText(title: "Privacy link")
            } else if btnType == .instructions {
                contentBtnText(title: "Instructions for use")
            }
        })
        .frame(height: 50)
    }
    
    func feedbackMessageBody() -> String {
        let systemVersion = UIDevice.current.systemVersion
        let infoDic = Bundle.main.infoDictionary
        // 获取App的版本号
        let appVersion = infoDic?["CFBundleShortVersionString"] ?? "8.8.8"
        // 获取App的名称
        let appName = "\(AppName)"
        
        return "\n\n\nSystem Version：\(systemVersion)\n App Name：\(appName)\n App Version：\(appVersion ?? "1.0")"
    }
    
    func contentBtnText(title: String) -> some View {
        Text(title)
            .foregroundColor(.black)
            .font(Font.custom("Avenir-MediumOblique", size: 18))
    }
     
    
}

extension FCSettingView {
    func closeBtnClick() {
        mode.dismiss()
    }
    
    func contentBtnClick(btnType: SettingContentBtnType) {
        if btnType == .feedback {
            self.showMailSheet.toggle()
            
        } else if btnType == .privacy {
            if let url = URL.init(string: privateUrlString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            
        } else if btnType == .instructions {
            if let url = URL.init(string: termsUrlString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
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
 
