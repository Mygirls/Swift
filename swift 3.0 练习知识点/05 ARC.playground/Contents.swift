//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


print("---------------自动引用计数的工作机制---------------")

    // 1.自动引用计数的工作机制
    
    /*
     
     1.1 当你每次创建一个类的新的实例的时候，ARC 会分配一块内存来储存该实例信息。内存中会包含实例的类型信 息，以及这个实例所有相关的存储型属性的值。
     
     1.2 此外，当实例不再被使用时，ARC 释放实例所占用的内存，并让释放的内存能挪作他用。这确保了不再被使用的 实例，不会一直占用内存空间。
     
     1.3 然而，当 ARC 收回和释放了正在被使用中的实例，该实例的属性和方法将不能再被访问和调用。实际上，如果你 试图访问这个实例，你的应用程序很可能会崩溃。
     
     1.4 为了使上述成为可能，无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢地保持住，只要强引用还在，实例是不允许被销毁的。
     */

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
        
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}


// 2. 自动引用计数实践
// 2.1 它们的值会被自动初始化为 nil ，目 前还不会引用到 Person 类的实例。
var reference1: Person?
var reference2: Person?
var reference3: Person?

//2.2 创建 Person 类的新实例，并且将它赋值给三个变量中的一个
reference1 = Person(name: "John Appleseed")

withUnsafePointer(to: &reference3) {
    print("\($0)")
}

withUnsafeBytes(of: &reference1) { (p)  in
    print(p)
}

print("--")
//由于 Person 类的新实例被赋值给了 reference1 变量，所以 reference1 到 Person 类的新实例之间建立了一个强 引用。正是因为这一个强引用，ARC 会保证 Person 实例被保持在内存中不被销毁。

//2.3 如果你将同一个 Person 实例也赋值给其他两个变量，该实例又会多出两个强引用:
reference2 = reference1
reference3 = reference1 //现在Person 实例已经有三个强引用了。

//2.4 给其中两个变量赋值 nil 的方式断开两个强引用
reference1 = nil
reference2 = nil

//2.3 给最后一个 变量赋值 nil 的方式断开强引用
reference3 = nil //此时出现： John Appleseed is being deinitialized 说明调用了deinit 方法，表明 对象 销毁了

print("---------------类实例之间的循环强引用---------------")

//3. 类实例之间的循环强引用
//3.1 在上面的例子中，ARC 会跟踪你所新创建的 Person 实例的引用数量，并且会在 Person 实例不再被需要时销毁 它
//3.2 如果两个类实例互相持有对方的强引 用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用。

class Person2 {
    let name: String
    init(name: String) {
        self.name = name
    }
    
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}


class Apartment {

    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    
    //注意：
    var tenant: Person2?
    deinit {
        print("\(unit) is being deinitialized")
    }
}

//3.3 这两个变量都被初始化为 nil
var john: Person2?
var unit4A: Apartment?

//3.4 创建特定的 Person 和 Apartment 实例并将赋值给 john 和 unit4A 变量
john = Person2(name: "张三")  //hohn -> Person2
unit4A = Apartment(unit: "4A")// unit4A ->  Apartment

//3.5 将这两个实例关联在一起
john?.apartment = unit4A
unit4A?.tenant = john

//3.6 断开引用
john = nil
unit4A = nil    // 没有任何一个析构函数被调用

//3.7 存在问题： 应用程序中造成了内存泄漏


print("---------------解决实例之间的循环强引用---------------")
//4.解决实例之间的循环强引用
//4.1 Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题:                 弱引用(weak reference)和无 主引用(unowned reference)。

//4.2 弱引用和无主引用允许循环引用中的一个实例引用 而另外一个实例不保持强引用。这样实例能够互相引用而不产生循环强引用

//4.3 当其他的实例有更短的生命周期时，使用弱引用，也就是说，当其他实例析构在先时

//4.4 弱引用
    /*
 
        4.4.1 弱引用不会对其引用的实例保持强引用，因而不会阻止 ARC 销毁被引用的实例。这个特性阻止了引用变为循环强引用。
        4.4.2 声明属性或者变量时，在前面加上 weak 关键字表明这是一个弱引用。
        4.4.3 因为弱引用不会保持所引用的实例，即使引用存在，实例也有可能被销毁。因此，ARC 会在引用的实例被销毁后 自动将其赋值为 nil 。并且因为弱引用可以允许它们的值在运行时被赋值为 nil ，所以它们会被定义为可选类型 变量，而不是常量。
        4.4.4 当其他的实例有更短的生命周期时，使用弱引用
        注意：
            当 ARC 设置弱引用为 nil 时，属性观察不会被触发。
 
    */


class Person3 {
    let name: String
    init(name: String) {
        self.name = name
    }
    
    //注意：
    var apartment: Apartment2?
    deinit {
        print("\(name) is being deinitialized")
    }
}


class Apartment2 {
    
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    
    //注意： weak
    weak var tenant: Person3?
    deinit {
        print("\(unit) is being deinitialized")
    }
}

var john3: Person3?
var unit4A2: Apartment2?

john3 = Person3(name: "lisi")
unit4A2 = Apartment2(unit: "4A")

john3!.apartment = unit4A2
unit4A2!.tenant = john3

john3 = nil
unit4A2 = nil   //都调用了deinit 证明了引用循环被打破了
/*
 注意： 
 如果：只 unit4A2 = nil 那么都不会销毁，因为Person3 -> unit4A2 还有一个强引用
 
 在使用垃圾收 的系统里，弱指针有时用来实现简单的缓冲机制，因为没有强引用的对象只会在内存压力触发垃 圾收 时才被销毁。但是在 ARC 中，一旦值的最后一个强引用被移除，就会被立即销毁，这导致弱引用并不适 合上面的用途
 */


print("-------------------实例无主引用-------------------")
//5. 无主引用
/*
    5.1 和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用在其他实例有相同或者更长 的生命周期时使用。你可以在声明属性或者变量时，在前面加上关键字 unowned 表示这是一个无主引用。
    5.2 无主引用通常都被期望拥有值。不过 ARC 无法在实例被销毁后将无主引用设为 nil ，因为非可选类型的变量不允 许被赋值为 nil 。
 
     注意： 
        使用无主引用，你必须确保引用始终指向一个未销毁的实例。
        如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误

 
 */


class Custumer {
    let name: String
    var card: CreditCard?   //一个客户可能有或者没有信用卡
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }

}


class CreditCard {
    let number: UInt64
    //let customer: Custumer //一张信用卡总是关联着一个客户
    unowned let customer: Custumer //一张信用卡总是关联着一个客户

    init(number: UInt64,customer: Custumer) {
        self.number = number
        self.customer = customer
    }
     deinit {
        print("Card #\(number) is being deinitialized")
    }
}

/*
 CreditCard 类的 number 属性被定义为 UInt64 类型而不是 Int 类型，以确保 number 属性的存储量在 32 位和64 位系统上都能足够容纳 16 位的卡号。
 
 */


var  jack: Custumer?
jack = Custumer(name: "Jack Appleseed")
jack!.card = CreditCard(number: 1234_5678_9012_3456, customer: jack!)
jack == nil


/*
 Person 和 Apartment 的例子展示了两个属性的值都允许为 nil ，并会潜在的产生循环强引用。这种场景最适合用 弱引用来解决。
 
 Customer 和 CreditCard 的例子展示了一个属性的值允许为 nil ，而另一个属性的值不允许为 nil ，这也可能会 产生循环强引用。这种场景最适合通过无主引用来解决。
 
 存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为 nil 。在这种场 景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
 */



//6. 无主引用以及隐式解析可选属性
print("---------------无主引用以及隐式解析可选属性--------------")
class Country {
    let name: String
    
    //每个国家 必须有首都
    var capitalCity: City! //类型结尾处加上感叹号( City! )的方式，将 Country 的 capitalCity 属性声明为隐 式解析可选类型的属性。这
    
    //Country 的构造函数调用了 City 的构造函数。然而，只有 Country 的实例完全初始化后， Country 的构造函数 才能把 self 传给 City 的构造函数
    init(name: String,capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
    
    deinit {
        print("country denit")
    }
}

class City {

    let name: String
    unowned let country: Country //每个城市必须属于一个国家。
    
    // City 的构造函数接受一个 Country 实例作为参数，并且将实例保存到 country 属 性。
    init(name: String, country: Country) {
        self.name = name
        self.country = country
        
    }
    
    deinit {
        print("city denit")
    }
}

//通过一条语句同时创建 Country 和 City 的实例，而不产生循环强引用，并且 的属性能被直接访问，而不需要通过感叹号来展开它的可选值:
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")

//country = nil
print("--  =")
// 打印 “Canada's capital city is called Ottawa”


//7. 闭包引起的循环强引用

class HTMLElement {
    let name: String
    let text: String?

    lazy var asHTML: (Void) -> String = {
    
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
            
        } else {
            return "<\(self.name) />"
        }
        
        return ""
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    
    }
}

var heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// 打印 “<p>hello, world</p>”
paragraph = nil


























