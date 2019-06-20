//
//  MajqTest.swift
//  NameSpace
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 春风十里. All rights reserved.
//

import Foundation
//调用方式
//let testStr = "foo".hand.test

extension String: NamespaceWrappable { }

extension NamespaceWrapper where T == String {
    var majqTest: String {
        return wrappedValue
    }
    
}
