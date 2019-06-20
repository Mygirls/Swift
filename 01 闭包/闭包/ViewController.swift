//
//  ViewController.swift
//  闭包
//
//  Created by Majq on 2018/5/28.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        testClouse {
            print("测试逃逸闭包")
        }
        
        test01()
        
        test02()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: - 系统方法的闭包
//sorted(by:) 方法接受一个闭包，该闭包函数需要传入与数组元素类型相同的两个值，并返回一个布尔类型值来表明当排序结束后传入的第一个参数排在第二个参数前面还是后面
//当a > b ,返回ture 的时候，升序，反之，倒序
extension ViewController {
    
    func test01() {
        var names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        names.sort { (a, b) -> Bool in
            if a > b {
                return false
            }
            
            return true
        }
        print(names)    //["Alex", "Barry", "Chris", "Daniella", "Ewa"]

        
        var students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
        students.sort(by: >)
        print(students) // Prints "["Peter", "Kweku", "Kofi", "Akosua", "Abena"]
        
        
    }
}
//MARK: - 逃逸闭包
extension ViewController {
    func test02() {

        let testBlock01 = {(a: String,b: String) -> Bool in
            print("a = \(a),b = \(b)")
            return true
        }
        testBlock01("a","v")
    }
    
    
    //测试逃逸闭包
    //逃逸闭包: 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才hui被执行，我们称该闭包从函数中逃逸
    //当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping ，用来指明这个闭包是允许“逃逸”出 这个函数的。
    func testClouse(clouse: @escaping () -> Void) {
        print("1")
        print("2")
        print("3")
        print("4")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            //1秒后操作
            clouse()//当函数体执行完了 才会执行闭包（当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才hui被执行，我们称该闭包从函数中逃逸）
        }
        
        print("5")
        print("6")
        print("7")
        
        return
    }
    
}
