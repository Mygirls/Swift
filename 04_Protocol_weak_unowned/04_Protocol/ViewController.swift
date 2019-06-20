//
//  ViewController.swift
//  04_Protocol
//
//  Created by cfzq on 2017/6/8.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //testProtocol()
        
        testMemoryManagement()
    }
    
    func testProtocol ()  {
        
        //Mystruct。 
        //1. 在具体的实现这个协议的类型中，即使我们什么都不做，也可通过编译。
        //2.进行调用的话，会直接使用extension中的实现
        MyStruct().method() //Called
        
        //MyStruct02 当在需要的类型中进行其他的实现
        MyStruct02().method() //Called in Struct

        //比较上面两点：protocol extension 为protocol 中定义的方法提供了一个默认的实现，
        //这相当于 变相的将protocol 中的方法设定为 --> optoional
        
        //其他情形01
        let b1 = B1()
        let result = b1.method01()
        print(result)   //Hello
        
        let a1: A1 = B1()
        let result02 = a1.method01()
        print(result02) //Hello

     
        //其他情形02
        let b2 = B2()
        let result03 = b2.method01()
        print(result03) //Hello
        
        let result04 = b2.method02()
        print(result04) //Hello
        
        
        let a2 = b2 as A2
        let result05 = a2.method01()
        print(result05) //Hello
        
        let result06 = a2.method02()
        print(result06) //world
        
        //总结：
        //1.如果类型推断得到的是实际的类型
            //1> 那么类型中的实现将被调用；如果类型中没有实现的话，那么协议扩展中的默认实现将被使用
        //2.如果类型推断得到的是协议，而不是实际类型
            //1> 并且方法在协议中进行了调用，那么类型中的实现将被调用；如果类型中没有实现，那么协议扩展中的默认实现被使用
            //2> 否则（也就是方法没有在协议中定义），扩展中的默认实现将被调用
        
        //可选协议和协议扩展
        // 在 protocol 定义之前以及协议方法之上加上@objc 另外使用没有@符号的关键字optional来定义可选方法： 如下：
        //@objc 修饰的protocol 只能被class 实现
        //OptionalClass().optionalMethod()    //错误：没有实现可选的方法
        
        OptionalClass02().optionalMethod()

    }
    
    func testMemoryManagement()  {
        //当对象没有引用的时候，其内存将会被自动收回，我们只需要保证在适当的时候将引用置空（比如超过作用域，或者手动设置为nil）
        
        var obj: A? = A()
        obj = nil   // objc 释放A对象 但是 B中的b.a 依然引用这个对象 然而a中含有b对象
        
        var xiaoMing: Person? = Person(personName: "xiaoMing")
        xiaoMing!.printName()
        xiaoMing = nil
        
        //weak：在引用的内容被释放后，标记为weak 的成员将会自动变成nil
        //unowned：设置以后即使原来引用的内容已经释放了，它任然会保持对被已经释放了的对象一个 “无效的”引用，他不能是optional值，也不会被指向nil，强行调用就好崩溃
    }

   

}

//MARK: *** Protocol 部分*********************
protocol MyProtocol {
    func method()
}

extension MyProtocol {
    func method() {
        print("Called")
    }

}

struct MyStruct : MyProtocol {
    
}


struct MyStruct02 : MyProtocol {
    func method() {
        print("Called in Struct")
    }
}

//**** 在协议的extension 中实现协议里没有定义的方法 *********
protocol A1 {
    func method01() -> String
}


struct B1: A1 {
    func method01() -> String {
        return "Hello"
    }
}

//在协议extension中实现了额外的方法 method02
protocol A2 {
    func method01() -> String
}

extension A2 {
    func method01() -> String {
        return "world"
    }

    func method02() -> String {
        return "world"
    }

}

struct B2: A2 {
    func method01() -> String {
        return "Hello"
    }
    
    func method02() -> String {
        return "Hello"
    }
}

//可选协议和协议扩展
@objc protocol OptionalProtocol {
    @objc optional func optionalMethod()
}

//错误： @objc 修饰的protocol 只能被class 实现
//struct OptionalStruction : OptionalProtocol {
//    
//}

class OptionalClass : OptionalProtocol {

}

class OptionalClass02 : OptionalProtocol {
    func optionalMethod() {
        print("实现了可选的方法")
    }
}
//MARK: *** weak 和 unowned 部分*********************
class A: NSObject {
    let b: B
    override init() {
        b = B()
        super.init()
        b.a = self
    }
    deinit {
        print("A deinit")
    }

}

class B: NSObject {
    //var a: A? = nil
    //unowned var a: A? = nil //只能应用于类和类绑定的协议类型
    weak var a: A? = nil
    deinit {
        print("B deinit")
    }
}

class Person {
    let name: String
    lazy var printName:() -> () = { [weak  self ] in
        if let strongSelf = self {
            print("the name is \(strongSelf.name)")

        }
        
    }
    init(personName: String) {
        name = personName
    }
    
    deinit {
        print("person deinit \(self.name)")
    }
}

//auto release pool 自动释放池：会将接受该消息的对象放到一个预先建立的（auto release pool 自动释放池）中，并在 自动释放池收到 drain 消息时将 这些对象的引用计数减一，然后将他们从池子中移除。这一过程 也叫 抽干池子



