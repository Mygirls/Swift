//
//  ViewController.m
//  T
//
//  Created by JQ on 2017/9/15.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
#import "MajqTestView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    
    MajqTestView *v = [[NSClassFromString(@"MajqTestView") alloc] init];
    NSLog(@"%@",v);
    v.frame = CGRectMake(100, 100, 10, 100);
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
