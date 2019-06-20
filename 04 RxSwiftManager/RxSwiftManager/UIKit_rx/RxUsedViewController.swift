//
//  RxUsedViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/17.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RxUsedViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //labelDemo_01()
        //labelDemo_02()
        
        //textFieldDemo_01()
        //textFieldDemo_02()
        textFieldDemo_03()
    }

   
}

// MARK: - label
extension RxUsedViewController
{
    
    /// 将数据绑定到 text 属性上（普通文本）
    func labelDemo_01() {
        let label = UILabel(frame:CGRect(x:20, y:40, width:300, height:100))
        self.view.addSubview(label)
        
        //创建一个计时器（每0.1秒发送一个索引数）
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        //将已过去的时间格式化成想要的字符串，并绑定到label上
        timer.map{ String(format: "%0.2d:%0.2d.%0.1d",
                          arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10]) }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    /// 将数据绑定到 attributedText 属性上（富文本）
    func labelDemo_02() {
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:40, width:300, height:100))
        self.view.addSubview(label)
        
        //创建一个计时器（每0.1秒发送一个索引数）
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
        
        //将已过去的时间格式化成想要的字符串，并绑定到label上
        timer.map(formatTimeInterval)
            .bind(to: label.rx.attributedText)
            .disposed(by: disposeBag)
        
    }
    
    //将数字转成对应的富文本
    func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString {
        let string = String(format: "%0.2d:%0.2d.%0.1d",
                            arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
        //富文本设置
        let attributeString = NSMutableAttributedString(string: string)
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSAttributedStringKey.font,
                                     value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
                                     range: NSMakeRange(0, 5))
        //设置字体颜色
        attributeString.addAttribute(NSAttributedStringKey.foregroundColor,
                                     value: UIColor.white, range: NSMakeRange(0, 5))
        //设置文字背景颜色
        attributeString.addAttribute(NSAttributedStringKey.backgroundColor,
                                     value: UIColor.orange, range: NSMakeRange(0, 5))
        return attributeString
    }
    
}


// MARK: - UITextField 与 UITextView
extension RxUsedViewController
{
    //注意：.orEmpty 可以将 String? 类型的 ControlProperty 转成 String，省得我们再去解包
    
    //监听单个 textField 内容的变化（textView 同理）
    func textFieldDemo_01() {
        //创建文本输入框
        let textField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
        textField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(textField)
        
        //当文本框内容改变时，将内容输出到控制台上
        textField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {
                print("您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
    }
    
    //监听单个 textField 内容的变化（textView 同理）
    func textFieldDemo_02() {
        //创建文本输入框
        let textField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
        textField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(textField)
        
        //当文本框内容改变时，将内容输出到控制台上
        textField.rx.text.orEmpty.changed
            .subscribe(onNext: {
                print("您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
    }
    
    //将内容绑定到其他控件上
    func textFieldDemo_03() {
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
        inputField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(inputField)
        
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
        outputField.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(outputField)
        
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:190, width:300, height:30))
        self.view.addSubview(label)
        
        //创建按钮
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:230, width:40, height:30)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
        
        
        //当文本框内容改变
        let input = inputField.rx.text.orEmpty.asDriver() // 将普通序列转换为 Driver
            .throttle(0.3) //在主线程中操作，0.3秒内值若多次改变，取最后一次
        
        //内容绑定到另一个输入框中
        input.drive(outputField.rx.text)
            .disposed(by: disposeBag)
        
        //内容绑定到文本标签中
        input.map{ "当前字数：\($0.count)" }
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        //根据内容字数决定按钮是否可用
        input.map{ $0.count > 5 }
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    
    
}

