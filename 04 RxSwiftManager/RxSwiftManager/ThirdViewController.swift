//
//  ThirdViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/6.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxSwift
class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        print("----------------  Observable订阅  ----------------")
        subscribe_01()
        subscribe_02()
        
        print("----------------  Observable事件监听 ----------------")
        doOn_01()

        
        print("----------------  Observable订阅销毁 ----------------")
        dispose_01();
        disposeBag();
    }

   
}


// MARK: - Observable订阅、事件监听、订阅销毁
extension ThirdViewController
{
    //订阅 Observable
    func subscribe_01() {
        //    public func subscribe(_ on: @escaping (RxSwift.Event<Self.E>) -> Swift.Void) -> Disposable
        //使用 subscribe() 订阅了一个Observable 对象，
        //该方法的 block 的回调参数就是被发出的 event 事件，我们将其直接打印出来。
        //初始化 Observable 序列时设置的默认值都按顺序通过 .next 事件发送出来。
        //当 Observable 序列的初始数据都发送完毕，它还会自动发一个 .completed 事件出来
        let observable = Observable.of("A","B","C")
        let _ = observable.subscribe { (event) in
            print(event)
        }
        
        let observable2 = Observable.of("A","B","C")
        let _ = observable2.subscribe { (event) in
            
            // 通过event.element得到这个事件里面的数据
            guard let temp = event.element else {
                print("nil")
                return
            }
            print(temp)
        }
    }
    
    //RxSwift 还提供了另一个 subscribe方法，它可以把 event 进行分类：
    func subscribe_02() {
        //    public func subscribe(onNext: ((Self.E) -> Swift.Void)? = default, onError: ((Error) -> Swift.Void)? = default, onCompleted: (() -> Swift.Void)? = default, onDisposed: (() -> Swift.Void)? = default) -> Disposable

        //通过不同的 block 回调处理不同类型的 event。（其中 onDisposed 表示订阅行为被 dispose 后的回调，这个我后面会说）
       // 同时会把 event 携带的数据直接解包出来作为参数，方便我们使用。
        let observable = Observable.of("A","B","C")
        let _ = observable.subscribe(onNext: { (element) in
            print(element)
            
        }, onError: { (error) in
            print(error)
            
        }, onCompleted: {
            print("completed")
            
        }) {
            print("disposed")
        }
        
        //subscribe() 方法的 onNext、onError、onCompleted 和 onDisposed 这四个回调 block 参数都是有默认值的，
        //即它们都是可选的。所以我们也可以只处理 onNext而不管其他的情况。
//        let _ = observable.subscribe(onNext: { (element) in
//            print(element)
//        })
    }
}

// MARK: - 监听事件的生命周期
extension ThirdViewController
{
    //doOn 介绍
    func doOn_01() {
        //    public func `do`(onNext: ((Self.E) throws -> Swift.Void)? = default, onError: ((Error) throws -> Swift.Void)? = default, onCompleted: (() throws -> Swift.Void)? = default, onSubscribe: (() -> ())? = default, onSubscribed: (() -> ())? = default, onDispose: (() -> ())? = default) -> RxSwift.Observable<Self.E>

        /**
         *  使用 doOn 方法来监听事件的生命周期，它会在每一次事件发送前被调用。
         *  同时它和 subscribe 一样，可以通过不同的block 回调处理不同类型的 event。比如：
         *
         *  do(onNext:)方法就是在subscribe(onNext:) 前调用
         *  而 do(onCompleted:) 方法则会在 subscribe(onCompleted:) 前面调用。
         */
        let observable = Observable.of("A","B","C")
        let _ = observable
            .do(onNext: { (element) in
                 print("Intercepted Next：", element)
            }, onError: { (error) in
                 print("Intercepted Error：", error)
            }, onCompleted: {
                 print("Intercepted Completed")
            }, onDispose:{
                print("Intercepted Disposed")
                
            })
            .subscribe(onNext: { (element) in
                print(element)
            }, onError: { (error) in
                 print(error)
            }, onCompleted: {
                 print("completed")
            }) {
                 print("disposed")
        }
        
        
    }
    
    
    
}


// MARK: - Observable 的销毁（Dispose）
extension ThirdViewController
{
    //
    /**
     *  一、Observable 从创建到终结流程
     *
     *  1）一个 Observable 序列被创建出来后它不会马上就开始被激活从而发出 Event，而是要等到它被某个人订阅了才会激活它
     *  2）而 Observable 序列激活之后要一直等到它发出了.error或者 .completed的 event 后，它才被终结。
     *
     *  二、dispose() 方法
     *
     *  1）使用该方法我们可以手动取消一个订阅行为。
     *  2）如果我们觉得这个订阅结束了不再需要了，就可以调用 dispose()方法把这个订阅给销毁掉，防止内存泄漏
     *  3）当一个订阅行为被dispose 了，那么之后 observable 如果再发出 event，这个已经 dispose 的订阅就收不到消息了。下面是一个简单的使用样例。
     *
     */
    
    func dispose_01 () {
        
        //    public func subscribe(_ on: @escaping (RxSwift.Event<Self.E>) -> Swift.Void) -> Disposable
        let observable = Observable.of("A","B","C")
        
        //使用subscription常量存储这个订阅方法
        let disposable = observable.subscribe { (event) in
            print(event)
        }
        
        //调用这个订阅的dispose()方法
        disposable.dispose()
        
        
    }
    
    func disposeBag() {
        /**
         *
         *  1）除了 dispose()方法之外，我们更经常用到的是一个叫 DisposeBag 的对象来管理多个订阅行为的销毁：
         *      我们可以把一个 DisposeBag对象看成一个垃圾袋，把用过的订阅行为都放进去。
         *      而这个DisposeBag 就会在自己快要dealloc 的时候，对它里面的所有订阅行为都调用 dispose()方法。
         *
         *  2）下面是一个简单的使用样例。
         *
         */
        
        let disposeBag = DisposeBag()
        
        //第1个Observable，及其订阅
        let observable1 = Observable.of("A", "B", "C")
        observable1.subscribe { event in
            print(event)
            
        }.disposed(by: disposeBag)
        
        //第2个Observable，及其订阅
        let observable2 = Observable.of(1, 2, 3)
        observable2.subscribe { event in
            print(event)
            
        }.disposed(by: disposeBag)
        
 
    }
}






