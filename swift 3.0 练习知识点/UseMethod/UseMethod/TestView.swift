//
//  TestView.swift
//  UseMethod
//
//  Created by JQ on 2017/9/8.
//  Copyright © 2017年 Majq. All rights reserved.
//

import UIKit

class TestView: UIView {

    var model: TestModel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func test1() -> TestModel? {
        
        guard let m = model else { return  nil}
        

        let a = model?.subModel
        a?.name = "12456789uu"
        a?.test3 = "这是一个测试"
        
        return m
    }

}
