//
//  ObjectCViewController.h
//  05_ValueTypeAndeRerenceType
//
//  Created by cfzq on 2017/6/8.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObjectCViewController : UIViewController

@end


//------------------
@interface Student : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *testName;            //测试 copy 、strong 的区别
@property(nonatomic,copy)NSMutableString *testName02;   //测试 copy 、strong 的区别
@property(nonatomic,strong)NSString *testName03;        //测试 copy 、strong 的区别

@end

