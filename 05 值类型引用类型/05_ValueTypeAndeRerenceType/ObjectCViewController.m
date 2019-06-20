//
//  ObjectCViewController.m
//  05_ValueTypeAndeRerenceType
//
//  Created by cfzq on 2017/6/8.
//  Copyright © 2017年 cfzq. All rights reserved.
//


#import "HSPerson.h"

#import "ObjectCViewController.h"
@class Student;
@class MyObj;
//******************

@interface ObjectCViewController ()

@end

@implementation ObjectCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    [self test01];
    
    NSLog(@"--------------------------");
    
    [self test02];
    
    NSLog(@"--------------------------");

    [self test03];
    
    NSLog(@"--------------------------");

    [self test04];

}

- (void)test01 {
    NSArray *array = @[@"1",@"2"];
    NSArray *temArray = array;
    NSLog(@"%p",array);     //0x6080000373c0
    NSLog(@"%p",temArray);  //0x6080000373c0  //相比于oc：a、b的地址是一样，而swift： a、b的地址不一样
    
    NSArray *array2 = @[@"1",@"2"];
    NSArray *temArray2 = array2;
    NSLog(@"%p",temArray2); //0x60800023b580
    temArray2 = @[@"3"];
    NSLog(@"%p",array2);    //0x60800023b580
    NSLog(@"%p",temArray2); //0x608000203fd0
}


- (void)test02 {

    //在 swift里面 值类型在复制时，会将存储在其中的值类型一并进行复制，而对于其中的引用类型的话，则复制一份 -->   引用
    //而 oc 里面，则是复制一份引用
    
    Student *student = [[Student alloc]init];
    NSLog(@"%ld",[student retainCount]);

    student.name = @"张三";
    NSArray *array = @[student];
    NSArray *temArray = array;
    student.name = @"李四";
    
    Student *a = (Student *)array[0];
    Student *b = (Student *)temArray[0];

    NSLog(@"%@",a.name);
    NSLog(@"%@",b.name);
    
}

- (void)test03 {
    //
    //浅拷贝就是对内存地址的复制，让目标对象指针和源对象指向同一片内存空间。如：
    char* str = (char*)malloc(100);
    char* str2 = str;
    
    NSLog(@"%s",str);
    NSLog(@"%s",str2);

    //浅拷贝只是对对象的简单拷贝，让几个对象共用一片内存，当内存销毁的时候，指向这片内存的几个指针需要重新定义才可以使用，要不然会成为野指针
    //在 iOS 里面， 使用retain 关键字进行引用计数，就是一种更加保险的浅拷贝。他既让几个指针共用同一片内存空间，又可以在release 由于计数的存在，不会轻易的销毁内存，达到更加简单使用的目的
    
    //深拷贝：
    //深拷贝是指拷贝对象的具体内容，而内存地址是自主分配的，拷贝结束之后，两个对象虽然存的值是相同的，但是内存地址不一样，两个对象也互不影响，互不干涉。
    
    //iOS里的深拷贝：
    
    //iOS提供了copy和mutableCopy方法，顾名思义，copy就是复制了一个imutable的对象，而mutableCopy就是复制了一个mutable的对象。以下将举几个例子来说明。
    //这里指的是NSString, NSNumber等等一类的对象。
    
    
    NSString *string = @"dddd";
    NSString *stringCopy = [string copy];

    NSMutableString *stringDCopy = [string mutableCopy];
    [stringDCopy appendString:@"!!"];
    
    NSLog(@"%p",string);            //0x1061dc6d0
    NSLog(@"%p",stringCopy);        //0x1061dc6d0
    NSLog(@"%p",stringDCopy);       //0x60800006fec0

    //查看内存可以发现，string和stringCopy指向的是同一块内存区域(weak reference),引用计数没有发生改变。而stringMCopy则是我们所说的真正意义上的复制，系统为其分配了新内存，是两个独立的字符串内容是一样的
    
    
    NSMutableString *temStr = [NSMutableString stringWithString:@"汉斯哈哈哈"];
    // 产生新对象
    NSString *copyString = [string copy];
    // 产生新对象
    NSMutableString *mutableCopyString = [string mutableCopy];
    
    NSLog(@"temStr = %p copyString = %p mutableCopyString = %p", temStr, copyString, mutableCopyString);
    //temStr                = 0x600000272100
    //copyString            = 0x10ac5a6f0
    //mutableCopyString     = 0x600000272280
    
    
    // 总结
    
    /**
     源对象类型          拷贝方法        副本对象类型      是否产生新对象         拷贝类型
                        copy          NSString          NO              浅拷贝（指针拷贝） 地址相同
     NSString
                      mutableCopy   NSMutableString     True            深拷贝（内容拷贝） 地址不同
     
     -------
                        copy          NSString          True            深拷贝（内容拷贝） 地址不同
     NSMutableString
                      mutableCopy    NSMutableString    True            深拷贝（内容拷贝） 地址不同
     
     注意：其他对象NSArray、NSMutableArray 、NSDictionary、NSMutableDictionary一样适用
     */
    
    //property里的copy、strong区别
    NSMutableString *testString = [NSMutableString stringWithFormat:@"汉斯哈哈哈"];

    Student *person = [[Student alloc] init];
    person.testName = testString;
    
    // 不能改变person.testName的值，因为其内部copy新的对象
    [testString appendString:@" hans"];
    
    NSLog(@"testName = %@  -- testString = %@", person.testName,testString);
    //testName = 汉斯哈哈哈  -- testString = 汉斯哈哈哈 hans      //防止可变字符串被修改
    //解读：

    /**  property copy 实际上就对testName干了这个
     
         - (void)setTestName:(NSString *)testName
         {
            _testName = [testName copy];
         }
     
        假设testName为NSMutableString，会发生什么事？
        @property (nonatomic, copy) NSMutableString *name;
     
         - (void)setTestName:(NSMutableString *)testName
         {
            _testName = [testName copy];
         }
        copy出来的仍然是不可变字符！如果有人用NSMutableString的方法，就会崩溃:[person.testName appendString:@" hans"];错误的写法
     
     */
    
    NSMutableString *testString03 = [NSMutableString stringWithFormat:@"汉斯哈哈哈"];
    
    Student *person03 = [[Student alloc] init];
    person03.testName03 = testString;
    
    // 不能改变person.testName的值，因为其内部copy新的对象
    [testString03 appendString:@" hans"];
    
    NSLog(@"testName03 = %@  -- testString03 = %@", person03.testName03,testString03);
    //testName03 = 汉斯哈哈哈 hans  -- testString03 = 汉斯哈哈哈 hans     //属性值 --> 被修改


    
    
    //拷贝构造：
    
    //当然在 ios 中并不是所有的对象都支持copy，mutableCopy，遵守NSCopying协议的类可以发送copy消息，遵守NSMutableCopying协议的类才可以发送mutableCopy消息。
    
    //假如发送了一个没有遵守上诉两协议而发送copy或者 mutableCopy,那么就会发生异常。但是默认的ios类并没有遵守这两个协议。如果想自定义一下copy 那么就必须遵守NSCopying,并且实现 copyWithZone: 方法，如果想自定义一下mutableCopy 那么就必须遵守NSMutableCopying,并且实现 mutableCopyWithZone: 方法。
    
    //如果是我们定义的对象，那么我们自己要实现NSCopying , NSMutableCopying这样就能调用copy和mutablecopy了。举个例子
    
 
}

- (void)test04 {

    HSPerson *p = [[HSPerson alloc] init];
    p.age = 20;
    p.height = 170.0;
    
    //Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[HSPerson copyWithZone:]: unrecognized selector sent to instance 0x60800022c500
    NSLog(@"%p",p); //0x60800003d060
    HSPerson *copyP = [p copy]; // 这里崩溃
    NSLog(@"%p",copyP); //0x10632a800
    //可以看出copyWithZone重新分配新的内存空间
    
    NSLog(@"age = %ld height = %f", copyP.age, copyP.height);//age = 0 height = 0.000000
    //虽然copy了份新的对象，然而age,height值并未copy，那么：(去HSPerson.m 文件中查看 实现的三个协议比较)

}

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

//___________


@implementation Student

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setName:(NSString *)name
{
    _name = name;
    
}





@end

//----------------------
@interface MyObj : NSObject<NSCopying, NSMutableCopying>{
    NSMutableString *_name;
    NSString * _imutableStr ;
    int _age;
}
@property (nonatomic, retain) NSMutableString *name;
@property (nonatomic, retain) NSString *imutableStr;
@property (nonatomic) int age;

@end


@implementation MyObj

- (id)copyWithZone:(NSZone *)zone{
    MyObj *copy = [[[self class] allocWithZone :zone] init];
    copy->_name = [_name copy];
    copy->_imutableStr = [_imutableStr copy];
    copy->_age = _age;
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    MyObj *copy = NSCopyObject(self, 0, zone);
    copy->_name = [_name mutableCopy];
    copy->_age = _age;
    return copy;
}

@end
