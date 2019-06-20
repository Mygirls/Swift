//
//  ViewController.swift
//  范型使用
//
//  Created by JQ on 2017/10/13.
//  Copyright © 2017年 Majq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setUpConfig()
    }

   
    private func setUpConfig() {
        //演示交互两个数值的函数
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt = \(someInt), anotherInt = \(anotherInt)")
        
        //自定义的范型方法、
        swapTwoValues(&someInt, &anotherInt)
        print("someInt = \(someInt), anotherInt = \(anotherInt)")

        //系统自带的方法
        swap(&someInt, &anotherInt)
        print("someInt = \(someInt), anotherInt = \(anotherInt)")
        
        demo01()
        
        demo02()
        
        demo03()
        
        demo04()
        
        demo05()

    }
    

}

//MARK: - 1、初探
extension ViewController {
    
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    func swapTwoStrings(_ a: inout String, _ b: inout String) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    
    
}

//MARK: - 2、实例
extension ViewController
{
    
    //1、类型参数指定并命名一个占位 类型，并且紧随在函数名后面，使用一对尖括号括起来(例如  <T> )。 如下函数：
    //func swapTwoValues<T>(_ a: inout T, _ b: inout T)
    
    //2、命名类型参数
    //在大多数情况下，类型参数具有一个描述性名字，例如  Dictionary<Key,Value> 中的  Key 和 Value   ，以及 Array<Element>中的  Element ，这可以告诉阅读代码的人这些类型参数和泛型函数之间的关系。然而，当它们之间没有有意义的关系时，通常使用单个字母来命名，例如T 、U 、V ，正如上面演示的 swapTwoValues函数中的 一样。
 
    //3、泛型类型
    //除了泛型函数，Swift 还允许你定义泛型类型。这些自定义类、结构体和枚举可以适用于任何类型，类似于 y和。
    //如下结构体： IntStack
    fileprivate func demo01() {
        
        var intStack = IntStack()
        intStack.push(1)
        intStack.push(2)
        intStack.push(3)
        
        //范型类型
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("1")
        stackOfStrings.push("2")
        let r = stackOfStrings.pop()
        print("r = \(r)")
        
    }
    
    
}


//结构体只能用于 Int 类型
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//结构体能用于 范型 类型
/**
 Element 为待提供的类型定义了一个占位名。这种待提供的类型可以在结构体的定义中通过 Element来引用
 
 由于  Stack 是泛型类型，因此可以用来创建 Swift 中任意有效类型的栈，就像Array 和 Dictionory 那样
 
 */
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

//4、扩展一个泛型类型
/**
 当你扩展一个泛型类型的时候，你并不需要在扩展的定义中提供类型参数列表。
 原始类型定义中声明的类型参数列表在扩展中可以直接使用，并且这些来自原始类型中的参数名称会被用作原始定义中类型参数的引用。
 */
extension ViewController
{
    
    fileprivate func demo02() {
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("1")
        stackOfStrings.push("2")
        if let topItem = stackOfStrings.topItem {
            print("The top item on the stack is \(topItem).")
        }
    }
    
}

extension Stack {
    //原始类型定义中声明的类型参数列表在扩展中可以直接使用
    var topItem: Element? {
        return items.isEmpty ? nil: items[items.count - 1]
    }
    
}


//5、类型约束
/**
 类型约束可以指定一个类型参数必须继承自指定 类，或者符合一个特定的协议或协议组合。
 
 类型约束语法
 你可以在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束，它们将成为类型
 参数列表的一部分。
 
 对泛型函数添加类型约束的基本语法如下所示(作用于泛型类型时的语法与之相同):
 func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
     // 这里是泛型函数的函数体部分
 }
 上面这个函数有两个类型参数。第一个类型参数 T ，有一个要求 T 必须是 SomeClass 子类的类型约束;第 二个类型参数 U ，有一个要求 U 必须符合 SomeProtocol 协议的类型约束。
 
 
 */
extension ViewController {
    
    fileprivate func demo03() {
        let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
        if let foundIndex = findStringIndex(ofString: "llama", in: strings) {
            print("The index of llama is \(foundIndex)")
        }
        
        if let foundIndex = findIndex(ofString: "llama", in: strings) {
            print("The index of llama is \(foundIndex)")
        }
        
    }
    
    func findStringIndex(ofString valueToFind: String,in array: [String]) -> Int? {
        for (index ,value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
            
        }
        return nil
    }
    
    
    func findIndex<T: Equatable>(ofString valueToFind: T,in array: [T]) -> Int? {
        for (index ,value) in array.enumerated() {
            //error: Binary operator '==' cannot be applied to two 'T' operands
            //Swift 标准库中定义了一个 Equatable 协议，该协议要求任何遵循 该协议的类型必须实现等式符( == )及不等符( != )，从而能对该类型的任意两个值进行比较。所有的 Swift 标准类型自动支持 Equatable 协议。
            if value == valueToFind {
                return index
            }
            
        }
        return nil
    }
    
}

//MARK: - 关联类型
/**
 定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分将会非常有用。
 关联类型为协议中的 某个类型提供了一个占位名(或者说别名)，其代表的实际类型在协议被采纳时才会被指定。
 你可以通过 associatedtype 关键字来指定关联类型。
 */
extension ViewController {
    
}


/**
 Container 协议定义了三个任何采纳了该协议的类型(即容器)必须提供的功能:
 • 必须可以通过 append(_:) 方法添加一个新元素到容器里。
 • 必须可以通过 count 属性获取容器中元素的数量，并返回一个 Int 值。 • 必须可以通过索引值类型为 Int 的下标检索到容器中的每一个元素。
 */
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
    
}


struct IntStackTest: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // Container 协议的实现部分
    //由于 Swift 的类型推断，你实际上不用在 IntStack 的定义中声明 ItemType 为 Int
    typealias ItemType = Int
    
    mutating func append(item: Int) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}


struct StackTest<Element>: Container {
    
    // Stack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // Container 协议的实现部分
    mutating func append(item: Element) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
        
    }
    
    
}

extension Stack: Container {
    mutating func append(item: Element) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
        
    }
    
}

//泛型 Where 语句
extension ViewController {
    
    fileprivate func demo04() {
        
        var stackOfStrings = StackTest<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        
        if allItemsMatch(stackOfStrings, stackOfStrings) {
            print("All items match.")
        } else {
            print("Not all items match.")
        }
        // 打印 “All items match.”
    }
    
    func allItemsMatch<C1: Container, C2: Container> (_ someContainer: C1, _ anotherContainer: C2) -> Bool
        where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
            // 检查两个容器含有相同数量的元素
            if someContainer.count != anotherContainer.count {
                return false
            }
            // 检查每一对元素是否相等
            for i in 0..<someContainer.count {
                if someContainer[i] != anotherContainer[i] {
                    return false
                } }
            // 所有元素都匹配，返回 true
            return true
    }
}


//MARK: - 经典案例
extension ViewController
{
    fileprivate func demo05() {
        
        let v1 = UIView()
        v1.fs.applyAppearance { (v) in
            v.backgroundColor = UIColor.orange
            v.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        }

        view.addSubview(v1)


        let p = Pet()
    }
}


class Manager: NSObject {
    var property1: String = "测试"
}
class Person {
    var name: String = "张三"
}

struct Pet: NSObjectCompatible {
    
    var name: String = "小黄"
}


