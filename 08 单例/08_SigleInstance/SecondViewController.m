//
//  SecondViewController.m
//  08_SigleInstance
//
//  Created by cfzq on 2017/6/16.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "SecondViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
}

#pragma mark - *** Object-C 单例方法
+ (id)shareManger {
    
    //适用GCD 中的dispatch_once_t 可以保证里面的代码只被掉用一次，已保证单例在线程上的安全
    static SecondViewController * obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc] init];
    });
    
    return  obj;
}

#warning 编译标记

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
