//
//  TwelfthViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/17.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TwelfthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        
        //demo_01()
        
        //demo_02()
        
        //replay_03()
        
        //multicast_04()
        
        //refCount_05()
        
        share_06()
    }

    /**
     可连接的序列（Connectable Observable）：
     （1）可连接的序列和一般序列不同在于：有订阅时不会立刻开始发送事件消息，只有当调用 connect()之后才会开始发送值。
     （2）可连接的序列可以让所有的订阅者订阅后，才开始发出事件消息，从而保证我们想要的所有订阅者都能接收到事件消息。
     */
    
    
    /// 普通序列的样例
    func demo_01() {
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //第二个订阅者（延迟5秒开始订阅）

        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        
        /**
         运行结果如下。可以看到第一个订阅者订阅后，每隔 1 秒会收到一个值。而第二个订阅者 5 秒后才收到第一个值 0，所以两个订阅者接收到的值是不同步的。
         订阅1: 0
         订阅1: 1
         订阅1: 2
         订阅1: 3
         订阅1: 4
         订阅1: 5
         订阅2: 0
         订阅1: 6
         订阅2: 1
         订阅1: 7
         ...
         */
        
    }
    
    ///延迟执行
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - closure: 延迟执行的闭包
    public func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    
    /// publish 方法会将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始。
    func demo_02() {
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .publish()
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        /**
         订阅1: 0
         订阅1: 1
         订阅1: 2
         订阅2: 2
         订阅1: 3
         订阅2: 3
         订阅1: 4
         订阅2: 4
         ...
         */
        
    }
    /**
     replay 同上面的 publish 方法相同之处在于：会将将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始。
     replay 与 publish 不同在于：新的订阅者还能接收到订阅之前的事件消息（数量由设置的 bufferSize 决定）。
     */
    ///replay
    func replay_03() {
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .replay(5)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        
        /**
         订阅1: 0
         订阅1: 1
         订阅2: 0
         订阅2: 1
         订阅1: 2
         订阅2: 2
         订阅1: 3
         订阅2: 3
         订阅1: 4
         订阅2: 4
         ...
         */
    }
    
    
    /**
     multicast 方法同样是将一个正常的序列转换成一个可连接的序列。
     同时 multicast 方法还可以传入一个 Subject，每当序列发送事件时都会触发这个 Subject 的发送。
     */
    /// multicast
    func multicast_04() {
        //创建一个Subject（后面的multicast()方法中传入）
        let subject = PublishSubject<Int>()
        
        //这个Subject的订阅
        _ = subject
            .subscribe(onNext: { print("Subject: \($0)") })
        
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .multicast(subject)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        
        /**
         Subject: 0
         订阅1: 0
         Subject: 1
         订阅1: 1
         Subject: 2
         订阅1: 2
         订阅2: 2
         Subject: 3
         订阅1: 3
         ...
         */
    }
    
    
    /**
     refCount 操作符可以将可被连接的 Observable 转换为普通 Observable
     即该操作符可以自动连接和断开可连接的 Observable。当第一个观察者对可连接的Observable 订阅时，那么底层的 Observable 将被自动连接。当最后一个观察者离开时，那么底层的 Observable 将被自动断开连接。

     */
    /// refCount
    func refCount_05() {
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .publish()
            .refCount()
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        
        /**
         订阅1: 0
         订阅1: 1
         订阅1: 2
         订阅1: 3
         订阅1: 4
         订阅1: 5
         订阅2: 5
         订阅1: 6
         订阅2: 6
         ...
         */
        
    }
    
    
    /**
     该操作符将使得观察者共享源 Observable，并且缓存最新的 n 个元素，将这些元素直接发送给新的观察者。
     简单来说 shareReplay 就是 replay 和 refCount 的组合。
     */
    /// share
    func share_06() {
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .share(replay: 5)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }

    }

}
