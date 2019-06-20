//
//  ViewController.swift
//  swift 3.0
//
//  Created by JQ on 2017/8/29.
//  Copyright © 2017年 majq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var propertyName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpConfig()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpConfig() {
    
        testEnum()
        
        testClass()
        
        someKnowledge()
        
        propertyTest()
    }


}


//MARK: - 枚举
extension ViewController {

    //1.枚举语法
    //与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在例子中， north ， south ， east 和 west 不会被隐式地赋值为 0 ， 1 ， 2 和 3 。相反，这些枚举成员本身 就是完备的值，这些值的类型是已经明确定义好的 CompassPoint 类型。
    enum CompassPoint {
        case north
        case south
        case east
        case west
    }
    
    enum Planet {
        case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
    }
    
    //2.关联值
    //定义一个名为 Barcode 的枚举类型，它的一个成员值是具有 (Int，Int，Int，Int) 类型关联值的 upc ，另一个 成员值是具有 String 类型关联值的 qrCode 。
    enum Barcode {
        case upc(Int, Int, Int, Int)
        case qrCode(String)
    }
    //这个定义不提供任何 Int 或 String 类型的关联值，它只是定义了，当 Barcode 常量和变量等于 Barcode.upc 或 B arcode.qrCode 时，可以存储的关联值的类型。
    
    //3.原始值
    enum ASCIIControlCharacter: Character {
        case tab = "\t"
        case lineFeed = "\n"
        case carriageReturn = "\r"
    }
    
    enum Name: String {
        case school
        case city
        case country
    }

    //4.递归枚举
    enum ArithmeticExpression {
        case number(Int)
        indirect case addition(ArithmeticExpression, ArithmeticExpression)
        indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
    }
    
    indirect enum ArithmeticExpression2 {
        case number(Int)
        case addition(ArithmeticExpression2, ArithmeticExpression2)
        case multiplication(ArithmeticExpression2, ArithmeticExpression2)
    }
    
    //每个枚举定义了一个全新的类型。像 Swift 中其他类型一样，它们的名字(例如 CompassPoint 和 Planet )应该 以一个大写字母开头。给枚举类型起一个单数名字而不是复数名字，以便于读起来更加容易理解:
    
    fileprivate func testEnum() {
        var directionToHead = CompassPoint.west
        directionToHead = .east
        print(directionToHead.hashValue)
        
        directionToHead = .west
        print(directionToHead.hashValue)
        
        //1.使用 Switch 语句匹配枚举值
        switch directionToHead {
        case .north:
            break
        case .south:
            break
        case .west:
            break
        case .east:
            break

        }
        
        switch directionToHead {
        case .north:
            break
        default:
            break
        }
        
        //2.关联值
        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        print(type(of: productBarcode))
        print(productBarcode)
        
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        print(type(of: productBarcode))
        print(productBarcode)
        //原始的 Barcode.upc 和其整数关联值被新的 Barcode.qrCode 和其字符串关联值所替代。 Barcode 类型的常 量和变量可以存储一个 .upc 或者一个 .qrCode (连同它们的关联值)，但是在同一时间只能存储这两个值中的一 个。
        print("---")
        // Barcode.upc(<#T##Int#>, <#T##Int#>, <#T##Int#>, <#T##Int#>)
        // Barcode.qrCode(<#T##String#>)
        
        switch productBarcode {
        case .upc(let numberSysytem, let manufacturer, let product, let check):
            print("upc = \(numberSysytem),\(manufacturer),\(product),\(check)")
        case .qrCode(let productcode):
            print("qrCode = \(productcode)")
        }
        
//        switch productBarcode {
//        case .qrCode(<#T##String#>):
//            break
//        case.upc(<#T##Int#>, <#T##Int#>, <#T##Int#>, <#T##Int#>) :
//            break
//        }
        
        //如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个let或者var
        switch productBarcode {
        case let .upc(a,b,c,d):
            print("upc = \(a),\(b),\(c),\(d)")
        case let .qrCode(productcode):
            print("qrCode = \(productcode)")

        }
        
        //3.原始值: 使用枚举成员的 rawValue 属性可以访问该枚举成员的原始值
        //原始值可以是字符串，字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。
        //3.1 原始值的隐式赋值: 在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为 你赋值
        enum Planet: Int {
            case mercury = 1,venus, earth, mars, jupiter, saturn, uranus, neptune
        }
        print(Planet.venus.rawValue)
        print(Planet.mars.rawValue)
        
        
        print(Name.school.rawValue)
        print("类型 = \(type(of: Name.school.rawValue))，Name 类型 = \(type(of: Name.self))")
        print(Name.country.rawValue)
        
        //3.2 使用原始值初始化枚举实例
        //如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，这个方法接收一个叫做 rawValue 的参数，参数类型即为原始值类型，返回值则是枚举成员或 nil 。你可以使用这个初始化方法来创建一个新的枚 举实例

//        Name(rawValue: <#T##String#>)
        let possibleName = Name(rawValue: "school")
        
        print("\(String(describing: possibleName)), \(type(of: possibleName))")
        //Optional(swift_3_0.ViewController.Name.school), Optional<Name>

        guard let a  = possibleName else { return  }
        print(a)    //school
        switch a {
        case .city:
            break
        default:
            break
        }
        
        //原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员。更多信息请参见可失败
        let positionToFind = 11
        if let somePlanet = Planet(rawValue: positionToFind) {
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        } else {
            print("There isn't a planet at position \(positionToFind)")
        }
        
        //4 递归枚举
        //递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上 indirect 来表示该成员可递归。
        //你也可以在枚举类型开头加上 indirect 关键字来表明它的所有成员都是可递归的:
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        print(product)
        //要操作具有递归性质的数据结构，使用递归函数是一种直截了当的方式。例如，下面是一个对算术表达式求值的函数:
        print(evaluate(product)) //18

    }
    
    func evaluate(_ expression: ArithmeticExpression) -> Int {
        switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            print("left = \(left),right = \(right)")
            
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            print("left = \(left),right = \(right)")

            return evaluate(left) * evaluate(right)
        }
    }
}

//MARK: - 类和结构体
extension ViewController {

    /*
    注意
    在你每次定义一个新类或者结构体的时候，实际上你是定义了一个新的 Swift 类型。因此请使用
    UpperCammelCase 这种方式来命名(如 SomeClass 和 SomeStructure 等)，以便符合标准 Swift 类型的大写命名风格(如 String ， Int 和 Bool )。
     相反的，请使用 lowerCamelCase 这种方式为属性和方法命名(如 framerate 和 Count )，以便和类型名区分。
 
    */
    class SomeClass {
        
    }
    
    struct SomeStruct {
        
    }
    
    struct Resolution {
        var with = 0
        var height = 0
    }
    
    class VideoMode: NSObject {
        var resolution = Resolution()
        var interlaced = false
        var frameRate = 0.0
        var name: String?
        
    }
    
    struct Test {
        var property = 0
    }
    
    
    fileprivate func testClass() {
    
        print("---------类和结构体--------------")
        /*
        Swift 中类和结构体有很多共同点。共同处在于:
        • 定义属性用于存储值
        • 定义方法用于提供功能
        • 定义下标操作使得可以通过下标语法来访问实例所包含的值
        • 定义构造器用于生成初始化值
        • 通过扩展以增加默认实现的功能
        • 实现协议以提供某种标准功能
         
         与结构体相比，类还有如下的附加功能:
         • 继承允许一个类继承另一个类的特征
         • 类型转换允许在运行时检查和解释一个类实例的类型 
         • 析构器允许一个类实例释放任何其所被分配的资源
         • 引用计数允许对一个类的多次引用

        */
        
        //1.定义语法
        
        //1.1 类和结构体实例: 生成结构体和类实例的语法非常相似
        var someResolution = Resolution()

//        Resolution(with: <#T##Int#>, height: <#T##Int#>)
//        Resolution()
        let someVideoMode = VideoMode() //通过这种方式所创建的类或者结构体实例，其属性均会被初始化为 默认值
        
        //2. 属性访问: 通过使用点语法，你可以访问实例的属性。其语法规则是，实例名后面紧跟属性名，两者通过点号( . )连接
        print("someResolution.height = \(someResolution.height)")
        print("someResolution.with = \(someResolution.with)")
        print("someResolution.with = \(someVideoMode.resolution.height)")

        //someVideoMode.resolution.height  直接这么写报错： expression resolves to an unused l-value
        //因为swift 认为这是一个错误，因为在if条件下惟一表达式的左手边值没有被使用。这一行发出警告，因为您只需访问该值，从不在应用程序中打印或使用它，从而使它不使用访问值和警告。
        //点语法为变量属性赋值:
        someVideoMode.resolution.height = Int(2.0)
        
        //3. 结构体类型的成员逐一构造器: 所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中:
        let _ = Resolution(with: 2, height: 2) //Resolution(with: <#T##Int#>, height: <#T##Int#>)
        //与结构体不同，类实例没有默认的成员逐一构造器
        
        //4. 结构体和枚举是值类型: 值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
        //实际上，在 Swift 中，所有的基本类型:整数(Integer)、浮 点数(floating-point)、布尔值(Boolean)、字符串(string)、数组(array)和字典(dictionary)，都是 值类型，并且在底层都是以结构体的形式所实现。
        let  hd = Resolution(with: 1920, height: 1080)
        var cinema = hd
        //然后示例中又声明了一个名为 cinema 的变量，并将 hd 赋值给它。因为 Resolution 是一个结构体，所以 的值其实是 hd 的一个拷贝副本，而不是 hd 本身。尽管 hd 和 cinema 有着相同的宽(width)和高(heigh t)，但是在幕后它们是两个完全不同的实例。
        
        cinema.with = 2048  //实际上是将 hd 中所存储的值进行拷贝
        print("cinema is now \(cinema.with) pixels wide, hd is now \(hd.with )")
        
        var currentDirection = CompassPoint.west
        let rememberedDirection = currentDirection
        currentDirection = .east
        if rememberedDirection == .west {
            print("The remembered direction is still .West")
        }
        // 打印 "The remembered direction is still .West"
        
        //5. 类是引用类型: 与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        print(tenEighty)
        let alseTenEighty = tenEighty //因为类是引用类型，所以 tenEight 和 alsoTenEight 实际上引用的是相同的 VideoMode 实例。换句话说，它们是 同一个实例的两种叫法
        print(alseTenEighty)

        alseTenEighty.frameRate = 30.0
        print(alseTenEighty)    //地址都不会发生变化

        print("alseTenEighty.frameRate = \(alseTenEighty.frameRate), tenEighty.frameRate = \(tenEighty.frameRate)")
        
        //需要注意的是 tenEighty 和 alsoTenEighty 被声明为常量而不是变量。然而你依然可以改变 tenEighty.frameRate 和 alsoTenEighty.frameRate ，因为 tenEighty 和 alsoTenEighty 这两个常量的值并未改变。它们并不“存储”这 个 VideoMode 实例，而仅仅是对 VideoMode 实例的引用。所以，改变的是被引用的 VideoMode 的 frameRate 属 性，而不是引用 VideoMode 的常量的值。
        print(tenEighty.description)
        
        //TODO: - clas 继承NSObject 的区别
        
        //6. 恒等运算符 : 因为类是引用类型，有可能有多个常量和变量在幕后同时引用同一个类实例(对于结构体和枚举来说，这并不成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝。)

        //如果能够判定两个常量或者变量是否引用同一个类实例将会很有帮助。为了达到这个目的，Swift 内建了两个恒等运算符:
        //(等价于(===)   不等价于( !== )
        
        if tenEighty === alseTenEighty {
            print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
        }
        
        //• “等价于”表示两个类类型(class type)的常量或者变量引用同一个类实例。
        //• “等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相 等”来说，这是一种更加合适的叫法。
        if tenEighty == alseTenEighty {
            print("==")
        }
        
        //二元运算符“= =”/不能应用两视图分辨率的操作数
//        if hd == cinema {//binary operator "==" cannot be applied two 'viewController.Resolution' operands
//            print("==")
//        }
        
        //7. 类和结构体的选择
        /*
 
          结构体实例总是通过值传递，类实例总是通过引用传递
         
         请考虑构建结构体:
         • 该数据结构的主要目的是用来封装少量相关简单数据值。
         • 有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。 
         • 该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
         • 该数据结构不需要去继承另一个既有类型的属性或者行为。
            
         合使用结构体:
         • 几何形状的大小，封装一个 width 属性和 height 属性，两者均为 Double 类型。
         • 一定范围内的路径，封装一个 start 属性和 length 属性，两者均为 Int 类型。
         • 三维坐标系内一点，封装 x ， y 和 z 属性，三者均为 Double 类型
        */
    }
  
    
}

//MARK: - 字符串、数组、和字典类型的赋值与复制行为
extension ViewController {

    class PersonModel {
        var name: String?
        var weight: CGFloat?
        var Height: CGFloat?
    }
    fileprivate func  someKnowledge() {
        //Swift 中，许多基本类型，诸如 String ， Array 和 Dictionary 类型均以结构体的形式实现。这意味着被赋值给 新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝
        var personModels: [PersonModel] = []
        for i in 0 ..< 2 {
            if i == 0 {
                let p1 =  PersonModel()
                p1.name = "张三"
                p1.weight = 100.0
                p1.Height = 175.0
                personModels.append(p1)
            } else {
                let p1 =  PersonModel()
                p1.name = "莉丝"
                p1.weight = 120.0
                p1.Height = 165.0
                personModels.append(p1)
            }
        }
        
        let temP = personModels[0]
        temP.name = "王五"
        
        let temp1 = personModels[0]
        print(temp1.name)
        
    }
}


//MARK: - 属性
extension ViewController {
    
    //1.存储属性
    struct FixedLengthRange {
        var firstValue: Int
        let length: Int
    }
    
//    class PropertyClass {
//        var firstValue: Int
//        let length: Int
//        
//    }
    
    //2.延迟属性
    class DataImporter {
        /*
         DataImporter 是一个负责将外部文件中的数据导入的类。 这个类的初始化会消耗不少时间。
         */
        var fileName = "data.txt"
        // 这里会提供数据导入功能 }
    }
    
    class DataImporter2 {
        /*
         DataImporter 是一个负责将外部文件中的数据导入的类。 这个类的初始化会消耗不少时间。
         */

        var fileName = "data.txt"
        // 这里会提供数据导入功能 }
    }
    
    class DataManager {
        lazy var importer = DataImporter()
        var importer2 = DataImporter2()

        var data = [String]()
        // 这里会提供数据管理功能
    }

    //3 计算属性
    struct Point {
        var x = 0.0, y = 0.0
    }
    struct Size {
        var width = 0.0, height = 0.0
    }
    
    struct Rect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get {
                let centerX = origin.x + (size.width / 2)
                let centerY = origin.y + (size.height / 2)
                return Point(x: centerX, y: centerY)
            }
            set(newCenter) {
                origin.x = newCenter.x - (size.width / 2)
                origin.y = newCenter.y - (size.height / 2)
            }
        } }
    
    //简化 setter 声明
    struct AlternativeRect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get {
                let centerX = origin.x + (size.width / 2)
                let centerY = origin.y + (size.height / 2)
                return Point(x: centerX, y: centerY)
            }
            set {
                origin.x = newValue.x - (size.width / 2)
                origin.y = newValue.y - (size.height / 2)
            }
        }
    }
    
    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        var volume: Double {
            return width * height * depth
        }
    }
    
    //属性观察器
    class StepCounter {
        var totalSteps: Int = 0 {
            willSet(newTotalSteps) {
                print("About to set totalSteps to \(newTotalSteps)")
            }
            didSet {
                if totalSteps > oldValue  {
                    print("Added \(totalSteps - oldValue) steps")
                }
            }
        }
    }
    
    class StepCounterSubClass: StepCounter {
        var newProperty = 0
        
    }
    
    //6 类型属性
    struct SomeStructure {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 1 }
    }
    enum SomeEnumeration {
        static var storedTypeProperty = "Some value."
        
        static var computedTypeProperty: Int {
            return 6 }
    }
    
    class SomeClass2 {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 27 }
        
        class var overrideableComputedTypeProperty: Int {
            return 107
        }
    }
    
    fileprivate func propertyTest() {
    
        //1.存储属性
        //一个存储属性就是存储在特定类或结构体实例里的一个常量或变量。存储属性可以是变量存储属性(用关键字 var 定义)，也可以是常量存储属性(用关键字 let 定义)
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3) // 该区间表示整数0，1，2
        rangeOfThreeItems.firstValue = 6
        rangeOfThreeItems.firstValue = 5
        // 该区间现在表示整数6，7，8
        
        //1.1. 常量结构体的存储属性
        //如果创建了一个结构体的实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使有属性被声明为变量也不行
        let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4) // 该区间表示整数0，1，2，3
        //rangeOfFourItems.firstValue = 6
        // 尽管 firstValue 是个变量属性，这里还是会报错 <这种行为是由于结构体(struct)属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常 量。属于引用类型的类(class)则不一样。把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属 性
   
    
        //2.延迟存储属性: 延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存 储属性
        //注意： 必须将延迟存储属性声明成变量(使用 var 关键字)，因为属性的初始值可能在实例构造完成之后才会得 到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性
        //延迟属性很有用，当属性的值依赖于在实例的构造过程结束后才会知道影响值的外部因素时，或者当获得属性的初始值需要复杂或大量计算时，可以只在需要的时候计算它
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        // DataImporter 实例的 importer 属性还没有被创建
        
        print(manager.importer2.fileName)

        print(manager.importer.fileName)
        // DataImporter 实例的 importer 属性现在被创建了 // 输出 "data.txt
        
        //注意： 如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次
        
        //3. 计算属性
        //        Rect(origin: <#T##ViewController.Point#>, size: <#T##ViewController.Size#>)
        var square = Rect(origin:Point(x: 0.0, y: 0.0),size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        // 打印 "square.origin is now at (10.0, 10.0)”
        
        //只读计算属性: 只有 getter 没有 setter 的计算属性就是只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访 问，但不能设置新的值
        
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)

        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
        // 打印 "the volume of fourByFiveByTwo is 40.0"
        
        //4. 属性观察器: 属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外。
        /*
         • 在新的值被设置之前调用: 观察器会将新的属性值作为常量参数传入,在willSet的实现代码中可以为这个参数指定一个名 称，如果不指定则参数仍然可用，这时使用默认名称 newValue 表示。
         • 在新的值被设置之后立即调用:  观察器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名 oldValue  。如果 在 didSet  方法中再次对该属性赋值，那么新值会覆盖旧的值。
 
         父类的属性在子类的构造器中被赋值时，它在父类中的 和   观察器会被调用，随后才会调用子类的观察器。在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用。
         */
    
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        // About to set totalSteps to 360
        // Added 160 steps
        stepCounter.totalSteps = 896
        // About to set totalSteps to 896
        // Added 536 steps
        
        
        let s = StepCounterSubClass()
        s.newProperty = 4
        s.totalSteps = 10

        
        //5.全局变量和局部变量: 全局的常量或变量都是延迟计算的，跟延迟存储属性 (页 0)相似，不同的地方在于，全局的常量或变量不需要 标记 lazy 修饰符。
        propertyName = "1"
        
        propertyName = "2"
        
        //6. 类型属性
        /*
            实例属性属于一个特定类型的实例，每创建一个实例，实例都拥有属于自己的一套属性值，实例之间的属性相互
         独立。
         
            也可以为类型本身定义属性，无论创建了多少个该类型的实例，这些属性都只有唯一一份。这种属性就是类型属
         性。
            
            类型属性用于定义某个类型所有实例共享的数据，比如所有实例都能用的一个常量(就像 C 语言中的静态常 量)，或者所有实例都能访问的一个变量(就像 C 语言中的静态变量)。
         
         注意
         跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过 程中使用构造器给类型属性赋值。 存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。
         即使它们被多个线程同时访 问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符

        */

        //FixedLengthRange() 错误
        FixedLengthRange(firstValue: 1, length: 1)
        
        //6.1 类型属性语法
        //使用关键字 static 来定义类型属性。在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父 类的实现进行重写
        
        //获取和设置类型属性的值跟实例属性一样，类型属性也是通过点运算符来访问。但是，类型属性是通过类型本身来访问，而不是通过实例
        print(SomeStructure.storedTypeProperty)
        // 打印 "Some value."
        
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        // 打印 "Another value.”
        
        print(SomeEnumeration.computedTypeProperty)
        // 打印 "6"
        
        print(SomeClass2.computedTypeProperty)
        // 打印 "27"
    }
}




















