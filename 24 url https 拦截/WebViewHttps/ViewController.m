//
//  ViewController.m
//  WebViewHttps
//
//  Created by Mac on 2018/8/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"

#import "MajqInLineTest.h"

//oc 调用swift 需导入头文件：
//导入头文件方式为： 项目名-Swift.h
#import "WebViewHttps-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MajqInLineTest *l = [[MajqInLineTest alloc] init];
    [l testInlineMethod];
    
    MajqInlineSwiftTest *l2 = [[MajqInlineSwiftTest alloc] init];
    [l2 testInlineMethod];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
