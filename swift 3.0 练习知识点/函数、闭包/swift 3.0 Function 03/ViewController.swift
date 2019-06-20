//
//  ViewController.swift
//  swift 3.0 Function 03
//
//  Created by JQ on 2017/8/27.
//  Copyright © 2017年 majq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var testPropoty: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        testFunction()
        testBlock01()

        
    }
 
}

//MARK: - 函数
extension ViewController {
    func testFunction()  {
        
        someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault = 6
        someFunction(parameterWithoutDefault: 4) // parameterWithDefault = 12
        
        let a = arithmeticMean(1, 2, 3, 4, 5)
        print(a)
        // 返回 3.0, 是这 5 个数的平均数。 arithmeticMean(3, 8.25, 18.75)
        // 返回 10.0, 是这 3 个数的平均数。
        
        //你只能传递变量给输入输出参数。你不能传入常量或者字面量，因为这些量是不能被修改的。当传入的参数作为 输入输出参数时，需要在参数名前加 符，表示这个值可以被函数修改。
        //输入输出参数是函数对函数体外产生影响的另一种方式。
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        
        //定义一个叫做 mathFunction 的变量 类型为一个有两个Int型的参数并返回一个Int 型的值的函数，并让这个新变量指向addTwoInts 函数
        var mathFunction: (Int, Int) -> Int = addTwoInts(_:_:)
        var total = mathFunction(2, 3)
        print("total = \(total)")
        print(type(of: mathFunction))
        
        //有相同匹配类型的不同函数可以被赋值给同一个变量，就像非函数类型的变量一样:
        mathFunction = multiplyTwoInts(_:_:)
        total = mathFunction(2, 3)
        print("total = \(total)")
        
        print(type(of: mathFunction))
        
        //函数类型作为参数类型
        printMathResult(addTwoInts(_:_:), 3, 5)
        
        printMathResult({ (a, b) -> Int in
            print("a = \(a), b = \(b)")
            return a + b
            
        }, 3, 5)
        
        printMathResult2({ (a, b) -> Int in
            print("a = \(a), b = \(b)")
            return a + b
        }, 3, 5)
        
        
        //.函数类型作为返回类型
        var currentValue = 3
        var moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
        var s = moveNearerToZero(3)
        print(type(of: moveNearerToZero))
        
        moveNearerToZero = chooseStepFunction(backward: currentValue < 0)
        s = moveNearerToZero(3)
        print(type(of: moveNearerToZero))
        
        let moveNearerToZero2 = chooseStepFunction2(backward: currentValue > 0)
        moveNearerToZero2(2)

    }
    
    //1.函数参数与返回值
    func greet(person: String) -> String {
        let greeting = "Hello," + person + "!"
        return greeting
    }
    
    //2.无参数函数
    func sayHelloWorld() -> String {
        return "hello world"
    }
    
    //3.多参数函数
    func greet(_ person: String,alreadyGreeted: Bool) -> String {
        if alreadyGreeted {
            return "已经打过招呼了"
        } else {
            return ""
        }
    }
    
    //4.无返回值函数:严格上来说，虽然没有返回值被定义，greet(person:) 函数依然返回了值。没有定义返回类型的函数会返回一 个特殊的 Void 值。它其实是一个空的元组(tuple)，没有任何元素，可以写成()。 官方定义： public typealias Void = ()
    func greet(Jack: String) {
        
    }
    
    //5.多重返回值函数：用元组(tuple)类型让多个值作为一个复合值从函数中返回
    func minMax(_ array: [Int]) -> (min: Int, max: Int) {
        var currentMin = array[0]
        var currentMax = array[0]
        
        for value in array[1..<array.count] {
            
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            } }
        return (currentMin, currentMax)
    }
    
    //6.默认参数值
    func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
        // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
        print(parameterWithDefault)
    }
    
    //7.函数参数标签和参数名称(指定参数标签、忽略参数标签)
    func someFunction(firstParameterName: Int, secondParameterName second: Int, _ third: Int) {
        // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
    }
    
    //8.可变参数: 一个函数最多只能拥有一个可变参数。通过在变量类型名后面加入( ... )的方式来定义可变参数
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    //9.输入输出参数 inout(注意 输入输出参数不能有默认值，而且可变参数不能用inout标记。)
    func swapTwoInts(_ a: inout Int, _ b: inout Int)  {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    //10.函数类型
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    
    //11.函数类型作为参数类型: 函数类型作为另一个函数的参数类型
    func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
        print("Result: \(mathFunction(a, b))")  //调用mathFunction 函数
    }
    
    func printMathResult2(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {

        print("---")     //没有调用mathFunction 函数
    }
    
    //12.函数类型作为返回类型
    func stepForward(_ input: Int) -> Int {
        return input + 1
    }
    
    func stepBackward(_ input: Int) -> Int {
        return input - 1
    }
    
    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        return backward ? stepBackward : stepForward
    }
    
    //13.嵌套函数
    func chooseStepFunction2(backward: Bool) -> (Int) -> Int {
        
        func stepForward2(input: Int) -> Int {
            return input + 1
        }
        
        func stepBackward2(input: Int) -> Int {
            return input - 1
        }
        
        return backward ? stepBackward2 : stepForward2
    }
}

//MARK: - 闭包
extension ViewController {
    /*
     闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块(b
     locks)以及其他一些编程语言中的匿名函数比较相似。
     
     闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量。 Swift 会为你管理在捕获 过程中涉及到的所有内存操作。
     
    • 全局函数是一个有名字但不会捕获任何值的闭包
    • 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
    • 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包

     Swift 的闭包表达式拥有简洁的风格，并鼓励在常见场景中进行语法优化，主要优化如下:
     • 利用上下文推断参数和返回值类型
     • 隐式返回单表达式闭包，即单表达式闭包可以省略 return 关键字 
     • 参数名称缩写
     • 尾随闭包语法

    */
    
    func testBlock01()  {
        //1.sorted 方法:Swift 标准库提供了名为 sorted(by:) 的方法，它会根据你所提供的用于排序的闭包函数将已知类型数组中的 值进行排序。一旦排序完成，sorted(by:) 方法会返回一个与原数组大小相同，包含同类型元素且元素已正确排 序的新数组。原数组不会被 sorted(by:) 方法修改。
        //sorted(by:) 方法接受一个闭包，该闭包函数需要传入与数组元素类型相同的两个值，并返回一个布尔类型值来 表明当排序结束后传入的第一个参数排在第二个参数前面还是后面。如果第一个参数值出现在第二个参数值前 面，排序闭包函数需要返回 true ，反之返回 false 。

        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        //        names.sorted(by: <#T##(String, String) -> Bool#>)

        func backward(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        var reversedNames = names.sorted(by: backward)
        print("reversedNames = \(reversedNames)")
        
        //2.闭包表达式参数 可以是 in-out 参数，但不能设定默认值。也可以使用具名的可变参数(译者注:但是如果可变 参数不放在参数列表的最后一位的话，调用闭包的时时编译器将报错。可参考这里)。元组也可以作为参数和返 回值。
        reversedNames = names.sorted { (a, b) -> Bool in
            print("a = \(a), b = \(b)")

            return a > b
        }
        print("reversedNames = \(reversedNames)")

        //3.内联闭包。
        reversedNames = names.sorted(by: { (a, b) -> Bool in a > b })
        print("reversedNames = \(reversedNames)")

        //4.根据上下文推断类型
        reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
        
        //5.单表达式闭包隐式返回
        //单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果
        reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
        
        //6.参数名称缩写: Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0 ， $1 ， $2 来顺序调用闭包的参数，以 此类推。
        reversedNames = names.sorted(by: { $0 > $1 } )
        
        //7.运算符方法
        reversedNames = names.sorted(by: >)
        
        //8.尾随闭包
        func someFunctionThatTakesAClosure(clouse: () -> Void) {
            // 函数体部分
        }
        
        // 以下是不使用尾随闭包进行函数调用
        // someFunctionThatTakesAClosure(clouse: <#T##() -> Void#>)
        someFunctionThatTakesAClosure {
            // 闭包主体部分
        }
        
        someFunctionThatTakesAClosure(clouse: {
            // 闭包主体部分
        })
        
        
        // 以下是使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure() {
            // 闭包主体部分
        }
        
    
        reversedNames = names.sorted() { $0 > $1 }
        reversedNames = names.sorted { $0 > $1 }
        
        //Swift 的 Array 类型有一 个 map(_:) 方法，这个方法获取一个闭包表达式作为其唯一参数。该闭包函数会为数组中的每一个元素调用一 次，并返回该元素所映射的值。具体的映射方式和返回值类型由闭包来指定。
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        
        let numbers = [16, 58, 510]
        
        let strings = numbers.map {
            (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        print(strings)
        
        //值捕获
        //闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
        let incrementByTen = makeIncrementer(forIncrement: 10)
        print(type(of: incrementByTen))
        print(incrementByTen())
        print(incrementByTen())
        print(incrementByTen())
        
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        incrementBySeven()
        
        print(incrementByTen())
        
        //如果你将闭包赋值给一个类实例的属性，并且该闭包通过访问该实例或其成员而捕获了该实例，你将在闭包和该 实例间创建一个循环强引用。Swift 使用捕获列表来打破这种循环强引用
        
        //9.闭包是引用类型
        //上面的例子中，incrementBySeven 和 incrementByTen 都是常量，但是这些常量指向的闭包仍然可以增加其捕 获的变量的值。这是因为函数和闭包都是引用类型。
        //上面的例子中，指向闭包的引用 incrementByTen 是一个常量，而并非闭包内容本身。
        
        //这也意味着如果你将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包:
        let alsoIncrementByTen = incrementByTen
        alsoIncrementByTen() //50
        
        //10.逃逸闭包: 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才hui被执行，我们称该闭包从函数中逃逸
        //当 你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping ，用来指明这个闭包是允许“逃逸”出 这个函数的。
        
        var completionHandlers: [() -> Void] = []
        
        func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
            completionHandlers.append(completionHandler)
        }

        func someFunctionWithEscapingClosure2(completionHandler:  () -> Void) {
            //completionHandlers.append(completionHandler)
            
            completionHandler()
        }
        
        func someFunctionWithEscapingClosure3(completionHandler: @escaping () -> Void) {
            completionHandler()
        }
        
        someFunctionWithEscapingClosure3 { 
            print("调用逃逸闭包")
        }
        
        someFunctionWithEscapingClosure2 { 
            print("调用非逃逸闭包")

        }
        
        //测试逃逸闭包
        func testClouse(clouse: @escaping () -> Void) {
            print("1")
            print("2")
            print("3")
            print("4")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                //1秒后操作
                clouse()//当函数体执行完了 才会执行闭包（当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才hui被执行，我们称该闭包从函数中逃逸）
            }
            
            print("5")
            print("6")
            print("7")
            
            return
        }

        testClouse {
            print("逃逸闭包")
        }
        
        let instance = SomeClass()
        instance.doSomething()
        print(instance.x)
        // 打印出 "200"
        completionHandlers.first?()
        print(instance.x)
        // 打印出 "100"
        
        //11.自动闭包
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // 打印出 "5"
        let customerProvider = {
            customersInLine.remove(at: 0)
        }
        print(customersInLine.count)
        
        print(type(of: customerProvider))  //  () -> String
        // 打印出 "5"
        
        let  testClouse11 = {
            print("测试自动闭包")
        }
        
        print("Now serving \(customerProvider())!") // Prints "Now serving Chris!"
        print(customersInLine.count)
        
        print(type(of: testClouse11))   //() -> ()
        testClouse11()
        
        //将闭包作为参数传递给函数时，你能获得同样的延时求值行为。
        // customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
        func serve(customer customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        
        serve(customer: { customersInLine.remove(at: 0) } ) // 打印出 "Now serving Alex!"

    }
    
    
    
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        //print("type of = \(type(of: runningTotal)), runningTotal = \(runningTotal)")

        func incrementer() -> Int {
            runningTotal += amount
            
            print("type of = \(type(of: runningTotal)), runningTotal = \(runningTotal)")

            return runningTotal
        }
        return incrementer
    }
    
    
}


//将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self 。比如说，在下面的代码中，传递到 s omeFunctionWithEscapingClosure(_:) 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 self 。相对 的，传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包，这意味着它可以隐式引 self 。
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
    
    func someFunctionWithNonescapingClosure(closure: () -> Void) {
        closure()
    }
    
    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
}







