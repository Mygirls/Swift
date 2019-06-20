//
//  ViewController.swift
//  ARCDemo
//
//  Created by JQ on 2017/9/1.
//  Copyright © 2017年 majq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
        setUpConfig()
    }

    
    private func setUpConfig() {
        
        test1()
        
        test2()
    }
}

//MARK: - 自动引用计数
extension ViewController {

    /*
        1.引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传
     
     */
    
    //TODO: - 1.自动引用计数的工作机制
    fileprivate func test1() {
    
        /*
         
            1.1 当你每次创建一个类的新的实例的时候，ARC 会分配一块内存来储存该实例信息。内存中会包含实例的类型信 息，以及这个实例所有相关的存储型属性的值。
         
            1.2 此外，当实例不再被使用时，ARC 释放实例所占用的内存，并让释放的内存能挪作他用。这确保了不再被使用的 实例，不会一直占用内存空间。
         
            1.3 然而，当 ARC 收回和释放了正在被使用中的实例，该实例的属性和方法将不能再被访问和调用。实际上，如果你 试图访问这个实例，你的应用程序很可能会崩溃。
         
            1.4 为了使上述成为可能，无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢地保持住，只要强引用还在，实例是不允许被销毁的。
         */
    }
    
    //TODO: - 2.自动引用计数实践
    fileprivate func test2() {
    
        // 2.1 它们的值会被自动初始化为 nil ，目 前还不会引用到 Person 类的实例。
        var reference1: Person?
        var reference2: Person?
        var reference3: Person?
        
        //2.2 创建 Person 类的新实例，并且将它赋值给三个变量中的一个
        reference1 = Person(name: "张三")

        reference2 = reference1
        
        reference3 = reference1
    }
    
    
    
    
}

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
        
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}



