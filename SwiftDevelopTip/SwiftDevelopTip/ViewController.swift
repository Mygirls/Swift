//
//  ViewController.swift
//  SwiftDevelopTip
//
//  Created by cfzq on 2017/3/16.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit
//TODO:1.将protocol的方法声明为mutating
///mutating： swift的mutating 关键字修饰方法为了能在该方法中修改struct、enum 的变量，所以，如果你没有在协议中写 mutating 的话，别人如果用sturct、enum 来实现这个协议的话，就不能在方法中改变自己的变量饿了
protocol Vehicle {
    var numberOfWheels: Int {get}
    var color: UIColor {get set}
    func changeColor()

}

//struct MyCar: Vehicle {
//    let numberOfWheels: Int = 4
//    var color: UIColor = UIColor.white
//    var myColor: UIColor = UIColor.purple
//    func changeColor() {  //没有加mutating
//        
//        //因为 color 的类型是UIColor 这里直接写 .blue 就足以推断类型了
//        myColor = .blue //错误： ***cannot assign to property：‘self’ is immutable 不能改变结构体的成员**
//        //结构体 是 值类型，不能改变本身的值
//    }
//    
//    
//}

//错误： Type‘MyCar’ dose not conform to protocol 'Vehicle' 报错说没有实现协议
//struct MyCar: Vehicle {
//    let numberOfWheels: Int = 4
//    var color: UIColor = UIColor.white
//    var myColor: UIColor = UIColor.purple
//    mutating func changeColor() {   //加上 mutating
//        //因为 color 的类型是UIColor 这里直接写 .blue 就足以推断类型了
//        myColor = .blue // ***cannot assign to property：‘self’ is immutable 不能改变结构体的成员**
//        //结构体 是 值类型，不能改变本身的值
//    }
//
//
//}


//所以 综合所得：mutating： swift的mutating 关键字修饰方法为了能在该方法中修改struct、enum 的变量，所以，如果你没有在协议中写 mutating 的话，别人如果用sturct、enum 来实现这个协议的话，就不能在方法中改变自己的变量了
protocol Vehicle02 {
    var numberOfWheels: Int {get}
    var color: UIColor {get set}
    mutating func changeColor()
    
}

struct MyCar: Vehicle02 {
    let numberOfWheels: Int = 4
    var color: UIColor = UIColor.white
    var myColor: UIColor = UIColor.purple
    mutating func changeColor() {  //加mutating
        myColor = .blue
    }


}

// 在使用class 来实现带有muting 的方法的协议时，具体实现的前面是不需要加 mutating 修饰的，因为class 可以随意修改自己的成员变量，所以，协议里面用的mutating 修饰方法，对呀class  的实现是完全透明的，可以当做不存在
class Car: Vehicle {
    let numberOfWheels: Int = 4
    var color: UIColor = UIColor.white
    var myColor: UIColor = UIColor.purple
    func changeColor() {
        
        //因为 color 的类型是UIColor 这里直接写 .blue 就足以推断类型了
        myColor = .blue
    }
}



class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let num = addOne(num: 2)
        print(num)
        
        let addTwo = addTo(2)
        print(type(of: addTwo))
        
        let result = addTwo(6)
        print(result)
        
        let greaterThan10 = greaterThan(10)
        //greaterThan10(13)
        print(greaterThan10(13))
        
        //greaterThan10(9)
        print(greaterThan10(9))
        
        functionOfSequence()

        
       
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 115, y: 115, width: 50, height: 50)
        btn.setTitle("push", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.backgroundColor = UIColor.brown
        //        btn.addTarget(self, action: #selector(ViewController.buttonPressed), for: .touchUpInside) //ViewController.  可以不写
        btn.addTarget(self, action: #selector(buttonPressed(btn:)), for: .touchUpInside)
        self.view.addSubview(btn)
        

        
    }
    func buttonPressed(btn:UIButton) {
        let   vc:SecondViewController = SecondViewController()
        self.present(vc, animated: true, completion: nil)
    }

    //TODO:
    func addOne(num: Int) -> Int {
        return num + 1
    }
    
    func addTo(_ adder: Int) -> (Int) -> Int {
        //return {$0 + adder}
        return {
            num in
            return num + adder
        }
    }
    
    
    func greaterThan(_ comparer: Int) -> (Int) -> Bool {
        return { $0 > comparer }
//        return {
//            valueBool in
//            return valueBool > comparer
//        }
    }
    
    //TODO: 3.内联序列函数sequence
    func functionOfSequence()  {
        
        //sequence(first: <#T##T#>, next: <#T##(T) -> T?#>)
        //public func sequence<T>(first: T, next: @escaping (T) -> T?) -> UnfoldSequence<T, (T?, Bool)>

        var i = 1
        repeat {
            print(i)
            i = i * 2
        } while i <= 100
    
        print("******************")
        //1）而改用 sequence(first: next:) 实现如下，可以看到省去了外部变量的定义。
        for i  in sequence(first: 1, next: {$0 * 2}) {
            if i > 100 {
                break
            }
            print(i)
        }
        
        print("******************")
        for i  in sequence(first: 10, next: {value in
            
            return value * 2
        }) {
            
            if i > 100 {
                break
            }
            print(i)
        }
        
        print("******************")
        //2）我们还可以将所有的处理逻辑，状态判断都放在 next 闭包里。所以上面样例又可以这样写
        for _  in sequence(first: 1, next: {
            print($0)
            let value = $0 * 2
            return value <= 100 ? value : nil  //next中返回nil表示sequence结束
        }) {
            
        }
    }
    
}



