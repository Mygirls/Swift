//
//  RuntimeCategoryClass.m
//  Runtime Test Demo
//
//  Created by JQ on 2017/9/20.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "RuntimeCategoryClass.h"
#import <objc/runtime.h>

@interface RuntimeCategoryClass (Category)
- (void)method2;
@end


@implementation RuntimeCategoryClass

- (void)method1 {
}

@end


@implementation RuntimeCategoryClass (Category)
- (void)method2 {
    
}
@end


