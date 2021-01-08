//
//  ContentView.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/5.
//

import SwiftUI

struct ContentView: View {
    @State var isActive = false
    
    var body: some View {
//        FCMainView()
//        FCStoreView().environmentObject(CoinManager.default)
//        FCCameraTakeView()
        
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
    
    func request() {
        PrivacyAuthorizationManager.default.requestCameraPermission {
            
            self.isActive = true
        } deniedBlock: {

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
