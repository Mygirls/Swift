//
//  EighteenthViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/18.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EighteenthViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        
        Student.study("语文")
        
    }
}
