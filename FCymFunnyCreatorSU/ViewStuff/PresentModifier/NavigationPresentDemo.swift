//
//  NavigationPresentDemo.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/8.
//

import Foundation
import SwiftUI

struct NavigationPresentDemoView: View {
    
    @State var isActive = false
    @State var isModal = false
    @State var isPopOver = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(destination: Text("Detail"), isActive: $isActive) {
                    Text("跳转")
                }
                Spacer().frame(width: 1, height: 20, alignment: .center)
                Button("自动跳转") {
                    //每次打印isActive都是false,说明这是一个状态位标识
                    print(self.isActive)
                    self.isActive = true
                }
                
                Spacer().frame(width: 1, height: 20, alignment: .center)
                
                Button("sheet Modal跳转示例") {
                    //每次打印isModal都是false,说明这是一个状态位标识
                    print(self.isModal)
                    self.isModal = true
                }.sheet(isPresented: $isModal, onDismiss: {
                    print("Detail View Dismissed")
                }) {
                    Text("sheet Modal Detail")
                }
                 
                
                Button("PopOverModal跳转示例") {
                    //每次打印isPopOver都是false,说明这是一个状态位标识
                    print(self.isPopOver)
                    self.isPopOver = true
                }.popover(isPresented: $isPopOver, content: {
                    Text("PopOverModal Detail")
                })
                
                
            }
            
        }

    }
    
 
}


struct FullScreenDemoContentView: View {
    
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            Button(action: {
                self.isPresented.toggle()
            }) {
                Text("Present")
            }
            .navigationBarTitle("Some title")
        }
        .present($isPresented, view: FullScreenDemoModalView(isPresented: $isPresented))
    }
}

struct FullScreenDemoModalView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                self.isPresented.toggle()
            }) {
                Text("Dismiss")
            }
        }
    }
}




 
