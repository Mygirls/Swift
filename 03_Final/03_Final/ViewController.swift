//
//  ViewController.swift
//  03_Final
//
//  Created by cfzq on 2017/6/7.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit

//TODO: ***1.final 用法
/*
    final: 可以用在class,func,var 前面进行修饰，表示不允许对该内容进行继承或重写操作
 */

//为了父类中某些代码一定会被执行
class Parent {
    final func method() {
        print("开始配置")
        //...必要的代码
        
        methodImpl()
        
        print("结束配置")
    }
    
    func methodImpl() {
//        fatalError("子类必须实现这个方法")
        print("父类的业务逻辑")

        //或者也可以给出默认实现
    }
}

class Child: Parent {
    override func methodImpl() {
        //子类的业务逻辑
        print("子类的业务逻辑")

    }
}

//作用；无论如何使用mothod,都可以保证需要的代码一定被执行，而同时给子类继承和重写自定义具体实现提供了机会


//TODO: ***2.lazy 用法

/*
    lazy修饰符 和 lazy 方法
 
 */

class ViewController: UIViewController {

    //lazy 作为属性修饰符时候，只能声明属性为 var 变量
    lazy var str: String = {
        
        let str = "Hello"
        print("只有在首次访问输出")
        return str
    }()
    
    
    lazy var str2: String = "Hello"
    
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testFinal()
        
        testLazy()
        
        testReflectionAndMirror()
        
        testOptional()
        
        
        
        
    }
    
    func testFinal () {
        print("***1.final 用法******************")

        let parent = Parent()
        parent.method()
        
        let child = Child()
        child.method()
    }
    
    func testLazy() {
        print("***2.lazy 用法******************")
        print(str)
        self.str = "123"
        print(str)
        
        print(str2)

        str2 = "123"
        print(str2)
        print("***")

        let data = 1...3
        let result = data.map { (i: Int) -> Int in
            
            print("正在处理：\(i)")
            return i * 2
        }
        
        print("准备访问结果")
        for i  in result {
            print("操作后结果为：\(i)")
        }
        
        print("操作完毕")
        
        
        print("*** lazy 配合map filter")
        let data2 = 1...3
        let result2 = data2.lazy.map { (i: Int) -> Int in
            
            print("正在处理：\(i)")
            return i * 2
        }
        
        print("准备访问结果")
        for i  in result2 {
            print("操作后结果为：\(i)")
        }
        
        print("操作完毕")
    }

    //TODO: ***3.ReflectionAndMirror 用法
    func testReflectionAndMirror() {
        print("***3.ReflectionAndMirror 用法******************")

        let xiaoMing = Person(name: "xiaoMing", age: 16)
        let r = Mirror(reflecting: xiaoMing)
        print(r.self)
        print("xiaoMing 是\(r.displayStyle!)")
        print("属性个数：\(r.children.count)")
        //public typealias Child = (label: String?, value: Any)
        //public typealias Children = AnyCollection<Mirror.Child>

        for child  in r.children {
            print("属性名：\(child.label)、值：\(child.value)")
        }
        
        
        if let name  = reflecetValueWith(object: xiaoMing, key: "name") as? String {
            print("通过key 得到值：\(name)")
        }
        dump(xiaoMing)
    }
    
    private func reflecetValueWith(object:Any,key: String) -> Any? {
        let mirror = Mirror(reflecting: object)
        for child  in mirror.children {
            let (targetKey,targetMirror) = (child.label,child.value)
            if key == targetKey {
                return targetMirror
            }
        }
        
        return nil
    }
    
    //TODO: ***4.optional 用法
    func testOptional() {
        print("***4.optional 用法******************")
        /*  Optional  --->  其实是枚举类型的
 
        public enum Optional<Wrapped> : ExpressibleByNilLiteral {
            case none
            case some(Wrapped)
        }

         */
        
        var aNil: String? = nil
        var anotherNil: String?? = aNil
        var literalNil: String?? = nil
        
        //在此处加一个断点，然后分别输入命令：po literalNil、po anotherNil  比较有什么区别，然后在分别输入：fr v -R literalNil、fr v -R anotherNil 再来比较
        if let a  = anotherNil {
            print("anotherNil")
        }
        
        if let b = literalNil  {
            print("literalNil")
        }
        
        
        let num: Int? = 3
        var result: Int?
        if let reealNum  = num {
            result = reealNum * 2
        } else {
        }
        
        let result2 = num.map {_ in 

            return 6
        }
        print(result2)

        let result3 =  num.map { (i: Int) -> Int in
           
            return i * 2
        }
        print(result3)
        
    }
   

}



struct Person  {
    let name: String
    let age: Int
}

