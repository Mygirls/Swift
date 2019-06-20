//
//  FifthveViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/7.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class FifthveViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //demo_01()
        //demo_02()
        
        
        demo_03()
    }
}


// MARK: - 自定义可绑定属性
extension FifthveViewController
{
    //通过对 UI 类进行扩展
    func demo_01() {
        label.text = "这是一个测试"
        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        
        observable
            .map { (fontSize) -> CGFloat in
                if fontSize > 20 {
                    return CGFloat(20)
                }
                return CGFloat(fontSize)
            }
            .bind(to: label.fontSize) //根据索引数不断变放大字体
            .disposed(by: disposeBag)
        
        
        /**
         public func bind<O>(to observer: O) -> Disposable where O : ObserverType, Self.E == O.E
         参数： O 需要满足条件【遵守协议ObserverType，Self.E == O.E，即CGFloat】
         */
    }

    
    //通过对 Reactive 类进行扩展
    func demo_02() {
        label.text = "这是一个测试"
        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable
            .map { (fontSize) -> CGFloat in
                if fontSize > 20 {
                    return CGFloat(20)
                }
                return CGFloat(fontSize)
                
            }
            .bind(to: label.rx.fontSize) //根据索引数不断变放大字体
            .disposed(by: disposeBag)
    
      }
}


// MARK: - RxSwift 自带的可绑定属性（UI 观察者）
extension FifthveViewController
{
    //  1）其实 RxSwift 已经为我们提供许多常用的可绑定属性。比如 UILabel 就有 text 和 attributedText 这两个可绑定属性。
    func demo_03()  {
        
        //例如：
//        label.rx.text
//        label.rx.attributedText
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map { "当前索引数：\($0 )"}
            .bind(to: label.rx.text) //收到发出的索引数后显示到label上
            .disposed(by: disposeBag)
        
    }
}


//通过对 UI 类进行扩展
extension UILabel {
    public var fontSize: Binder<CGFloat> {
        //  Binder 初始化方法
        //    public init<Target: AnyObject>(_ target: Target, scheduler: ImmediateSchedulerType = MainScheduler(), binding: @escaping (Target, Value) -> ()) {}
        return Binder(self) { label, fontSize in
            print("fontSize = \(fontSize)")
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

//通过对 Reactive 类进行扩展
extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

//RxSwift 自带的可绑定属性（UI 观察者）
extension Reactive where Base: UILabel {
    //其实 RxSwift 已经为我们提供许多常用的可绑定属性。比如 UILabel 就有 text 和 attributedText 这两个可绑定属性。
    /// Bindable sink for `text` property.
//    public var text: Binder<String?> {
//        return Binder(self.base) { label, text in
//            label.text = text
//        }
//    }
//
//    /// Bindable sink for `attributedText` property.
//    public var attributedText: Binder<NSAttributedString?> {
//        return Binder(self.base) { label, text in
//            label.attributedText = text
//        }
//    }
    
   
}



