//
//  HSPerson.h
//  05_ValueTypeAndeRerenceType
//
//  Created by cfzq on 2017/6/9.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSPerson : NSObject <NSCopying>
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,assign)float height;

@end
