//
//  ViewController.swift
//  10_String
//
//  Created by cfzq on 2017/6/16.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let levels = "ABCDEF"
        for i  in levels.characters {
            print(i)
        }   //输出ABCDEF
        
        if levels.contains("BC") {
            print("包含字符串")
        }
        
        //很麻烦的地方 Range
        let nsRange = NSMakeRange(1,4)
        
        //编译错误：cannot convert valut of type 'NSRange'.Type(aka _NSRange.Type) to expected argument tyype Range <String.Index>...
        //levels.replacingCharacters(in: NSRange, with: "AAAA")
        let indexPositionOne = levels.characters.index(levels.startIndex, offsetBy: 1)
        //let indexPositionOne: String.Index
        let swiftRange = indexPositionOne ..< levels.characters.index(levels.startIndex, offsetBy: 5)//let swiftRange: Range<String.Index>

        let result = levels.replacingCharacters(in: swiftRange, with: "AAAA")
        print(result)   //AAAAAF
        
        //对于上述这么麻烦的问题 可以
        let result02 = (levels as NSString).replacingCharacters(in: nsRange, with: "AAAA")
        print(result02) //AAAAAF
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

