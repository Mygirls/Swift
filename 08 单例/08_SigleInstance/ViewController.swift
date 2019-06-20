//
//  ViewController.swift
//  08_SigleInstance
//
//  Created by cfzq on 2017/6/16.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnAction(_ sender: Any) {
        
        //这里使用 FREE_VERSION 这个编译符号来代表免费版本 为了使之有效 我们需要在项目的编译选项中进行设置
        //Build Setting --> Swift ComPiler --> Custom Flags 
        //在Other Swift Flags  加上 
        //-D FREE_VERSION
        
        #if FREE_VERSION
            print("FREE_VERSION")
        #else
            print("非FREE_VERSION")
        #endif
        
        
        
        let secondVC = SecondViewController.shareManger()
    
        self.present(secondVC as! UIViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: ***单例
//swift3.0 以前的写法
class MyManager {
    class var shareManger: MyManager {
        struct Static {
            static let shareInstance: MyManager = MyManager()
        }
        return Static.shareInstance
    }
}

//单例swift3.0 的写法：1.写法简介、保证单例的独一无二 2.在这个类型中加入一个私有的初始化方法来覆盖默认的公开私有化方法-->目的是使其他地方不能通过init 来生成自己的MyManager02实例
class MyManager02 {
    static let shared = MyManager02()
    private init() {
    
    }
}

//MARK: ***条件编译
//swift 中没有《宏定义概念》
extension ViewController {
    func testCondition () {
        
        #if os(macOS)
            typealias Color  = NSColor
        #else
            typealias color  = UIColor
        #endif
        
        
        //        #if false
        //            typealias Color  = UIColor
        //        #else
        //            typealias color  = UIColor
        //        #endif
        
        
        self.view.backgroundColor = color.gray

    }
}

//MARK: - 编译标记
//MARK: 编译标记
//TODO: 编译标记
//FIXME: 编译标记: 表示需要修改的地方
//swift 中没有。#warning 
extension ViewController {
    func test01() {
        
    }
}











