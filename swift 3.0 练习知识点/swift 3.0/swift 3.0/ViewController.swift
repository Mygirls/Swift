//
//  ViewController.swift
//  swift 3.0
//
//  Created by JQ on 2017/8/31.
//  Copyright © 2017年 majq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    
        subscripMethod()
        
        inheritMethod()
        
        initMethod()
        
        test2()
        
    }

   
}

//MARK: - 下标语法
extension ViewController {

    /**
 定义下标使用 subscript 关键字，指定一个或多个输入参数 和返回类型;与实例方法不同的是，下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，有点类 似计算型属性:
 
    */
    //下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取
    fileprivate func subscripMethod() {
    
        //下标语法
        var threeTimeTable = TimesTable(multiplier: 3)
        threeTimeTable[1] = 5
        print(threeTimeTable[3])

        print(threeTimeTable[6])
        
        //下标选项
        var matrix = Matrix(rows: 2, columns: 2)
        matrix[0,1] = 1.5
        matrix[1,0] = 3.2
        
        print(matrix[1,1])
        
    }
    
    struct TimesTable {
        var multiplier: Int
//        只读下标的实现
//        subscript(index: Int) -> Int {
//            return multiplier * index
//        }
        
        //可读可写
        subscript(index: Int) -> Int {
        
            get {
                return multiplier * index
            }
            
            set (newValue) {
                multiplier = newValue + 1
            }
        }
    }
    
    //下标选项
    struct Matrix {
        let rows: Int, columns: Int
        var grid: [Double]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeating: 0.0, count: rows * columns)
        }
        
        func indexIsValidForRow(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }
        
        subscript(row: Int, column: Int) -> Double {
            get {
                assert(indexIsValidForRow(row: row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValidForRow(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }
}

//MARK: - 继承
extension ViewController {
    fileprivate func inheritMethod() {
    
        //1. 定义基类
        let someVehicle = Vehicle()
        print("Vehicle: \(someVehicle.description)")
        
        //2. 子类生成
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        print("Bicycle: \(bicycle.description)")
        
        let tandem = Tandem()
        tandem.hasBasket = true
        tandem.currentNumberOfPassengers = 2
        tandem.currentSpeed = 22.0
        print("Tandem: \(tandem.description)")
        
        //3. 重写
        //子类可以为继承来的实例方法，类方法，实例属性，或下标提供自己定制的实现。我们把这种行为叫重写。
        //3.1 访问超类的方法，属性及下标
        /*
 
         在合适的地方，你可以通过使用 super 前缀来访问超类版本的方法，属性或下标:
         • 在方法 someMethod() 的重写实现中，可以通过 super.someMethod() 来调用超类版本的 someMethod() 方法。
         • 在属性 someProperty 的 getter 或 setter 的重写实现中，可以通过 super.someProperty 来访问超类版本的 someProperty 属性。
         • 在下标的重写实现中，可以通过 super[someIndex] 来访问超类版本中的相同下标。

         
        */
        
        let train = Train()
        train.makeNoise()
        
        //3.2 重写属性
        //你可以重写继承来的实例属性或类型属性，提供自己定制的 getter 和 setter，或添加属性观察器使重写的属性 可以观察属性值什么时候发生改变。
        /*
         你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即 可。但是，你不可以将一个继承来的读写属性重写为一个只读属性。

         注意；
         如果你在重写属性中提供了 setter，那么你也一定要提供 getter。
         如果你不想在重写版本中的 getter 里修改 继承来的属性值，你可以直接通过 super.someProperty 来返回继承来的值，其中 someProperty 是你要重写的属 性的名字。

         */
        let car = Car()
        car.currentSpeed = 25.0
        car.gear = 3
        print("Car: \(car.description)")
        
        //3.3 重写属性观察器
        let automatic = AutomaticCar()
        automatic.currentSpeed = 35.0
        print("AutomaticCar: \(automatic.description)")
        // 打印 "AutomaticCar: traveling at 35.0 miles per hour in gear 4"

        //3.4 防止重写: 属性或下标标记为 final  来防止它们被重写，只需要在声明关键字前加上 final  修饰符即 可
    
        //你可以通过在关键字  class 前添加   final 修饰符(   )来将整个类标记为 final 的。这样的类是不可 被继承的，试图继承这样的类会导致编译报错。
    
    
    }
    
    /*
     
     1. 一个类可以继承另一个类的方法，属性和其它特性。当一个类继承其它类时，继承类叫子类，被继承类叫超 类(或父类)。
     在 Swift 中，继承是区分「类」与其它类型的一个基本特征。
     
     2. 注意
     Swift 中的类并不是从一个通用的基类继承而来。如果你不为你定义的类指定一个超类的话，这个类就自动成为 基类。
     
     */
    
    class Vehicle {
        final var  testFinalProperty: String = ""
        var currentSpeed = 0.0
        var description: String {
            return "traveling at \(currentSpeed) miles per hour"
        }
        
        var testProperty: String {
            set {
                self.testProperty = "这是属性set 方法"
            }
            
            get {
                return "这是属性get 方法"
            }
        }
        
        func makeNoise() {
            // 什么也不做-因为车辆不一定会有噪音
            print("基类")
        }
    }
    
    //子类生成指的是在一个已有类的基础上创建一个新的类。子类继承超类的特性，并且可以进一步完善。你还可以为子类添加新的特性
    class Bicycle: Vehicle {
        var hasBasket = false
    }
    
    //子类还可以继续被其它类继承
    class Tandem: Bicycle {
        var currentNumberOfPassengers = 0
    }
    
    //重写方法
    class Train: Vehicle {
        override func makeNoise() {
            super.makeNoise()
            print("choo choo")
        }
    }
    
    class Car : Vehicle {
        var gear = 1
        override var description: String {
            return super.description + " in gear \(gear)"
        }
        
        override var testProperty: String {
            set (v) {
            }
            get {
                return super.testProperty
            }
        }
    }
    
    class AutomaticCar: Car {
        override var currentSpeed: Double {
            didSet {
                gear = Int(currentSpeed / 10.0) + 1
            }
        }
    }
    
    class Bike: Vehicle {
        
        //报错： final 修饰的属性 不能继承  var  override a 'final' var
//        override var testFinalProperty: String {
//            set {
//            
//            }
//            
//            get {
//            
//                return ""
//            }
//        }
    }

}

//MARK: - 构造过程
extension ViewController {
    /* 
        构造过程是使用类、结构体或枚举类型的实例之前的准备过程。
        在新实例可用前必须执行这个过程，
        具体操作包括设置实例中每个存储型属性的初始值和执行其他必须的设置或初始化工作。
     
     */
    
    fileprivate func initMethod() {
        test1()
    }
    
    
    private func test1() {
        /*
         1>存储属性的初始赋值:
            1.你可以在构造器中为存储型属性赋初值，也可以在定义属性时为其设置默认值
            2.类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态
            3. 当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察
         
         2>构造器:
            4.构造器在创建某个特定类型的新实例时被调用。它的最简形式类似于一个不带任何参数的实例方法，以关键字 init 命名
         
         3>默认属性值:
            5.如果一个属性总是使用相同的初始值，那么为其设置一个默认值比每次都在构造器中赋值要好。
              两种方法的效果是一样的，只不过使用默认值让属性的初始化和声明结合得更紧密。
              使用默认值能让你的构造器更简洁、更清晰，且能通过默认值自动推导出属性的类型;同时，它也能让你充分利用默认构造器、构造器继承等特性，后续章节将讲到。

         4>自定义构造过程
            6.通过输入参数和可选类型的属性来自定义构造过程，也可以在构造过程中修改常量属性
            7.自定义 构造过程 时，可以在定义中提供构造参数，指定所需值的类型和名字。构造参数的功能和语法跟函数和方 法的参数相同。
         
         5>参数的内部名称和外部名称
            8.跟函数和方法参数相同，构造参数也拥有一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字。
            9.如果你在定义构造器时没有提供参数的外部名 字，Swift 会为构造器的每个参数自动生成一个跟内部名字相同的外部名
    
         6>不带外部名的构造器参数
            10.如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线( _ )来显式描述它的外部名，以此重写上面 所说的默认行为。
         
         7>可选属性类型
            11.如果你定制的类型包含一个逻辑上允许取值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为 它在之后某个时间点可以赋值为空——你都需要将它定义为 可选类型 。
                可选类型的属性将自动初始化为 nil ，表 示这个属性是有意在初始化时设置为空的。

         8>构造过程中常量属性的修改
            12.在构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改。
            13. 对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改;不能在子类中修改。
         
         9>默认构造器
            14.如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默 认构造器(default initializers)。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例。
         
         10>结构体的逐一成员构造器
            15.逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法,我们在调用逐一成员构造器时，通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值。
         
         11>值类型的构造器代理
            16.构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间的代码重复。
            17.构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型(结构体和枚举类型)不支持继承，所以构 造器代理的过程相对简单，因为它们只能代理给自己的其它构造器。类则不同，它可以继承自其它类(请参考继 承)，这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。
            18.对于值类型，你可以使用 self.init 在自定义的构造器中引用相同类型中的其它构造器。并且你只能在构造器内 部调用 self.init 。

         
         */
        
        var f = Fahrenheit()
        print("The default temperature is \(f.temperature)° Fahrenheit")
     
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        // boilingPointOfWater.temperatureInCelsius 是 100.0
        
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        // freezingPointOfWater.temperatureInCelsius 是 0.0
        
        
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        let halfGray = Color(white: 0.5)
        let orange = Color(0.5)
        
//        Color(red: <#T##Double#>, green: <#T##Double#>, blue: <#T##Double#>)
//        Color(white: <#T##Double#>)
//        Color.init(<#T##orange: Double##Double#>)
        
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        // 打印 "Do you like cheese?"
        cheeseQuestion.response = "Yes, I do like cheese."
        
        let p = Person(withName: "张三")
        print(p.name)
        
        let p2 = Person2()
        print(p2.name)
        
        let beetsQuestion2 = SurveyQuestion(text: "常量属性修改 How about beets?")
        beetsQuestion2.ask()
        // 打印 "How about beets?"
        beetsQuestion2.response = "I also like beets. (But not with cheese.)"
        
        //如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器
        let twoByTow =  Size(width: 2.0, height: 30.4)
        let size = Size()

        //注意 假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器 写到扩展( extension )中，而不是写在值类型的原始定义中。想查看更多内容，请查看扩展章节
        let size2 = Size(w: 2.0, h: 30.4)

       
    }
    
}

struct Fahrenheit {
    var temperature: Double
    init() {
        //如果不执行下面语句 会出现error：return from initializer without initializing all stored properties，意思是：没有初始化所有存储的属性

        temperature = 32.0
    }
}

struct Fahrenheit2 {
    var temperature = 32.0  //默认属性值

}

//构造参数
struct Celsius {
    
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}


struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
    
    init(_ orange: Double) {
        red   = orange
        green = orange
        blue  = orange
    }
}

struct Color2 {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
    
    init(_ orange: Double) {
        red   = orange
        green = orange
        blue  = orange
    }
}

class SurveyQuestion {
    var text: String
    var response: String? //当 SurveyQuestion 实例化时，它将自动赋值为 nil ，表明此字符串暂时还没有值。

    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}


class A : SurveyQuestion {
    
   
}



class Person  {
    var name: String!
    init(withName n: String) {
        name = n
    }
    
    init() {
        
    }
}

class Person2  {
    var name: String!
    
    init() {
        
    }
}



class SurveyQuestion2 { //构造过程中常量属性的修改
    let text: String
    var response: String? //当 SurveyQuestion 实例化时，它将自动赋值为 nil ，表明此字符串暂时还没有值。
    
    
    init(text: String) { //尽管 text 属性现在是常量，我们仍然可以在类的构造器中设置它的值:
        self.text = text
    }
    
    func ask() {
        print(text)
    }
    
}

struct Size {   //结构体的逐一成员构造器
    var width = 0.0, height = 0.0
    
    //如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器
    //如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器(如果是结构体，还将无法访问逐 一成员构造器)
    //这种限制可以防止你为值类型增加了一个额外的且十分复杂的构造器之后,仍然有人错误的使用 自动生成的构造器
//    init(w: Double, h: Double) {
//        width = w
//        height = h
//    }
}

extension Size {

    /*
        注意 假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器 写到扩展( extension )中，而不是写在值类型的原始定义中。想查看更多内容，请查看扩展章节
     */
    init(w: Double, h: Double) {
        width = w
        height = h
    }

}


struct Point {
    var x = 0.0, y = 0.0
}


//值类型的构造器代理
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//MARK: - 类的继承和构造过程
extension ViewController {

    /*
        1.类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。
        2.Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是
          指定构造器和便利构造器
     
        3.指定构造器是类中最主要的构造器。
          一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。
          每一个类都必须拥有至少一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个 条件
   
        类的指定构造器的写法跟值类型简单构造器一样:
        init(parameters) {
            statements
        }
     
        便利构造器也采用相同样式的写法，但需要在 init 关键字之前放置 convenience 关键字，并使用空格将它们俩分kai
        convenience init(parameters) {
            statements
        }
     
        类的构造器代理规则:
        
     
        规则 1 指定构造器必须调用其直接父类的的指定构造器。
        规则 2 便利构造器必须调用同类中定义的其它构造器。
        规则 3 便利构造器必须最终导致一个指定构造器被调用。
        一个更方便记忆的方法是:
            • 指定构造器必须总是向上代理
            • 便利构造器必须总是横向代理
     

     */
    
    fileprivate func  test2() {
        let animal = Animal()
        print(animal.description)
        
        let tiger = Tiger()
        print(tiger.description)
        
        print(animal.description)
        
        let dog = Dog()
        print(dog.description)

    }
    
}


class Animal {
    var name: String = "Animal"
    var description: String {
        return "name = \(name)"
    }
}

class Tiger: Animal {
    // 子类可以在初始化时修改继承来的变量属性，但是不能修改继承来的常量属性。
    override init() {
        super.init() //Tiger 的构造器 init() 以调用 super.init() 方法开始，这个方法的作用是调用 Tiger 的父类 Animal 的默 认构造器。这样可以确保 Tiger 在修改属性之前，它所继承的属性 name 能被 Animal 类初始化。在 调用 super.init() 之后，属性 name 的原值被新值 tiger 替换。
         name = "tiger"
    }
}

class Dog : Animal {
    
    override init() {
        
        //error: use of 'self' in property access  'name' before super.inif initializes self
        //print(name)
    }
    
    
}









