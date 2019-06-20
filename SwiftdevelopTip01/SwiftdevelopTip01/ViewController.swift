//
//  ViewController.swift
//  SwiftdevelopTip01
//
//  Created by cfzq on 2017/3/21.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit

//TODO: associatedtype 关联类型

//1
protocol Food {
   

}

protocol Animal {
    func eat(_ food: Food)
}

struct Meat: Food {
    
}

struct Grass: Food {
    
}


struct Tiger: Animal {
    func eat(_ food: Food) {
        if let meat  = food as? Meat {
            print("eat \(meat)")
        } else {
            print("tiger can only eat meat!")
        }
    }
}

//2
protocol Animal02 {
    associatedtype F    //忽略了被吃的必须是food 这个前提
    func eat(_ food: F)
}

struct Tiger02: Animal02 {
    typealias F = Meat
    func eat(_ food: Meat) {
        print("eat \(food)")
    }

}

//3
protocol Animal03 {
    associatedtype F: Food  //associatedtype 声明中可以使用冒号来指定类型满足某个协议
    func eat(_ food: F)
}

struct Tiger03: Animal03 {
    func eat(_ food: Meat) {    //不需要显示的写明F，会自动推断出来
        print("eat \(food)")
    }
}

struct Sheep: Animal03 {
    func eat(_ food: Grass) {   //不需要显示的写明F
        print("eat \(food)")
    }
}


//在添加associatedtype后，协议就不能当作独立的类型使用了


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        let  meat = Meat()
        Tiger().eat(meat)
    
    
        Tiger02().eat(meat)
        
        
        print(isDangerous(animal: Tiger03()))
        print(isDangerous(animal: Sheep()))
        
        print(sum(input: 1,2,3,4,5))

    }

    //4.错误：protocol 'Animal03' can only be used as a generic constraint because it has Self or associated type requirements 在一个协议中加了想associatedtype 或者self 的约束后，他将智能被用来为 泛型约束，而不能独立类型的占用使用，也失去了动态派发的类型
    //不确定Animal03 的类型
//    func isDangerous(animal: Animal03) -> Bool {
//        
//        if animal is Tiger03 {
//            return true
//        } else {
//            return false
//        }
//    }
    
    //改为
    func isDangerous<T: Animal03>(animal: T) -> Bool {

        if animal is Tiger03 {
            return true
        } else {
            return false
        }
    }
    
    
    
    
    
    //******************************************************
    //TODO: 可变参数函数
    
    func sum(input: Int...) -> Int {
        return input.reduce(0,+)
    }
    
    
    
    

}



