//
//  ViewController.swift
//  07_selector
//
//  Created by cfzq on 2017/6/16.
//  Copyright © 2017年 cfzq. All rights reserved.
//

/**
 
 */
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //testSelector ()
        
        testInstance ()
    }
    
    
    
}

//MARK: *** 测试Selector
extension ViewController {

    func testSelector ()  {
        
        let someMethod = #selector(callMe)
        let anotherMothod = #selector(callMeWithParam(obj:))    //同oc 一样，也需要冒号和参数名(:)
        let method = #selector(turn(by:speed:))
        
        //如果该方法名字在方法所在区域内是唯一的，我们也可以简单的只用方法名字来作为#selector 的内容
        let anotherMothod2 = #selector(callMeWithParam)
        
        //注意： 测试方法01： 如果同一个作用域中存在名字相同的两个方法，及时她们的签名不同，swift 编译也通不过
        //let method2 = #selector(turn)
        
        //解决上述方法：强制转换
        let method01 = #selector(turn as (Int,Float) -> ())
        let method02 = #selector(turn as (Int,Float,String) -> ())
        
        
        //如果调用一个swift 中的private 方法，编译器会报 一个 错误： xxxMethod is not exposed to oc
        //解决方法： 在private 前面 加一个 @objc
        //定时器来测试：两个方法都可以
        Timer.scheduledTimer(timeInterval: 1, target: self , selector: #selector(callMe), userInfo: nil, repeats: true)
        
        //Timer.scheduledTimer(timeInterval: 1, target: self , selector: someMethod, userInfo: nil, repeats: true)
        
    }
    
    //注意 @objc
    @objc private func callMe()  {
        print("通知我")
    }
    
    func callMeWithParam(obj: Any) {
        
    }
    
    func turn(by angle:Int,speed: Float) {
        
    }
    
    //测试方法01
    func turn(by angle:Int,speed: Float,test: String) {
        
    }


}

//MARK: ***实例方法的动态调用
extension ViewController {
    func testInstance() {
        
        //最普遍的用法: 限定了我们只能够在编译的时候就决定 object 实例和对应的方法调用
        let object = MyClass()
        let result = object.method(number: 1)
        print(result)
        
        //swift 中可以直接调用 Type.instanceMethod 的语法来生成一个可以 《柯里化》 的方法
        let f = MyClass.method  //f的类型： (MyClass) -> (Int) -> Int
        //等价于：
        let F = { (obj: MyClass) in
            obj.method
        }
       
        let objcet02 = MyClass()
        
        //let result02 = f(objcet02)(1)   //通过类型取出这个类型的某个实例方法的签名，然后通过传递实例来拿到实际需要调用的方法
        
        //注意： 上面的方法只适用实例方法，对于属性的getter、setter是不能用类似的方法
        //理由： 如果不加改动的话， let f = MyClass.method 这行代码 采取到的是类型方法
        //解决办法：
        let f1 = MyClass.method //类方法
        let f2: (Int) -> Int = MyClass.method //跟f1 一样
        let f3:(MyClass) -> (Int) -> Int = MyClass.method   //func method 的柯里化版本
        
        let F2 = MyClass.test(str: "")  //let F2: String
        let F3 = MyClass.test           //let F3: (String) -> String
        let result02 =  F3("测试")       //let result02: String
        
        //testCurrying () //简单回顾柯里化
    }
    
    //简单回顾柯里化:
    func testCurrying ()  {
        let addTwo01 = addOne(num: 1)
        print(addTwo01)
        
        let addTwo02 = addOne(num: 1)
        print(addTwo02)
        
        let addTwo03 = addTo(2) // addTwo: Int -> Int    相当于返回的是一个函数
        print(addTwo03)
        
        //注意： 下面的方法名 是上一个 的返回值
        let result = addTwo03(6)   //result = 8
        print(result)
        let result02 = addTwo03(8)
        print(result02)
        
        let greaterThan10 = greaterThan(10)
        let state01 = greaterThan10(13)
        let state02 = greaterThan10(9)
        print("state01 = \(state01)","state02 = \(state02)")
        
        
    }
    //例子 01
    //这个函数非常有限制： 只能加一 如果加二 加三 的情况需要再定一个一个新的方法
    func addOne (num: Int) -> Int {
        return num + 1
    }
    
    //这个方法是对上面一个方法局限性的通用： 定义一个通用函数，它将接受需要与输入数字加法的数，并返回一个函数，返回的函数将接受输入数字数字本身
    func addTo (_ adder: Int) -> (Int) -> Int {
        
        return {
            num in
            print("------num = \(num)")
            return num + adder
            
        }
    }
    
    
    //例子：02
    func greaterThan(_ comparer: Int) -> (Int) -> Bool {
        return {$0 > comparer}
    }
    
    //例子：03
    //没看懂
    
}

class MyClass {
    
    func method(number: Int) -> Int {
        return number + 1
    }

    class func method(number: Int) -> Int {
        return number + 1
    }
    
    class func test(str: String) -> String {
        return ""
    }
}

//----例子：03
protocol TargetAction  {
    func performAction()
}

struct TargerActionWrapper<T: AnyObject>:TargetAction {
    
    weak var target: T?
    let action: (T) -> () -> ()
    func performAction() {
        if let t  = target {
            action(t)()
        }
    }
    
    
}

enum ControlEvent {
    case TouchUpInside
    case ValueChanged
}

class Control {
    var actions = [ControlEvent:TargetAction]()
    func setTarget<T: AnyObject>(target: T,action: @escaping(T) -> () -> (),controlEvent: ControlEvent)  {
        actions[controlEvent] = TargerActionWrapper(target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvet: ControlEvent) {
        actions[controlEvet]?.performAction()
    }
}

//---end 例子：03

