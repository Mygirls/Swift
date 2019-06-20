//
//  MProtocal.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/18.
//  Copyright © 2018年 Majq. All rights reserved.
//

import Foundation

protocol MPersonProtocal {
    associatedtype E
    func asObservable() -> Student<E>
}

protocol MStudentProtocal: MPersonProtocal {
    var name: String {get}
}

extension MStudentProtocal {
    func asObservable() -> Student<E> {
        return Student<Self.E>()
    }
    
    
    var name: String {
        return "zhangsan"
    }

    
}

class Student<T>: MStudentProtocal {
    
    var name: String = "李四"
    typealias E = T

    init() {
        
    }
    
    func asObservable() -> Student<T> {
        return self
    }
    
    
}

extension MStudentProtocal {
    public static func study(_ element: Self.E) {
        print("element = \(element)")
    }
    
    public static func paly(_ element: Self.E) -> Student<Self.E>
    {
        return Student<Self.E>()

    }
}

class School {
    func teach<T: MPersonProtocal>(student: T) -> Int {
        
        return 0
    }
}

