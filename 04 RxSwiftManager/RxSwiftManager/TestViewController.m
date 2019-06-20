//
//  TestViewController.m
//  RxSwiftManager
//
//  Created by Majq on 2018/9/6.
//  Copyright © 2018年 Majq. All rights reserved.
//

#import "TestViewController.h"

//oc 里面调用swift
#import "RxSwiftManager-Swift.h"
#import "TestTableViewCell.h"
@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.rowHeight = 150;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil] forCellReuseIdentifier:@"TestTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellId = @"TestTableViewCell";
//    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell == nil) {
//        cell = [[NSBundle mainBundle]loadNibNamed:@"TestTableViewCell" owner:nil options:nil].lastObject;   //这种方法要设置xib 的 id
//    }
    
    TestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell" forIndexPath:indexPath]; //这种方法要注册cell

    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


@end
