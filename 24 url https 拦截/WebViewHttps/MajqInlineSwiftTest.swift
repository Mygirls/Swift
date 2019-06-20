//
//  MajqInlineSwiftTest.swift
//  WebViewHttps
//
//  Created by Majq on 2018/8/21.
//  Copyright © 2018年 Mac. All rights reserved.
//
//  参考博客： https://github.com/vandadnp/swift-weekly/blob/master/issue11/README.md#inline
import UIKit




class MajqInlineSwiftTest: NSObject {
    
    func add_normal(a:Int,b:Int) -> Int  {
        return a + b;
    }
    
    // 声明这个函数never编译成inline的形式
    // 如果你的功能很小，你希望你的应用程序运行得更快（注意：它并没有使差别很大）使用@inline(__always)
    @inline(__always) func add_inline(a:Int,b:Int) -> Int  {
        return a + b;
    }
    
    // 声明这个函数never编译成inline的形式
    // 如果函数很长，并且希望避免增加代码段大小 使用@inline(never)
    @inline(never) func add_inline2(a:Int,b:Int) -> Int  {
        return a + b;
    }
    
    //如果你不知道代码内联意味着什么，就不要使用这个关键字： inline 。先读这个。


    func testInlineMethod() {
        let sum01: Int = add_normal(a: 2, b: 3);
        print("普通函数：" + "\(sum01)");
        
        let sum02: Int = add_inline(a: 2, b: 3);
        print("内联函数：" + "\(sum02)");
    }
}
