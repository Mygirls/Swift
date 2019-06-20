//
//  TestTableViewCell.m
//  RxSwiftManager
//
//  Created by Majq on 2018/9/20.
//  Copyright © 2018年 Majq. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    static int a = 0 ;
    a ++;
    NSLog(@"测试a = %d",a);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
