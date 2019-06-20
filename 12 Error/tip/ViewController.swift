//
//  ViewController.swift
//  tip
//
//  Created by JQ on 2017/8/18.
//  Copyright © 2017年 majq. All rights reserved.
//

import UIKit

enum PrinterError: Error {
    case OutOfPaper
    case NoToner
    case OnFire
}

// 重新实现 Swift 标准库中的可选类型
enum OptionalValue<Wrapped> {
    case None
    case Some(Wrapped)
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        config()
    }


    private func config() {
        testError()
        
        testParadigm()
    }
}

//MARK: - Error
extension ViewController {
    
    fileprivate func testError() {
        //TODO: - 1.do-catch
        //使用 do-catch 。在 do 代码块中，使用 try 来标记可以抛出错误 的代码。在 catch 代码块中，除非你另外命名，否则错误会自动命名为 error 。
        do {
            let printerResponse = try send(job: 400, toPrinter: "Bi Sheng")
            print(printerResponse)
        } catch  {
            print(error)
        }
        
        do {
            let printerResponse = try send(job: 400, toPrinter: "Never Has Toner")
            print(printerResponse)
        } catch  {
            print(error)
        }
        
        do {
            let printerResponse = try send(job: 1440, toPrinter: "Never Has Toner")
            print(printerResponse)
            
        } catch PrinterError.OnFire {
            print("I'll just put this over here, with the rest of the fire.")
            
        } catch let printerError as PrinterError {
            print("Printer error: \(printerError).")
            
        } catch {
            print(error)
        }
        
        do {
            let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
            print(printerResponse)
            
        } catch PrinterError.OnFire {
            print("I'll just put this over here, with the rest of the fire.")
            
        } catch let printerError as PrinterError {
            print("Printer error: \(printerError).")
            
        } catch {
            print(error)
        }
        
        //TODO: - 2.try?
        //将结果转换为可选的。如果函数抛出错误，该错误会被抛弃并且结果为 ni l 。否则的话，结果会是一个包含函数返回值的可选值。
        let faile = try? send(job: 2, toPrinter: "Never Has Toner")
        let success = try? send(job: 2, toPrinter: "Toner")
        
        print("faile = \(faile)")
        print("success = \(success)")
        
        //TODO: - 3.defer
        //使用 defer 代码块来表示在函数返回前，函数中最后执行的代码。无论函数是否会抛出错误，这段代码都将执 行。使用 defer ，可以把函数调用之初就要执行的代码和函数调用结束时的扫尾代码写在一起，虽然这两者的执 行时机截然不同
        var fridgeIsOpen = false
        let fridgeContent = ["milk", "eggs", "leftovers"]
        func fridgeContains(_ food: String) -> Bool {
            fridgeIsOpen = true
            print(fridgeIsOpen)

            defer {
                fridgeIsOpen = false
            }
            let result = fridgeContent.contains(food)
            return result
        }
        let _ = fridgeContains("banana")
        print(fridgeIsOpen)
    }
    
    private func send(job: Int, toPrinter printerName: String) throws -> String {
        if printerName == "Never Has Toner" {
            throw PrinterError.NoToner
        }
        return "Job sent"
    }
    
    private func sendTest1(job: Int, toPrinter printerName: String) throws {
        try sendTest2(job: job, toPrinter: printerName)
    }
    
    private func sendTest2(job: Int, toPrinter printerName: String) throws {
        
    }
    
}

//MARK: - 范型
extension ViewController {

    fileprivate func testParadigm() {
    
        let s = repeatItem(repeating: "knock", numberOfTimes:4)
        print(s)
        
        var possibleInteger: OptionalValue<Int> = .None
        possibleInteger = .Some(100)
        
        let _ = anyCommonElements([1, 2, 3], [3])
    }
    
    private func repeatItem<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
        var result = [Item]()
        for _ in 0..<numberOfTimes {
            result.append(item)
        }
        return result
    }
    
    private func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
        where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
            for lhsItem in lhs {
                for rhsItem in rhs {
                    if lhsItem == rhsItem {
                        return true
                    } }
            }
            return false
    }
  
}
