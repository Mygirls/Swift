//: Playground - noun: a place where people can play

import UIKit

var AAAA: [String: String] = ["YYZ": "Toronto1 Pearson", "DUB": "Dublin"]
var BBBB: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

if AAAA == BBBB {
    print("---------------------")
}



var str = "swift 3.0"

var s1: String = "Hello"
let s2: String = "World"

//1.Keyword 'self' cannot be used as an identifier here: 可以使用 (``) 如果你需要使用与Swift保留关键字相同的名称作为常量或者变量名，你可以使用反引号(`)将关键字包围的方 式将其作为名字使用。无论如何，你应当避免使用关键字作为常量或变量名，除非你别无选择。
//let self: String = "world"
let `self`: String = "world"

//2.Swift 字符串插值:把常量名或者变量名当做占位符加入到长字符串中，Swift 会用当前常量或变量的值替换这些占位符。将常量或变量名放入圆括号中，并在开括号前使用反斜杠将其转义
let s3: String = s1 + s2
let s4: String = "Hello + \(s2)"


//3.分号：有一种情况下必须要用分号，即你打算在同一行内写多条独立的语句:
let s5: String = s1 + s2 ; print(s5)


//4.整数:Swift 提供了8，16，32和64位的有符号和无符号整数类型
let minValue = UInt8.min    //0
let maxValue = UInt8.max    //255
let minValue_int8 = Int8.min    //-128
let maxValue_int8 = Int8.max    //127

//5.类型别名type aliases
typealias AudioSample = UInt16
var maxAudioSample = AudioSample.max

//6.元组 tuples
let http404Errol = (404,"Not Found")
let (statusCode,statusMeg) = http404Errol

var testTup:(a: String,b: String)?
testTup?.a = "a"  //都是nil
testTup?.b
print(testTup)

statusCode
statusMeg

http404Errol.0
http404Errol.1

let http200Status = (statusCode: 200,description: "info")
http200Status.statusCode
http200Status.description


//7.断言 assertion：来结束代码运行并通过调试来找到值缺失的原因
//当代码使用优化编译的时候，断言将会被禁用，例如在 Xcode 中，使用默认的 target Release 配置选项来 bu ild 时，断言会被禁用
let age = 3
assert(age > 0, "A person's age cannot be less than zero")

//8.三目运算符
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)   //注意空格

//9.空合运算符:空合运算符( a ?? b )将对可选类型 a 进行空判断，如果 a 包含一个值就进行解封，否则就返回一个默认值 b 。表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致(其实是对： a != nil ? a! : b  的简化)

let defaultColorName = "red"
var userDefinedColorName: String?
var colorNameToUse = userDefinedColorName ?? defaultColorName //??注意空格： 如果没有?? 前后没有空格时候，会报错

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName


//10.字符串
var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print(" 空字符串")
}

if anotherEmptyString.isEmpty {
    print(" 空字符串")
}

//11.字符串是 值类型
var s6 = "123"
var s7 = "456"
s7 = "789"

print(s6)
print(s7)

for c in "dog !".characters {
    print(c)
}

//转义字符 \0 (空字符)、 \\ (反斜线)、 \t (水平制表符)、 \n (换行符)、 \r (回车符)、 \" (双引 号)、 \' (单引号)。

//12.访问和修改字符串
let greeting = "Guten Tag!"
greeting[greeting.startIndex]

type(of: greeting.startIndex)

// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a

//使用 characters 属性的 indices 属性会创建一个包含全部索引的范围(Range)，用来在一个字符串中访问单 个字符。
for index in greeting.characters.indices {
    type(of: index)
    print("\(greeting[index])")
}

var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
welcome.insert(contentsOf: " there".characters, at: welcome.index(before: welcome.endIndex))
type(of: "there".characters)

//welcome.remove(at: <#T##String.Index#>)
let t = welcome.index(before: welcome.endIndex)

welcome.remove(at: t)
welcome.remove(at: welcome.index(before: welcome.endIndex))
print(welcome)


let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)


print("--------------------")
//13.集合 - Array
var someInts = [Int]()
print("\(someInts.count) --- \(type(of: someInts))")
someInts.append(3)
someInts = []
type(of: someInts)

var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)

var anothreeDoubles = Array(repeating: 2.5, count: 3)

var sixDoubles = threeDoubles + anothreeDoubles
print(sixDoubles)

var shoppingList: [String] = ["Eggs","Milk","Water"]
type(of: shoppingList)


print(shoppingList.count)
print(shoppingList[0])
if shoppingList.isEmpty {
    print("is empty")
} else {
    print("not  empty")
}

shoppingList.append("Flour")

shoppingList += ["five","six"]
shoppingList[0] = "change first"

shoppingList
shoppingList.insert("inset f", at: 0)
let mapleSyrup = shoppingList.remove(at: 0)

//遍历
for item in shoppingList {
    print(item)
}


for (index ,value) in shoppingList.enumerated() {
    print("index = \(index) ,value = \(value)")
}

shoppingList.map { (v) in
    print("v = \(v)")
}

let tem = shoppingList.map { (v2) -> Bool in
    print("v2 = \(v2)")
    
    return false
}

print(tem)


//14.集合 -- Sets————
// 集合类型的哈希值：一个类型为了存储在集合中，该类型必须是可哈希化的--也就是说，该类型必须提供一个方法来计算它的哈希值。一个哈希值是 Int 类型的，相等的对象哈希值必须相同，比如 a==b ,因此必须 a.hashValue == b.hashValue。

print("___________________注意_____________________")
print("****")
print(" 集合类型的哈希值")
print("****")
print("___________________注意_____________________")

var letters = Set<Character>()  //通过构造器，这里的 letters 变量的类型被推断为 Set<Character> 。
print(letters)
print(letters.count)
print(type(of: letters))

letters.insert("a")
let f = letters.insert("b")
print(type(of: f))
print(letters)
//let tetters2 = []//error: empty collection literal requires an explicit type

letters = []
type(of: letters)//现在是一个空的 Set, 但是它依然是 Set<Character> 类型

//用数组字面量创建集合
var favoriteGenres: Set<String> = ["Rock","Classical","1","2"]
print(favoriteGenres)//无序的

//访问和修改一个 合
print(favoriteGenres.count)
if favoriteGenres.isEmpty {
    print("is empty")
} else {
    print("not empty")
}

favoriteGenres.insert("Jazz")
print(favoriteGenres)

if let removeGenre = favoriteGenres.remove("noValue") {
    print("remove \(removeGenre)")
} else {
    print("never much cared for that")
}

favoriteGenres.remove(at: favoriteGenres.startIndex)
favoriteGenres.index(after: favoriteGenres.startIndex)
favoriteGenres.contains("Classical")

for genre in favoriteGenres {
    print(genre)
}

//sorted() 返回一个有序数组，这个数组的元素排列顺序由操作符'<'对元素进行比较的结果来确定.
for genre in favoriteGenres.sorted() {
    print("---\(genre) ---")
}


//• 使用 intersection(_:) 方法根据两个 合中都包含的值创建的一个新的集合。
//• 使用 symmetricDifference(_:) 方法根据在一个集 合中但不在两个集合中的值创建一个新的 集合。
//• 使用 union(_:) 方法根据两个 合的值创建一个新的集 合。
//• 使用 subtracting(_:) 方法根据不在该 合中的值创建一个新的集 合。
let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]
let singleDigitPrimeNumbers: Set = [2,3,5,7]


let tem2 = oddDigits.union(evenDigits).sorted()//相当于数学的 并集
let tem3 = oddDigits.intersection(evenDigits).sorted() //相当于数学的 交集
let tem4 = oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
let tem5 = oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
print(tem2)
print(tem3)
print(tem4)
print(tem5)

// • 使用“是否相等”运算符( == )来判断两个 合是否包含全部相同的值。
// • 使用 isSubset(of:) 方法来判断一个 合中的值是否也被包含在另外一个 合中。
// • 使用 isSuperset(of:) 方法来判断一个 合中包含另一个 合中所有的值。
// • 使用 isStrictSubset(of:) 或者 isStrictSuperset(of:) 方法来判断一个 合是否是另外一个 合的子 合或 者父 合并且两个 合并不相等。
// • 使用 isDisjoint(with:) 方法来判断两个 合是否不含有相同的值(是否没有交 )。

let houseAnimals: Set = ["?", "?"]
let farmAnimals: Set = ["?", "?", "?", "?", "?"]
let cityAnimals: Set = ["?", "?"]
houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true

//15集合 -- 字典
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
airports.count
var temDic: [String: String] = [:]
if temDic.isEmpty {
    print("empty")
} else {

    print("no empty")
}

airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"

print(airports)
//updateValue(_:forKey:) 方法在这个键不存在对应值的时候会设置新值或者在存在时更新已存在的 值,和上面的下标方法不同的， updateValue(_:forKey:) 这个方法返回更新值之前的原值。这样使得我们可以检 查更新是否成功
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}

print("---------------\(airports)")
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB2") {
    print("The old value for DUB was \(oldValue).")
} else {
    print(airports)
}

if let airportName = airports["DUB3"] {
     print("The name of the airport is (airportName).")
} else {
    print("That airport is not in the airports dictionary.")
    print(airports)
}

//我们还可以使用下标语法来通过给某个键的对应值赋值为 nil 来从字典里移除一个键值对:
airports["DUB2"] = nil
print(airports)

let value = airports["DUB3"]
type(of: value)

// removeValue(forKey:) 方法也可以用来在字典中移除键值对。这个方法在键值对存在的情况下会移除该键 值对并且返回被移除的值或者在没有值的情况下返回 nil
if let removeValue = airports.removeValue(forKey: "DUB3") {
    print("\(removeValue)")

} else {
    print("not remove success")
}

if let removeValue = airports.removeValue(forKey: "LHR") {
    print("\(removeValue)")
} else {
    print("not remove success")

}

for key in airports.keys {
    print("key = \(key)")
}

for value in airports.values {
    print("value = \(value)")
}

airports.keys.sorted()

print("**************第二章节***********************")
print("控制流")
print("*************************************")
for index in 0 ..< 5 {
    print("\(index) time 5 is \(index * 5)")
}

for _ in 1 ... 3 {
    print("*")
}

let names = ["Anna","Jack","ma"]
for name in names {
    print("hello ,\(name)")
}

let numberOfLegs = ["a":1,"b": 2]
for (key, value) in numberOfLegs {  //无序的
    print("key = \(key),value = \(value)")
    
}

print("--------------switch--------------")

let someCharcater: Character = "z"
switch someCharcater {
case "a":
    print("The first letter of the alphabe")
case "b":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a","A":
    print("the letter A")
case "b":
    break
default:
    print("not the letter A")
}

//匹配区间
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String

switch approximateCount {
case 0:
    naturalCount = "No"
case 0 ..< 5 :
    naturalCount = "a few"
case 5 ..< 12:
    naturalCount = "several"
case 12 ..< 100:
    naturalCount = "dozens of"
case 100 ..< 1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}

print(naturalCount)

print("-----------------控制转移语句-----------------")
print("continue")
//continue 语句告诉一个循环体立刻停止本次循环，重新开始下次循环。就好像在说“本次循环我已经执行完 了”，但是并不会离开整个循环体
for i in 0 ..< 5 {
    if i == 2 {
        continue
    }
    print(i)
}

print("break")
//break 语句会立刻结束整个控制流的执行。当你想要更早的结束一个 switch 代码块或者一个循环体时，你都可以 使用 break 语句。通常在swift 里面使用
for i in 0 ..< 5 {
    if i == 2 {
        break
    }
    print(i)
}

for i in 0 ..< 3 {
    for j in 4 ..< 6 {
        
        print("j = \(j)")
    }
}

print("---")    //跳出当前整个控制流的执行
for i in 0 ..< 3 {
    for j in 4 ..< 6 {
        if j == 5 {
            break
        }
        print("j = \(j)")
    }
}
print("fallthrough")    //贯穿
let intergerToDescribe = 2
switch intergerToDescribe {
case 1,2,3:
    print(intergerToDescribe)
    fallthrough
case 4:
    print("---4 ---")   //fallthrough fallthrough 关键字不会检查它下一个将会落入执行的 case 中的匹配条件。 fallthrough 简单地使代 码继续连接到下一个 case 中的代码，这和 C 语言标准中的 switch 语句特性是一样的，但不会继续执行到 更下一步
default:
    print("---fallthrough---")
}



print("return")
func greet() {
    
    for i in 0 ..< 3 {
        for j in 4 ..< 6 {
            if j == 5 { //跳出整个大的循环
                return
            }
            print("j = \(j)")
        }
    }
}

greet()

print("---")
func greet2() {
    
    for i in 0 ..< 3 {
        for j in 4 ..< 6 {
            if j == 5 { //跳出 当前 小的循环
                break
            }
            print("j = \(j)")
        }
    }
}
greet2()


//提前退出: guard
//像 if 语句一样， guard 的执行取决于一个表达式的布尔值。我们可以使用 guard 语句来要求条件必须为真 时，以执行 guard 语句后的代码。不同于 if 语句，一个 guard 语句总是有一个 else 从句，如果条件不为真则执 行 else 从句中的代码。

//检测 API 可用性
///我们在 if 或 guard 语句中使用 可用性条件(availability condition) 去有条件的执行一段代码，来在运行时判 断调用的API是否可用。编译器使用从可用性条件语句中获取的信息去验证，在这个代码块中调用的 API 是否可 用
if #available(iOS 10, macOS 10.12, *) {
    // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
} else {
    // 使用先前版本的 iOS 和 macOS 的 API
}
//以上可用性条件指定，在iOS中， if 语句的代码块仅仅在 iOS 10 及更高的系统下运行;在 macOS中，仅在 macO S 10.12 及更高才会运行。
//最后一个参数， * ，是必须的，用于指定在所有其它平台中，如果版本号高于你的设 备指定的最低版本，if语句的代码块将会运行。











