//
//  MyClass.h
//  Foundation
//
//  Created by cfzq on 2017/6/20.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) NSString *string;

- (void)method1;

- (void)method2;

+ (void)classMethod1;

@end
