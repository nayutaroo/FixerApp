//
//  Key.swift
//  FixerApp
//
//  Created by 化田晃平 on R 3/02/01.
//

import Foundation
//APIKeyを自身のプロジェクトから取り出す
enum Key {
    static var LineChannelID: String {
        //プロジェクト内のKey.plistのパスを取得
        guard let filePath = Bundle.main.path(forResource: "Key", ofType: "plist")  else {
            //returnで返さずとも処理を停止させられる
            fatalError("can't get filepath")
        }
        
        //Key.plistのファイルの読み込みを行う
        let plist = NSDictionary(contentsOfFile: filePath)
        
        //object() -> String? -> String (as? は文字列以外でとった時用？)
        guard let value = plist?.object(forKey: "LineChannelID") as? String else {
            fatalError("Couldn't find key 'LineChannelID' in 'Key.plist'")
        }
        return value
    }
}
