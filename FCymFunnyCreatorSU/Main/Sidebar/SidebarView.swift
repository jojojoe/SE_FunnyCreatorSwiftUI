//
//  SidebarView.swift
//  AppStoreSidebar
//
//  Created by Roy Rao on 2020/11/18.
//

import SwiftUI

struct SidebarView: View {
    @State var items: [SidebarItem] = [
        SidebarItem(label: "Discover", index: 0, isSelected: true),
        SidebarItem(label: "Create", index: 1),
        SidebarItem(label: "Work", index: 2),
        SidebarItem(label: "Play", index: 3),
        SidebarItem(label: "Develop", index: 4),
        SidebarItem(label: "Categories", index: 5),
        SidebarItem(label: "Updates", index: 6),
    ]
    @State var selectionKeeper: Int
    
    var body: some View {
     
        
        List {
            ForEach(0..<items.count) { index in
                SidebarRowView(rowItem: items[index], selectAction: {
                    changeSelection(index)
                    
                })
                    .background(index == selectionKeeper ? Color.gray : nil)
            }
        }
    }
    
    func changeSelection(_ index: Int) {
        items[selectionKeeper].isSelected = false
        items[index].isSelected = true
        selectionKeeper = index
    }
}
struct SidebarView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SidebarView(selectionKeeper: 2)
        }
    }
}
