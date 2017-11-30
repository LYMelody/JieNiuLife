//
//  TestClass.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/29.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "TestClass.h"


@implementation TestClass

@synthesize foo = _foo;

- (id)foo {
    return _foo;
}

- (void)setFoo:(id)foo {
    
    _foo = foo;
    
}

@end

//int main(int argc,const char *argv[]) {
//
//    TestClass *obj = [TestClass new];
//    obj.foo = [NSObject new];
//    NSLog(@"foo is %@",obj.foo);
//    return 0;
//}


