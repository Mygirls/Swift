//
//  ViewController.swift
//  NameSpace
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 春风十里. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        protocolTest()
        
        associatedtypeTest()
    }

    
    func protocolTest() {
        //6.1、 将一个Dog类赋值给一个遵守了Pet协议的对象，是没有问题的。因为协议可以当作一个类型来看待。
        let dog: Dog = Dog()
        var tempPet: Pet = dog
        tempPet.changName(name: "小明")
        
        //Value of type 'Pet' has no member 'privateMethd'
        //tempPet.privateMethd()
        
        
        //8.1、Buff在实现协议Pet的时候，如果将birthplace声明为var是没有问题的。如果birthplace被当作是Dog的属性，它是可以赋值的，但如果birthplace被作为是Pet的属性，它是不可以赋值的。
        var buff: Buff = Buff()
        let _: Pet = dog
        
        // 对dog的birthplace属性赋值是没有问题的
        buff.birthPlace = "Shanghai"
        // 不可以对aPet的birthplace属性赋值。因为在协议Pet中，birthplace是只读的
        // aPet.birthplace = "Hangzhou"
    }
    
    func associatedtypeTest() {
        
        //1)
        let _: Double = 3.54.km
        
        // 我们可以给Double设置一个别名，则以上代码就可以改为下面的代码
        let _: MajaDouble = 3.34.test
        
        
        //3)
        let baseball = BaseballRecord3(wins: 3, loses: 2)
        baseball.winningPercent()
        print(baseball)    // WINS: 3, LOSES: 2
        
        print(baseball.descriptionWithDate)
        
        //3.6.1(
        //let football = FootballRecord(wins: 1, loses: 1, ties: 1)
        //football.gamePlayed
        //football.winningPercent()

        let s = StructA(wins: 1, loses: 1, ties: 1)
        s.gamePlayed
        s.wins
    }

}

//MARK: - protocol 知识回顾
/**
 *  在命名空间之前先了解一下protocol
 *  https://www.cnblogs.com/muzijie/p/6596164.html
 */
protocol Pet {
    //属性
    var name: String {get set}
    var birthPlace: String {get}
    
    //1、协议中的属性必须具有显式{get }或{get SET}说明符。
    //var age: Int  //错误
    //2、属性不可以有默认值
    //var age : Int = 18    //错误
    //3、即使属性只有get，没有set，也不可以将属性设置为let，必须设置为var
    //let age: Int {get}    //错误

    //方法
    func fed(food: String)
    func playWith()
    
    mutating func changName(name: String)
    
    //4、协议方法中不允许使用默认参数
    //func eat(food: String = "a")  //错误
    
}

class TestProtocol {
    
    func test() {
        
        //5、以下写法中，表示pet遵守Pet协议。由于Pet不是类，故不能用Pet()来对pet进行初始化。
        var pet: Pet
        
        //var p: Pet = Pet()    //错误
    }
}

//6、结构体遵循协议
struct Dog: Pet {
    
    //此时属性可以设置默认值
    var name: String = "Tom"
    
    //协议中birthplace为可读属性，可以直接声明为let类型就可以，当然也可以声明为var类型
    var birthPlace: String = "beijing"
    
    func fed(food: String) {
        
    }
    
    func playWith() {
        
    }
    
    //可以为方法中的参数设置默认值
    //在结构体中，如果需要改变自身的值，需要在方法前面加mutating关键字。
    //在协议的方法中添加mutating关键字，如果结构体来遵守协议，需要有 mutating这个关键字，如果是类来遵守协议，mutating关键字就不需要了。
    mutating func changName(name: String = "Tom") {
        print("\(name)")
    }
    
    func privateMethd() {
        print("Dog 自定义的方法，非协议方法")
    }
}


//7、如果只希望协议只被类class遵守，只需要在定义协议的时候在后面加上AnyObject即可
//以下定义的Animate协议只能被类遵守，结构体是不可以遵守的。
protocol Animate: AnyObject {
    var name: String {set get}
}

class Cat: Animate {
    var name: String = ""
}


//8、Buff在实现协议Pet的时候，如果将birthplace声明为var是没有问题的。如果birthplace被当作是Dog的属性，它是可以赋值的，但如果birthplace被作为是Pet的属性，它是不可以赋值的。
struct Buff: Pet {
    var name: String = "Tom"
    
    var birthPlace: String = "beijing"
    
    func fed(food: String) {
        
    }
    
    func playWith() {
        
    }
    
    func changName(name: String) {
        
    }
    
}

//9、
//因此需要在类（Tom）的构造函数中填加改实现该方法的标识，即关键字required。
//如果类（Jack）定义为final类，即其它类不可以继承该类，则required关键字可以省略。
protocol Person {
    var name: String {get set}
    var birthplace: String {get}
    
    // 定义构造函数
    init(name: String)
}

class Child {
    var type = "mamal"
}

class Tom: Person {
    var name: String = "Tim"
    
    var birthplace: String = "Tim"
    
    required init(name: String) {
        
    }
}

// 也可以这样写
final class Jack: Child, Person {
    
    var name: String = "Tim"
    var birthplace: String = "Bei Jing"
    
    // 此时required关键字就可以省略
    init(name: String) {
        self.name = name
    }
}



class Rose {
    var name: String
    
//    init(name: String) {
//        self.name = name
//    }
    
    init() {
        self.name = ""
    }
}

//MARK: - associatedtype 知识回顾
/**
 *  1)回顾了protocol，接着熟悉下associatedtype
 */
extension Double {
    var km: Double {return self * 1000.0}
    var m: Double {return self}
    var cm: Double {return self / 100}
    var ft: Double {return self / 3.28084}
}


typealias MajaDouble = Double
extension Double {
    var test: MajaDouble {return self * 1000.0}
}

//2)在设计协议(protocol)时，如果有两个协议，它们的方法和属性都一样，只有协议中用到的类型不同，我们就没必要定义两个协议，只需要将这两个协议合并为一个就可以了。
//这时就可以在协议中使用关联类型(associatedtype)，类似于类型别名(typealias)。
protocol WeightCalaulate {
    
    associatedtype weightType
    
    var weight: weightType {get}
}
// 在类iphone7中，weightType为Double类型的别名
class iphone7: WeightCalaulate {
    
    typealias weightType = Double
    
    var weight: weightType {
        return 0.114
    }
}
// 在类Ship中，weightType为Int类型的别名
class Ship: WeightCalaulate {
    
    typealias weightType = Int
    
    var weight: weightType {
        return 46_328_000
    }
}

class iphone8: WeightCalaulate {
    
    typealias weightType = Int
    
    var weight: weightType {
        return 22
    }
}


//3)协议可以继承、可以扩展

//3.1)先看下面的代码：定义了一个协议Record，两个结构体BaseballRecord、BasketballRecord，这两个结构体都实现了Record和CustomStringConvertible协议。
protocol Record {
    var wins: Int {get}
    var loses: Int {get}
    func winningPercent() -> Double
}

struct BaseballRecord: Record, CustomStringConvertible {
    var wins: Int
    var loses: Int
    func winningPercent() -> Double {
        return Double(wins)/Double(wins + loses)
    }
    
    var description: String {
        return String(format: "WINS: %d, LOSES: %d", wins, loses)
    }
}

struct BasketballRecord: Record, CustomStringConvertible {
    var wins: Int
    var loses: Int
    func winningPercent() -> Double {
        return Double(wins)/Double(wins + loses)
    }
    
    var description: String {
        return String(format: "WINS: %d, LOSES: %d", wins, loses)
    }
}

//3.2)可以看到，以上两个结构体都实现了Record, CustomStringConvertible两个协议，
//如果我们希望只要实现Record协议，就需要实现CustomStringConvertible协议。
//我们可以让Record协议继承自CustomStringConvertible协议，这样只要实现Record协议，就必须实现CustomStringConvertible协议。代码如下：
// 协议中定义代码及结构体中实现的代码同上，此处省略
protocol Record2: CustomStringConvertible {
    
    
    
}

struct BaseballRecord2: Record2 {
    var description: String
    
   
}

struct BasketballRecord2: Record2 {
    var description: String
    
    
}

//3.3)可以看到，两个结构体中实现协议的代码是相同的。如果这一部分代码可以写到协议中，在结构体中就可以省去重复的代码。
//又协议的定义(Protocol Record)中是不可以实现代码的，我们可以通过扩展协议的方式，在扩展中实现相应的代码。（在扩展中可以进行一些默认的实现）
protocol Record3: CustomStringConvertible {
    var wins: Int {get}
    var loses: Int {get}
    func winningPercent() -> Double
}

extension Record3 {
    // 定义一个属性
    var gamePlayed: Int {
        return wins + loses
    }
    // 实现Record协议中定义的方法
    
    @discardableResult
    func winningPercent() -> Double {
        return Double(wins)/Double(gamePlayed)
    }
    // 实现CustomStringConvertible协议
    var description: String {
        return String(format: "WINS: %d, LOSES: %d", wins, loses)
    }
}

struct BaseballRecord3: Record3 {
    var wins: Int
    var loses: Int
}

struct BasketballRecord3: Record3 {
    var wins: Int
    var loses: Int
}

//let baseball = BaseballRecord3(wins: 3, loses: 2)
//baseball.winningPercent()
//print(baseball)    // WINS: 3, LOSES: 2

//3.4) 可以扩展系统中的协议
extension CustomStringConvertible {
    var descriptionWithDate: String {
        return NSDate().description + description
    }
}

//3.5)在协议的扩展中定义的属性，在实现该协议的结构体中仍可以重写该属性。
struct BaseballRecord5: Record3 {
    var wins: Int
    var loses: Int
    
    // 重写了协议扩展中定义的属性gamePlayed
    let gamePlayed: Int = 162
}

//3.6)用where关键字对协议做条件限定（where 类型限定）
//3.6.1)第一 一个结构体StructA，它实现Record协议，并且它新增了一个属性（平局ties），这样它的gamePlayed属性以及winningPercent()方法都需要重写。代码如下：

protocol ProtocolA  {
    var wins: Int {get}
    var loses: Int {get}
}

extension ProtocolA {
    
    // 定义一个属性
    var gamePlayed: Int {
        return wins + loses
    }
}
struct StructA: ProtocolA {
    var wins: Int
    
    var loses: Int
    
    // 定义平局的属性
    var ties: Int
    
    var gamePlayed: Int {
        return wins + loses + ties
    }
}

//4)协议聚合
protocol Prizable {
    func isPrizable() -> Bool
}

// 表示Prizable和CustomStringConvertible两个协议都实现了的结构体才可以调用该方法
func award(one: Prizable & CustomStringConvertible) {
    
}

//5)泛型约束（在方法定义中可以用T来代表某个协议，只需要用<T: 协议名>来定义协议就好）
//func top<T: Record>(seq: [T]) -> T {
//
//}
//// 多个协议
//func top<T: Record & Prizable>(seq: [T]) -> T {
//}


//6)可选协议：以下协议被标识为@objc属性，使得它兼容Objective-C代码。如果协议拥有可选的属性或方法时，是必须添加@objc的，因为Swift要使用Objective-C的运行时来检查类所遵守的可选方法是否存在。拥有可选方法的协议只能被类遵守，结构体和枚举是不可以遵守该协议的。
@objc protocol Animals {
    // 注意： 在swift3中optional前面也必须有@objc
    @objc optional func fly()
}





