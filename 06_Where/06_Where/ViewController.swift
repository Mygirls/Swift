//
//  ViewController.swift
//  06_Where
//
//  Created by cfzq on 2017/6/9.
//  Copyright © 2017年 cfzq. All rights reserved.
//
/**
 where 和 模糊匹配
 
 */
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        test01()
    }
    
    func test01()  {
        //switch
        let name = ["王小二","张三","李四","王二小","老王"]
        name.forEach { (d) in
            print(d)
        }
        
        name.forEach {
        
            switch $0 {
            
            case let x where x.hasPrefix("王"):
                print(x)
                break
            default:
                break
                
            }
        
        }
        
       _ = name.map { (s) -> Void in
            
            switch s {
                
            case let x where x.hasPrefix("王"):
                print(x)
                break
            default:
                break
                
            }
        }
        
        //for 循环
        let num: [Int?] = [48,99,nil]
        let n = num.flatMap { $0        }
        for score in n where score > 60 {
            print("及格了 - \(score)")
        }
        
        //可选绑定
        num.forEach {
        
            if let score = $0,score > 60 {
                print("及格了 - \(score)")
            }else {
                print(":(")
            }
        }
        
        //
        let sortableArray: [Int] = [3,1,2,4,5,7,6]
        let unsortableArray:[Any?] = ["Hello",4,nil]
        let result = sortableArray.sorted()
        let result2 = unsortableArray.sorted { (a, b) -> Bool in
            
            //这里面输入一种排序方式
            print(a)
            print(b)
            return false
            
        }
        print(result)
        print(result2)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

