//
//  SecondViewController.swift
//  SwiftDevelopTip
//
//  Created by cfzq on 2017/3/20.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange

        // Do any additional setup after loading the view.
        
        let v1 = Vector2D(x: 2.0, y: 3.0)
        let v2 = Vector2D(x: 1.0, y: 4.0)
        let v3 = Vector2D(x: v1.x + v2.x , y: v1.y + v2.y)
        print(v3)
        
        var luckyNumber = 7
        let newNum = incrementor(variable: luckyNumber)
        print("\(luckyNumber),\(newNum)")
        
        var luckyNumber02 = 7
        let newNum02 = incrementor02(variable: luckyNumber02)
        print("\(luckyNumber02),\(newNum02)")
        
        var luckyNumber03 = 7
        let newNum03 =  incrementor03(variable: &luckyNumber03)
        print("\(luckyNumber03),\(newNum03)")
        
        print("*************************")
        var a = [1,2,3]
        var b = a
        let c = b
        test(a)
        print(a,b,c)
        print("值类型被复制的时机 是值类型的内通发生改变时")
        //值类型被复制的时机 是值类型的内通发生改变时
        var a1 = [1,2,3]
        var b1 = a1
        b1.append(5)
        print(a1)
        print(b1)//a1、b1的内存地址不再相同
        //注意： 值类型在复制时，会将存储在其中的值类型一并复制，而对于其中的引用类型则是复制一份 引用
        
    }

    
    //MARK: Tip:8 操作符
    struct Vector2D {
        var x = 0.0
        var y = 0.0
    }
    
    //MARK: Tip:9 func的参数修饰
    func incrementor(variable: Int ) -> Int {
        return variable + 1
    }
    
    //下面方法错误
//    func incrementor(variable: Int ) -> Int {
//        variable += 1
//        return variable
//    }
//    //等价于
//    func incrementor( let variable: Int ) -> Int {
//        variable += 1 //常量是不可以修改的，在version2.2 中，可以用var 修饰variable，但 3.0以后取消了
//        return variable
//    }
    
    
    func incrementor02(variable: Int ) -> Int {
        var num = variable  //显示赋值，语义清晰明确
        num += 1
        return num
    }
    
    ///另外一种方法： inout 在方法内部直接修改输入的值,所以不需要返回值了，调用也要改为相应的形式，取地址符  &
    ///相当于在函数内部创建一个新的值，然后再函数返回时将这个值赋给& 修饰的变量，与引用类型是不同的
    func incrementor03(variable: inout Int ) {
        variable += 1
        
    }
    
    //MARK:tip 值类型、引用类型补充说明
    func test(_ arr: [Int]) {
        for i in arr {
            print(i)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
