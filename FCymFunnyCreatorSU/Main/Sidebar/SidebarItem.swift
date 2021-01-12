//
//  SidebarItem.swift
//  AppStoreSidebar
//
//  Created by Roy Rao on 2020/11/18.
//

import SwiftUI

struct SidebarItem: Identifiable, Hashable {
    static func == (lhs: SidebarItem, rhs: SidebarItem) -> Bool {
        return lhs.index >= rhs.index
    }
    
    let id = UUID().uuidString
    
    let label: String
    let index: Int
//    let image: NSImage = NSImage(named: NSImage.folderName)!
    var isSelected: Bool = false
}
