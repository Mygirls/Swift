//
//  SecondViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/6.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit

import RxSwift



class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        /**
         *  public class Observable<Element> : ObservableType {}
         *  Observable<T>这个类就是Rx 框架的基础，我们可以称它为可观察序列
         *
         *  作用：可以异步地产生一系列的 Event（事件）
         *       即一个 Observable<T> 对象会随着时间推移不定期地发出 event(element : T) 这样一个东西。
         *
         *  还需要有一个Observer（订阅者）来订阅它，这样这个订阅者才能收到 Observable<T> 不时发出的 Event。
         *
         *  Observable 对象会在有任何 Event 时候，自动将 Event作为一个参数通过ObservableType.subscribe(_:)发出，并不需要使用 next方法
         */
        setupObservable()
        
    }
}

// MARK: - 创建 Observable 序列
extension SecondViewController {
    func setupObservable ()  {
        
        //通过如下几种方法来创建一个 Observable序列【创建可观察序列】
        just()
        of()
        from()
        
        empty()
        neve()
        error()
        
        rang()
        repeatElement()
        generate()
        
        create()
        deferred()
        interval()
        
        timer()
        
    }
    
    func just() {
        
        //    public static func just(_ element: Self.E) -> RxSwift.Observable<Self.E>
        //显式地标注出了 observable 的类型为 Observable<Int>，
        //即指定了这个 Observable所发出的事件携带的数据类型必须是 Int 类型的。
        //let observable = Observable<Int>.just(5)
        let _ = Observable<Int>.just(5)
        
    }
    
    func of() {
        //    public static func of(_ elements: Self.E..., scheduler: ImmediateSchedulerType = default) -> RxSwift.Observable<Self.E>
        //该方法可以接受可变数量的参数（必需要是同类型的）
        //没有显式地声明出 Observable 的泛型类型，Swift 也会自动推断类型。
        let _ = Observable.of("A","B","C")
    }
    
    func from() {
        //    public static func from(_ array: [Self.E], scheduler: ImmediateSchedulerType = default) -> RxSwift.Observable<Self.E>
        //数据里的元素就会被当做这个 Observable 所发出 event携带的数据内容，最终效果同上面饿 of()样例是一样的。
        let _ = Observable.from(["A","B","C"])
    }
    
    func empty() {
        //    public static func empty() -> RxSwift.Observable<Self.E>
        //该方法创建一个空内容的 Observable 序列。
        let _ = Observable<Int>.empty()
    }
    
    func neve() {
        //该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
        let _ = Observable<Int>.never()
    }
    
    func error() {
        enum MyError:Error {
            case A
            case B
        }
        
        //    public static func error(_ error: Error) -> RxSwift.Observable<Self.E>
        //该方法创建一个不做任何操作，而是直接发送一个错误的 Observable 序列。
        let _ = Observable<Int>.error(MyError.A)
    }
    
    func rang() {
        //    public static func range(start: Self.E, count: Self.E, scheduler: ImmediateSchedulerType = default) -> RxSwift.Observable<Self.E>
        //该方法通过指定起始和结束数值，创建一个以这个范围内所有值作为初始值的Observable序列。
        //两种方法创建的 Observable 序列都是一样的。
        let _ = Observable.range(start: 1, count: 3);
        
        let _ = Observable.of(1,2,3,4,5)
    }
    
    func repeatElement()  {
        //    public static func repeatElement(_ element: Self.E, scheduler: ImmediateSchedulerType = default) -> RxSwift.Observable<Self.E>
        //该方法创建一个可以无限发出给定元素的 Event的 Observable 序列（永不终止）。
        let _ = Observable.repeatElement(1)
    }
    
    func generate()  {
        //该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的 Observable 序列。
        //（2）下面样例中，两种方法创建的 Observable 序列都是一样的。
        //使用generate()方法
        
        //    public static func generate(initialState: Self.E, condition: @escaping (Self.E) throws -> Bool, scheduler: ImmediateSchedulerType = default, iterate: @escaping (Self.E) throws -> Self.E) -> RxSwift.Observable<Self.E>
        let _ = Observable.generate(
            initialState: 0,
            condition: { $0 <= 10 },
            iterate: { $0 + 2 }
        )
        
        //使用of()方法
        let _ = Observable.of(0 , 2 ,4 ,6 ,8 ,10)
    }
    
    func create() {
        //1）该方法接受一个 block 形式的参数，任务是对每一个过来的订阅进行处理。
        //2）下面是一个简单的样例。为方便演示，这里增加了订阅相关代码（关于订阅我之后会详细介绍的）
        
        //这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
        //当一个订阅者订阅这个Observable对象的时候，就会将订阅者作为参数传入这个block来执行一些内容
        //    public static func create(_ subscribe: @escaping (RxSwift.AnyObserver<Self.E>) -> Disposable) -> RxSwift.Observable<Self.E>
        let observable = Observable<String>.create{observer in
            
            //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
            //发送给观察者的下一个元素（s）
            observer.onNext("hangge.com")
           
            //对订阅者发出了.completed事件
            observer.onCompleted()
           
            //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
            return Disposables.create()
        }
        
        //订阅测试
        //    public func subscribe(_ on: @escaping (RxSwift.Event<Self.E>) -> Swift.Void) -> Disposable
//        observable.subscribe {
//            print($0)
//        }
        
        let _ = observable.subscribe { (e) in
            print(e)

        }
    }
    
    func deferred() {
        //该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方。
        
        //用于标记是奇数、还是偶数
        var isOdd = true
        
        //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
        let factory : Observable<Int> = Observable.deferred {
            
            //让每次执行这个block时候都会让奇、偶数进行交替
            isOdd = !isOdd
            
            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
            if isOdd {
                return Observable.of(1, 3, 5 ,7)
            }else {
                return Observable.of(2, 4, 6, 8)
            }
        }
        
        //第1次订阅测试
        let _ = factory.subscribe { event in
            print("\(isOdd)", event)
        }
        
        //第2次订阅测试
        let _ = factory.subscribe { event in
            print("\(isOdd)", event)
        }
    }
    
    func interval() {
        //这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素。而且它会一直发送下去。
        //（2）下面方法让其每 1 秒发送一次，并且是在主线程（MainScheduler）发送。
        //    public static func interval(_ period: RxTimeInterval, scheduler: SchedulerType) -> RxSwift.Observable<Self.E>
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        let _ = observable.subscribe { (event) in
            print(event)
        }
    }
    
    func timer() {
        //这个方法有两种用法，一种是创建的 Observable序列在经过设定的一段时间后，产生唯一的一个元素。
        //5秒种后发出唯一的一个元素0
        let observable = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
        let _ = observable.subscribe { event in
            print(event)
        }
        
        //另一种是创建的 Observable 序列在经过设定的一段时间后，每隔一段时间产生一个元素。
        //延时5秒种后，每隔1秒钟发出一个元素
        let observable2 = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
        let _ = observable2.subscribe { event in
            print(event)
        }
        
    }
}


