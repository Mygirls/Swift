//
//  ToolTestViewController.swift
//  RxSwiftManager
//
//  Created by Majq on 2018/9/20.
//  Copyright © 2018年 Majq. All rights reserved.
//

import UIKit

class ToolTestViewController: UIViewController {
    @IBOutlet weak var testView: UIView!
    
    @IBOutlet weak var testImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testView.majq.shapeLayer(roundedRect: testView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20))
        testView.backgroundColor = UIColor.gray

        testImgView.image = UIImage.init(named: "1.png")
        testImgView.majq.graphicsCutRoundCorners(roundedRect: testImgView.bounds, cornerRadius: 10)
        

    }

   

}
