//
//  ViewController.swift
//  05_ValueTypeAndeRerenceType
//
//  Created by cfzq on 2017/6/8.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit
/**
    值类型在传递和赋值时进行复制，而引用类型则只会使用引用对象的一个“指向”
 
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //相比传统的引用类型来说，值引用的优势就是减少了堆上内存分配和回收的次数
        test01()
        
        print("-----------------------------------------")
        test02()
        
       
    }
    
    func test01()  {
        //没有必要复制的时候，值类型的复制都是不会发生的： 也就是说简单的赋值、参数传递等等普通操作
        var a = [1,2,3]
        var b = a
        let c = b
        a = [2,3,4]
        test(a)
        print(a)
        print(b)
        print(c)
        
        withUnsafePointer(to: &a) {
            print("\($0)")
        }
        
        withUnsafePointer(to: &b) {
            print("\($0)")      //相比于oc：a、b的地址是一样，而swift： a、b的地址不一样
        }
        
        //总结： 类似oc 里面的深拷贝：深拷贝是指拷贝对象的具体内容，而内存地址是自主分配的，拷贝结束之后，两个对象虽然存的值是相同的，但是内存地址不一样，两个对象也互不影响，互不干涉
        
        
        
        //值类型被复制的时机是 值类型的内容发生改变
        print("--------------")
        
        var d = [1,2,3]
        
        withUnsafePointer(to: &d) {
            print("d的地址\($0)")
        }
        var e = d
        
        withUnsafePointer(to: &e) {
            print("e的地址\($0)")
        }
        
        d.append(4)
        withUnsafePointer(to: &d) {
            print("d的地址\($0)")
        }
        
        print(d)
        print(e)
        
        withUnsafePointer(to: &e) {
            print("e的地址\($0)")
        }

    }
    
    func test02 ()  {
        var aper = Person()
        var bper = Person()
        var models = [aper,bper]
        withUnsafePointer(to: &models) { print($0) }
        
        for (i, info) in models.enumerated() {
            print(info)
        }
        
        print("----")
        print("----")

        var m = models
        withUnsafePointer(to: &m) { print($0) }
        
        for info in m {
            print(info)
        }
        
        print("----")
        print("----")
        
        //值类型在复制时，会将存储在其中的值类型一并进行复制
        //而对于其中的引用类型的话，则复制一份 -->   引用。--》 相似oc
        var testStuct = TestStuct()
        var a = [testStuct]
        var b = a
        testStuct.name = "change value"
        print(a)
        print(b)
        
        var test = Person()
        var test01 = [test]
        var test02 = test01
        test.name = "change"
        print(test01[0].name)
        print(test02[0].name)
        
        //----
        
        var test03 = Person()
        var  test04 = [test03]
        test03.name = "test change"
        print(test04[0].name)
        
        var test05 = TestStuct()
        var  test06 = [test05]
        test05.name = "test change ----"
        print(test06[0].name)

    }

    func test (_ arr: [Int]) {
        for i  in arr {
            print(i)
        }
    }
    
    @IBAction func Button(_ sender: Any) {
        
        let oc = ObjectCViewController()
        
        self.present(oc , animated: true, completion: nil)
    }


}

//值类型 引用类型

class Person: NSObject {
    var name: String = "test"
}

struct TestStuct  {
    var name: String = "TestStuct"

}

