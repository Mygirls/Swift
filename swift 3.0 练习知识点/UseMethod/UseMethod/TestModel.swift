//
//  TestModel.swift
//  UseMethod
//
//  Created by JQ on 2017/9/8.
//  Copyright © 2017年 Majq. All rights reserved.
//

import UIKit

class TestModel: NSObject, NSCopying {
    var name: String?
    var test1: String?
    var test2: String?
    
    var subModel: TestSubModel?
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        let t = TestModel()
        t.name = self.name
        t.test1 = self.test1
        t.test2 = self.test2

        return t
    
    }
    
}

class TestSubModel: NSObject {
    var name: String?
    var test3: String?
}
