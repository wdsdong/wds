//
//  ViewController.m
//  exercise-wds
//
//  Created by wds on 2017/2/7.
//  Copyright © 2017年 JLRC. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Model.h"
#import "ArcSingleton.h"
@interface ViewController ()

/** model*/
@property (strong, nonatomic) Model *model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self method1];
    [self method2];
    [self method3];
    [self method4];
    [self method5];
    [self method6];
    [self method7];
    [self method8];
}

//获取属性列表
- (void)method1 {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self.model class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);
        NSLog(@"%s",propertyName);
    }
}

//获取成员变量列表
- (void)method2 {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self.model class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivarList[i];
        const char* ivarName = ivar_getName(ivar);
        NSLog(@"%s",ivarName);
    }
}

//获取方法列表
- (void)method3 {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList([self.model class], &count);
    for (int i = 0; i < count; i ++) {
        Method method = methodList[i];
        SEL sel = method_getName(method);
        NSLog(@"%@",NSStringFromSelector(sel));
    }
}

//获取协议列表
- (void)method4 {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self.model class], &count);
    for (int i = 0; i < count; i ++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        NSLog(@"%s",protocolName);
    }
}

//获得类方法
- (void)method5 {
    Method method = class_getClassMethod([self.model class], NSSelectorFromString(@"test1"));
}

//获得实例方法
- (void)method6 {
    Method method = class_getInstanceMethod([self.model class], NSSelectorFromString(@"test2"));
}

//添加方法
- (void)method7 {
    class_addMethod([self.model class], NSSelectorFromString(@"add"), (IMP)add, "v@:");
    [self.model performSelectorOnMainThread:NSSelectorFromString(@"add") withObject:nil waitUntilDone:YES];
}

void add() {
    NSLog(@"add");
}

//交换方法
- (void)method8 {
    Method test1 = class_getClassMethod([self.model class], NSSelectorFromString(@"test1"));
    Method test2 = class_getInstanceMethod([self.model class], NSSelectorFromString(@"test2"));
    method_exchangeImplementations(test1, test2);
    [Model test1];
    [self.model performSelectorOnMainThread:NSSelectorFromString(@"test2") withObject:nil waitUntilDone:YES];

}

//拦截并替换方法
- (void)method9 {
    SEL sel1 = @selector(test1);
    Method method1 = class_getClassMethod([self.model class], sel1);
    IMP imp1 = method_getImplementation(method1);
    SEL sel2 = @selector(test2);
    Method method2 = class_getInstanceMethod([self.model class], NSSelectorFromString(@"test2"));
    IMP imp2 = method_getImplementation(method2);
    
    BOOL ret = class_addMethod([self.model class], sel1, imp2, method_getTypeEncoding(method2));
    if (ret) {
        class_replaceMethod([self.model class], sel2, imp1, method_getTypeEncoding(method1));
    } else {
        method_exchangeImplementations(method1, method2);
    }
}

//拦截并替换方法
- (void)method10 {
    //load方法会在类第一次加载的时候被调用,调用的时间比较靠前，适合在这个方法里做方法交换,方法交换应该被保证，在程序中只会执行一次。
}

//实现NSCoding的自动归档和解归档
- (void)method11 {
    
}

- (Model *)model {
    if (!_model) {
        _model = [[Model alloc] init];
    }
    return _model;
}

@end
