//
//  MEncryption.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/20.
//  Copyright © 2018年 Majq. All rights reserved.
//

import Foundation

//为 String拓展一个方法
extension MajqNamespaceStruct where T == String {
    /// 中文字符串编码
    ///
    /// - Parameter urlString: 字符串
    /// - Returns: String
    static func addingPercentEncoding(urlString: String) -> String {
        let newUrlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        return newUrlString
    }
    
}
