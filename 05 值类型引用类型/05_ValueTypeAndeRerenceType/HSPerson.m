//
//  HSPerson.m
//  05_ValueTypeAndeRerenceType
//
//  Created by cfzq on 2017/6/9.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "HSPerson.h"

@implementation HSPerson
//可以看出copyWithZone重新分配新的内存空间
//- (id)copyWithZone:(nullable NSZone *)zone {
//
//    return @"你好啊！";
//}

//虽然copy了份新的对象，然而age,height值并未copy，那么
//- (id)copyWithZone:(NSZone *)zone
//{
//    HSPerson *person = [[HSPerson allocWithZone:zone] init];
//    return person;
//    
//    // 有些人可能下面alloc,重新初始化空间，但这方法已给你分配了zone，自己就无需再次alloc内存空间了
//    //    HSPerson *person = [[HSPerson alloc] init];
//}

- (id)copyWithZone:(NSZone *)zone
{
    HSPerson *person = [[HSPerson allocWithZone:zone] init];
    person.age = self.age;
    person.height = self.height;
    // 这里self其实就要被copy的那个对象，很显然要自己赋值给新对象，所以这里可以控制copy的属性
    return person;
}
@end
