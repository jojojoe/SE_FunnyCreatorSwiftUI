//
//  ResourceModelManager.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/11.
//

import Foundation

struct ShapeItem: Codable, Identifiable, Hashable {
    static func == (lhs: ShapeItem, rhs: ShapeItem) -> Bool {
        return lhs.id == rhs.id
    }
    var id: Int = 0
    var thumbName: String = ""
    var bigName: String = ""
    var isPro: Bool = false
     
}

struct StickerItem: Codable, Identifiable, Hashable {
    static func == (lhs: StickerItem, rhs: StickerItem) -> Bool {
        return lhs.id == rhs.id
    }
    var id: Int = 0
    var thumbName: String = ""
    var bigName: String = ""
    var isPro: Bool = false
     
}

struct BackgroundItem: Codable, Identifiable, Hashable {
    static func == (lhs: BackgroundItem, rhs: BackgroundItem) -> Bool {
        return lhs.id == rhs.id
    }
    var id: Int = 0
    var thumbName: String = ""
    var bigName: String = ""
    var isPro: Bool = false
     
}


class CFResourceModelManager: ObservableObject {
    @Published var shapeItemList: [ShapeItem] = []
    @Published var stickerItemList: [StickerItem] = []
    @Published var backgroundItemList: [BackgroundItem] = []
    
    static let `default` = CFResourceModelManager()
    
    init() {
        loadData()
    }
    
    func loadData() {
        shapeItemList = LoadJsonData.default.loadJson([ShapeItem].self, name: "ShapeList") ?? []
        stickerItemList = LoadJsonData.default.loadJson([StickerItem].self, name: "StickerList") ?? []
        backgroundItemList = LoadJsonData.default.loadJson([BackgroundItem].self, name: "BackgroundList") ?? []
    }
     
    
    
}

extension CFResourceModelManager {
     
}





