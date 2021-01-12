//
//  SidebarRowView.swift
//  AppStoreSidebar
//
//  Created by Roy Rao on 2020/11/18.
//

import SwiftUI

struct SidebarRowView: View {
    var rowItem: SidebarItem
    var selectAction: () -> Void
    
    var body: some View {
        
        Button(action: {
            selectAction()
        }, label: {
            Text(rowItem.label)
                .font(.system(size: 12))
                .fontWeight(.regular)
        })
//
//        Button(action: {
//            selectAction()
//        }, label: {
//            Image(nsImage: rowItem.image)
//                .resizable()
//                .frame(width: 20, height: 20)
//                .fixedSize()
//            Text(rowItem.label)
//                .font(.system(size: 12))
//                .fontWeight(.regular)
//            Spacer()
//        })
        .frame(width: 100, height: 30, alignment: .leading)
        .buttonStyle(PlainButtonStyle())
    }
}
