//
//  ViewController.swift
//  Swift4.0Demo
//
//  Created by hhxh on 2019/6/19.
//  Copyright © 2019 hhxh. All rights reserved.
//

import UIKit

struct Resolution {
    var height = 0
    var width = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = true
    var frameRate = 0.0
    var name: String?
    
}

class DataManager{
    var name =  Resolution()
}

struct SubscriptDemo {
    let a: Int
    subscript(index: Int) -> Int {
        
        return index * a
    }

}

struct Fahrenheit {
    var temp : Double
    init() {
        temp = 2
    }
}

struct Fahrenheit2 {
    var temp : Double
}

struct Fahrenheit3 {
    var temp : Double = 2
}

struct Fahrenheit4 {
    var temp : Double
    
    init(param:Double) {
        //Return from initializer without initializing all stored properties
        temp = 2
    }
    
    init(param1: Double,param2: Double) {
        temp = 2
    }
}

class SurveyQuestion {
    var text: String = "123"
}

class SurveyQuestion1 {
    //Class 'SurveyQuestion1' has no initializers
    //var text: String  //报错
}

class SurveyQuestion2 {
    //Class 'SurveyQuestion2' has no initializers
    var text: String?
}

class SurveyQuestion3 {
    var text: String
    init(text: String) {
        self.text = text
    }
}

class SurveyQuestion4 {
    let text: String
    init(text: String) {    //构造过程中常量属性的修改
        self.text = text
    }
}

class SurveyQuestion5: SurveyQuestion3 {
    var name: String = ""
    

    
}

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

class Person {
    let name: String
    init(name: String) { self.name = name }
//    var apartment: Apartment?
    weak var apartment: Apartment?

    deinit { print("\(name) is being deinitialized") }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let oneMysteryItem = RecipeIngredient()
        let oneBacon = RecipeIngredient(name: "Bacon")
//        let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
        
        
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        print("The width of someResolution is \(someResolution.width)")
        print("The width of someVideoMode is \(someVideoMode.resolution.width)")

        //逐一构造器
        let _ = Resolution(height: 320, width: 480)
        //与结构体不同，类实例没有默认的成员逐一构造器
        
        
        //结构体实例总是通过值传递，类实例总是通过引用传递
        
//        按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：
//
//        该数据结构的主要目的是用来封装少量相关简单数据值。
//        有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
//        该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
//        该数据结构不需要去继承另一个既有类型的属性或者行为
        
        let s =  SubscriptDemo(a: 3);
        print(s[8])
        
        Fahrenheit()
        
        Fahrenheit2(temp: 2)
        //Fahrenheit2()  //报错
        
        Fahrenheit3(temp: 3);
        Fahrenheit3()
        
        
        SurveyQuestion()
        SurveyQuestion2()
        SurveyQuestion3(text: "123");

        SurveyQuestion5(text: "")
        //SurveyQuestion5() //Missing argument for parameter 'text' in call
        
        var john: Person?
        var unit4A: Apartment?
        
        john = Person(name: "John Appleseed")
        unit4A = Apartment(unit: "4A")
        
        john!.apartment = unit4A
        unit4A!.tenant = john
        
        unit4A = nil
        john = nil

    }
 
}



