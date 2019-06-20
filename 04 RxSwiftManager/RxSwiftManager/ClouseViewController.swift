//
//  ClouseViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/7.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit

class ClouseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        

        clouseDemo()    //闭包
        
        throwDemo() //抛出异常
    }
    
    deinit {
        
        #if DEBUG
        print("\(self) 销毁了")
        #endif
    }

}


// MARK: - sorted 方法
extension ClouseViewController
{
    func clouseDemo() {
        
        sortDemo()      //闭包简写格式
        
        testAbbreviatedFormat()
        
        otherClouseUse()
    }
    
    func sortDemo() {
        //闭包表达式语法有如下的一般形式:
        //        { (parameters) -> returnType in
        //            <#code#>
        //        }
        
        //sorted(by:)
        //接受一个闭包，该闭包函数需要传入与数组元素类型相同的两个值，并返回一个布尔类型值来
        //表明当排序结束后传入的第一个参数排在第二个参数前面还是后面。
        //如果第一个参数值出现在第二个参数值前 面，排序闭包函数需要返回 true ，反之返回 false 。
        var names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        //1)    public mutating func sort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows
        names.sort { (v1, v2) -> Bool in
            return v1 > v2
        }
        
        //2)该例中 sorted(by:) 方法的整体调用保持不变，一对圆括号仍然包裹住了方法的整个参数。然而，参数现在变 成了内联闭包。
        //names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
        
        
        //3)因为排序闭包函数是作为 sorted(by:) 方法的参数传入的，
        //Swift 可以推断其参数和返回值的类型。
        //sorted(b y:) 方法被一个字符串数组调用，因此其参数必须是 (String, String) -> Bool 类型的函数。
        //这意味着 (Stri ng, String) 和 Bool 类型并不需要作为闭包表达式定义的一部分。
        //因为所有的类型都可以被正确推断，返回箭 头( -> )和围绕在参数周围的括号也可以被省略:
        //names.sorted(by: { s1, s2 in return s1 > s2 } )
        
        //4)单表达式闭包隐式返回
        //单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为:
        //names.sorted(by: { s1, s2 in s1 > s2 } )
        
        
        //5)参数名称缩写
        //Swift 自动为内联闭包提供了参数名称缩写功能，你可以直接通过 $0 ， $1 ， $2 来顺序调用闭包的参数，以 此类推。
        //如果你在闭包表达式中使用参数名称缩写，你可以在闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。
        //in 关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成:
        //names.sorted(by: { $0 > $1 } )
        
        print(names)    //["Ewa", "Daniella", "Chris", "Barry", "Alex"]
        
        //map 函数也是一样的
        //    public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
        //    public mutating func sort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows

    }
    
    /// 闭包简写格式测试(P.132)
    func testAbbreviatedFormat() {
        //闭包其实是一个函数，参数传递一个函数即可
        //test_01(b: <#T##((String) -> String)##((String) -> String)##(String) -> String#>)
        _ = test_01(b: test_0)
        print("---\(test_01(b: test_0))")
        
       //完整格式的闭包
        _ = test_01 { (value) -> String in
            print("value = \(value)")
            return  value + " world"
        }
        
        //********根据上下文推断类型********
        //其改写成一行代码
        _ = test_01(b: {(value) -> String in  return  value + " world"})
        
        //因为所有的类型都可以被正确推断，返回箭头( -> )和围绕在参数周围的括号也可以被省略:
        _ = test_01(b: { value in return value + " world"})

        //********单表达式闭包隐式返回********
        _ = test_01(b: { value in value + " world"})

        //********参数名称缩写********
        //闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。 in 关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成:
        _ = test_01 { $0 + " world"}
    }
    
    
   
    
    private func otherClouseUse() {
        // 以下是使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure {
        }
        
        // 以下是不使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure(closure: {
        })
            
    }
    
    
    
    
    /// 测试闭包：闭包作为参数，并有返回值
    ///
    /// - Parameter b: 闭包
    /// - Returns: String
    
    private func test_0(b: String) -> String {
        
        return "H"
    }
    
    private func test_01(b: ((String) -> String)) -> String {
        let s = b("Hello")
        
        print(s)
        return s
    }
    
    private func test_02(a: ((String) -> Void)? = nil,b: (((String) -> Void)),C c: (((String) -> Void))) {
        
    }
    
    private func test_03(b: ((String) -> Void)? = nil,a: String) {
        
    }

    private func someFunctionThatTakesAClosure(closure: ()  -> Void) { // 函数体部分
    }
}


// MARK: - 抛出异常
extension ClouseViewController {
    
    typealias ArrayErrorCallback = () throws -> Bool
    typealias StringErrorCallback = (String) throws -> String

    func throwDemo() {
        print("_________________抛出异常________________")
        /**
         *  跟其它语言一样，Swift的异常处理是在程序抛出异常后的处理逻辑。
         *  Swift提供了一流的异常抛出、捕获和处理的能力。跟Java语言类似， Swift的异常并不是真正的程序崩溃，
         *  而是程序运行的一个逻辑分支；Swift和Java捕获异常的时序也是一样的。当Swift运行时抛出异常后并没有被处理， 那么程序就会崩溃。
         *
         */
        
        //使用 do-catch 。在 do 代码块中，使用 try 来标记可以抛出错误 的代码。在 catch 代码块中，除非你另外命名，否则错误会自动命名为 error 。
        //抛出异常01
        do {
            try test_05(num: 2)
            
        } catch {
            print(error)
        }
        
        //抛出异常02
        do {
            try test_05(num: 2)
            
        } catch PrinterError.dataFail {
            print(PrinterError.dataFail.printError)
            print(PrinterError.dataFail.hashValue)

        } catch let printerError as PrinterError {
            print("Printer error: \(printerError).")

        } catch {
            print(error)
        }
        
        //抛出异常03
        //try? 将结果转换为可选的。如果函数抛出错误，该错误会被抛弃并且结果为 ni l 。否则的话，结果会是一个包含函数返回值的可选值。
        let t1 = try? test_06(num: 1)
        print(t1 as Any )
        
        let t2 = try? test_06(num: 2)
        print(t2 as Any )
        
        _ = test_07 { (s) -> Bool in s.isEmpty }

        
        //2、抛出异常
        getObjByIndex_01(index: 20) { (num) in
            print("num = \(num)")
        }
        
        getObjByIndex_02(index: 20) { (num) in
            print("取不到第\(num)个")
            print("done")
        }
        
        getObjByIndex_03(index: 20) { (inner: StringErrorCallback) in
            
            do {
                let success = try inner("2")
                print(success)
            } catch {
                print(error)
            }
        }
        
        checkObjectById(index:20) { (inner: ArrayErrorCallback) -> Void in
            do {
                let success = try inner()
                print(success)
            } catch {
                print(error)
            }
            
        }
        
        

    }
    
    func test_05(num: Int)  throws {
        if num == 1 {
            print("success")
        }
        else {
            throw PrinterError.dataFail
        }
    }
    
    func test_06(num: Int) throws -> String {
        if num == 1 {
            return "success"
        }
        else {
            throw PrinterError.dataFail
        }
    }
    
    
}


// MARK: - 模仿rx 里面的异常
extension ClouseViewController
{
    //    public func filter(_ predicate: @escaping (Self.E) throws -> Bool) -> RxSwift.Observable<Self.E>
    func test_07(_ params: @escaping (String) throws -> Bool) -> String {
        let b = try? params("Hello")
        guard let temp = b else { return "nil" }
        
        return "\(temp)"
    }
    
    
    //模仿rx 里面的方法。闭包里面抛出异常
    func getObjByIndex_01(index: Int,num: (Int) -> Void) {
        num(index)
    }
    
    //模仿rx 里面的方法。闭包里面抛出异常
    func getObjByIndex_02(index: Int,num: @escaping (Int) throws -> Void) {
        
        let array = [1,2,3,4]
        if index > array.count {
            do {
                try num(index)
                
            } catch {
                print(PrinterError.otherFail.printError)
            }
            
        } else {
            
        }
    }
    
    //模仿rx 里面的方法。闭包里面抛出异常[闭包里面的参数inner也是闭包]
    //    typealias StringErrorCallback = (String) throws -> String
    func getObjByIndex_03(index: Int,num: @escaping (_ inner: StringErrorCallback)  -> Void) {
        
        let array = [1,2,3,4]
        if index > array.count {
            
            let temp: (String) throws -> String = { _ in throw PrinterError.otherFail
            }
            num(temp)
            
        } else {
            let temp: (String) throws -> String = { (s) throws -> String in
                return "\(index)"
            }
            num(temp)
            
            //或者可以简写成
            //            num({ (s) throws -> String in
            //                return "\(index)"
            //            })
            
        }
    }
    
    //模仿rx 里面的方法。闭包里面抛出异常
    //    typealias ArrayErrorCallback = () throws -> Bool
    func checkObjectById(index:Int, errorBlock:@escaping (_ inner:ArrayErrorCallback) -> Void) {
        let array = [1,2,3,4,5]
        if index < array.count {
            // throw error
            errorBlock({ throw PrinterError.otherFail })
        }
        // return value
        errorBlock({return true})
    }
}
enum PrinterError: Error {
    case dataFail
    case netFail
    case otherFail

    var printError: String {
        
        switch self {
            
        case .dataFail:
            return " 数据 failed"
        case .netFail:
            return " 网络 failed"
        case .otherFail:
            return " 其他 failed"
        }
        
    }
}

extension ClouseViewController
{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("控制器2 viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("控制器2 viewWillDisappear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("控制器2 viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("控制器2 viewDidDisappear")
    }
}
