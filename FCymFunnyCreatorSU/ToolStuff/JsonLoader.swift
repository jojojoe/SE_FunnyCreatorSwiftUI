//
//  JsonLoader.swift
//  FCymFunnyCreatorSU
//
//  Created by JOJO on 2021/1/11.
//

import Foundation

public class LoadJsonData: NSObject {
    
    public static var `default` = LoadJsonData()
    
    public func loadJson<T: Codable>(_: T.Type, name: String, type: String = "json") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch let error as NSError {
                    print(error)
                }
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    public func loadPlist<T: Codable>(_:T.Type, name:String, type:String = "plist") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                do {
                    return try PropertyListDecoder().decode(T.self, from: data)
                } catch let error as NSError {
                    print(error)
                }
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}
