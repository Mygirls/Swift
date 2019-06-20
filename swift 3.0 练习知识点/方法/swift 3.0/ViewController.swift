//
//  ViewController.swift
//  swift 3.0
//
//  Created by JQ on 2017/8/30.
//  Copyright © 2017年 majq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        testMethods()
        
        classMethod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
/*
 1. 方法是与某些特定类型相关联的函数
 
 */

//MARK: - 实例方法 (Instance Methods)
extension ViewController {

    
    fileprivate func testMethods() {
    
        
        testInstanceMehtod()
        
        selfPropertyMethod()
        
        changePropertyValueMethod()
        
        mutatingMethodToAssignedValue()
    }
    
    //1.实例方法 (Instance Methods)
    private func testInstanceMehtod() {
        let counter = Counter() // 初始计数值是0
        counter.increment() // 计数值现在是1
        counter.increment(by: 5) // 计数值现在是6
        counter.reset() // 计数值现在是0
    }
    
    //2.self 属性
    private func selfPropertyMethod() {
        //类型的每一个实例都有一个隐含属性叫做 self ， self 完全等同于该实例本身
        
        //使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名 称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用 self 属性来区分参数名称和属性 名称
        struct Point {
            var x = 0.0, y = 0.0
            func isToTheRightOfX(x: Double) -> Bool {
                return self.x > x   //如果不使用 self 前缀，Swift 就认为两次使用的 x 都指的是名称为 x 的函数参数。
            }
        }
        
        let somePoint = Point(x: 4.0, y: 5.0)
        if somePoint.isToTheRightOfX(x: 1.0) {
            print("This point is to the right of the line where x == 1.0")
        }
        
    }
    
    //3. 在实例方法中修改值类型
    private func changePropertyValueMethod() {
        //结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择 可变(mutatin g) 行为,然后就可以从其方法内部改变它的属性;并且这个方法做的任何改变都会在方法执行结束时写回到原始 结构中。方法还可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
        var p =  Point2(x: 1.3, y: 2.4)
//        p.x = 4
        p.isToTheRightOfX(x: 4.0)
        print(p.x)
        
        p.moveByX(deltaX: 2.0, y: 2.0)
        //注意，不能在结构体类型的常量(a constant of structure type)上调用可变方法，因为其属性不能被改 变，即使属性是变量属性
//        let p2 =  Point2(x: 1.3, y: 2.4)
//        p2.isToTheRightOfX(x: 4.0)
        
//        let p3 = Point3(x: 2.3, y: 4.5)
//        p3.x = 5.0
//        print(p3.y)
    }
    
    //4.在可变方法中给 self 赋值
    private func mutatingMethodToAssignedValue() {
        //可变方法能够赋给隐含属性 self 一个全新的实例
        //新版的可变方法 moveBy(x:y:) 创建了一个新的结构体实例，它的 x 和 y 的值都被设定为目标值。调用这个版本 的方法和调用上个版本的最终结果是一样的。
        var fixedPoint2 = Point2(x: 3.0, y: 3.0)
        fixedPoint2.moveByX(deltaX: 2.0, y: 3.0)
        
        var fixedPoint = Point4(x: 3.0, y: 3.0)
        fixedPoint.moveBy(x: 2.0, y: 3.0)
        
        //枚举的可变方法可以把 self 设置为同一枚举类型中不同的成员:
        var c = TriStateSwitch2.High
        c = .Low
        
        var ovenLight = TriStateSwitch.Low
        ovenLight.next()
        // ovenLight 现在等于 .High 
        ovenLight.next()
        // ovenLight 现在等于 .Off

    }
}

/*
    实例方法是被某个类型的实例调用的方法。你也可以定义在类型本身上调用的方法，这种方法就叫做类型方 法
    在方法的 func 关键字之前加上关键字 static ，来指定类型方法。
    类还可以用关键字 class 来允许子类重写 父类的方法实现
 
 */
//MARK: - 类型方法
extension ViewController {

    fileprivate func classMethod() {
        SomeClass.someTypeMethod()
        
        var player = Player(name: "Argyrios")
        player.complete(level: 1)
        print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)") // 打印 "highest unlocked level is now 2"

        player = Player(name: "Beto")
        if player.tracker.advance(to: 6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
        // 打印 "level 6 has not yet been unlocked"
    }
}


//TODO: - 类方法 （类和结构体）
class SomeClass {
    var b = 2
    class func someTypeMethod() {
        //在类型方法的方法体(body)中， self 指向这个类型本身，而不是类型的某个实例。这意味着你可以用 self 来 消除类型属性和类型方法参数之间的歧义(类似于我们在前面处理实例属性和实例方法参数时做的那样
        var  a = 1
        func test() {
        }
    }
    
    class func someTypeMethod2() {
        //一个类型方法可以直接通过类型方法的名称调用本类中的其它类型方法，而无需在方法名称前面加上类型名称
        someTypeMethod()
        
        
    }
}

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}


class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

//TODO: - 实例方法 （类和结构体）
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

struct Point2 {
    var x = 0.0, y = 0.0
    
    //报错： cannot assign to property: 'self' is immutable(因为值类型的属性不能在它的实例方法中被修改)
//    func isToTheRightOfX(x: Double)  {
//        self.x = x
//    }

    //方法定义时加上了 mutating 关键字，从而允许修改属性
    mutating func isToTheRightOfX(x: Double)  {
        self.x = x
    }
    
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

struct Point3 {
    var x = 0.0, y = 0.0

    func isToTheRightOfX(x: Double)  {
        
    }
}

struct Point4 {
    var x = 0.0, y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point4(x: x + deltaX, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}

enum TriStateSwitch2 {
    case Off, Low, High

}





