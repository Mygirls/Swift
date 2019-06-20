//
//  FourthViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/7.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class FourthViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        //观察者（Observer）介绍
        //observable()
        //bind_01()
        //bind_02()

        //使用 AnyObserver 创建观察者
        //anyObserver_01()
        //anyObserver_02()
        
        //使用 Binder 创建观察者
        binderDemo()
    }

    
}

// MARK: - 直接在 subscribe、bind 方法中创建观察者
extension FourthViewController
{
    /**
     *  一、观察者（Observer）介绍
     *  观察者（Observer）的作用就是监听事件，然后对这个事件做出响应。或者说任何响应事件的行为都是观察者。
     *  比如：
     *      1)当我们点击按钮，弹出一个提示框。那么这个“弹出一个提示框”就是观察者Observer<Void>
     *      2)当我们请求一个远程的json 数据后，将其打印出来。那么这个“打印 json 数据”就是观察者 Observer<JSON>
     *
     *  二、直接在 subscribe、bind 方法中创建观察者
     *  1，在 subscribe 方法中创建
     *      创建观察者最直接的方法就是在 Observable 的 subscribe 方法后面描述当事件发生时，需要如何做出响应。
     *      比如下面的样例，观察者就是由后面的 onNext，onError，onCompleted 这些闭包构建出来的。
     */
    func observable() {
        let observable = Observable.of("A","B","C")
        let _ = observable.subscribe(onNext: { (element) in
            print(element)
            
        }, onError: { (error) in
            print(error)
            
        }, onCompleted: {
            print("completed")
            
        }, onDisposed: {
            print("onDisposed")
        })
    }
    
    //在 bind 方法中创建
    func bind_01() {
        //1）下面代码我们创建一个定时生成索引数的 Observable 序列，并将索引数不断显示在 label 标签上\\
        //let disposeBag = DisposeBag()
        self.label.text = ""

        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
//        let _ = observable.subscribe { (event) in
//            print(event)
//        }
        
        observable
            .map { "当前索引数：\($0 )" }
            .bind { [weak self](text) in
                //收到发出的索引数后显示到label上
                self?.label.text = text
            }
            .disposed(by: disposeBag)   //disposeBag 全局属性才能打印输出

    }
    
    func bind_02() {
        //let disposedBag = DisposeBag()
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        let subscribetion = observable.subscribe(onNext: { (event) in
            print(event)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Disposed")
        })
        
        //15秒后回收，也可根据具体业务需求在适当的时候加上这句话
        let deadline = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            subscribetion.disposed(by: self.disposeBag)
        }
    }
}

// MARK: - 使用 AnyObserver 创建观察者
extension FourthViewController {
    /**
     *  AnyObserver 可以用来描叙任意一种观察者。
     *
     *
     */
    
    //比如上面第一个样例我们可以改成如下代码：
    func anyObserver_01() {
        // 配合 subscribe 方法使用
        // 结构体：初始化方法，EventHandler：观察序列事件的事件处理程序。
        // public struct AnyObserver<Element> : ObserverType {}     //AnyObserver 是一个结构体，遵守协议 ObserverType
        // public init(eventHandler: @escaping EventHandler) {}     //初始化方法
        // public typealias EventHandler = (Event<Element>) -> Void //EventHandler 闭包
        
        // 上面第一个样例我们可以改成如下代码
        // 观察者
        let observer:AnyObserver<String> =  AnyObserver { (event) in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        
        let observable = Observable.of("A","B","C","D")
        
        //    public func subscribe<O>(_ observer: O) -> Disposable where Element == O.E, O : ObserverType
        let _ = observable.subscribe(observer)
        
    }
    
    func anyObserver_02() {
        //配合 bindTo 方法使用
        //观察者
        let observer:AnyObserver<String> =  AnyObserver { [weak self] (event) in
            switch event {
            case .next(let text):
                print(text)
                //收到发出的索引数后显示到label上
                self?.label.text = text
                
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        //    public func map<R>(_ transform: @escaping (Self.E) throws -> R) -> RxSwift.Observable<R>
        let _ = observable.map {
             "当前索引数：\($0 )"
            }
            .bind(to: observer)
            .disposed(by: disposeBag)     //disposeBag 全局属性才能打印输出
        
    }
}

// MARK: - 使用 Binder 创建观察者
extension FourthViewController
{
    /**
     *  1）相较于AnyObserver 的大而全，Binder 更专注于特定的场景。Binder 主要有以下两个特征:
     *      不会处理错误事件
     *      确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
     *
     *  2）一旦产生错误事件，在调试环境下将执行 fatalError，在发布环境下将打印错误信息
     *
     *
     *
     */
    
    func binderDemo() {
        //【Generic parameter 'Value' could not be inferred】泛型参数“值”不能推断,必须加上范型类型
        let observer:Binder<String> =  Binder(label) { (view, text) in
            //收到发出的索引数后显示到label上
            view.text = text
        }
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        //    public func map<R>(_ transform: @escaping (Self.E) throws -> R) -> RxSwift.Observable<R>
        // 参数变换：应用于每个源元素的变换函数。
        // 返回：一个可观察序列，其元素是调用源的每个元素上的转换函数的结果。
        // 关于map 参考 http://reactivex.io/documentation/operators/map.html
        observable.map {
             "当前索引数：\($0 )"
            }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
//        observable.map { (num) -> R in
//            return "当前索引数：\(num )"
//        }
    }
    
}


















