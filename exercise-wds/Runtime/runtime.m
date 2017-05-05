//
//  runtime.m
//  exercise-wds
//
//  Created by wds on 2017/2/12.
//  Copyright © 2017年 JLRC. All rights reserved.
//

#import "runtime.h"
#import <objc/runtime.h>

#define encodeRuntime(A) \
\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [self valueForKey:key];\
[encoder encodeObject:value forKey:key];\
}\
free(ivars);\
\

#define initCoderRuntime(A) \
\
if (self = [super init]) {\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [decoder decodeObjectForKey:key];\
[self setValue:value forKey:key];\
}\
free(ivars);\
}\
return self;\
\

@implementation runtime

- (void)runtimeMethod {
//    objc_class;类
//    objc_object;对象
//    objc_method;方法
    
    
    struct objc_class {
        Class isa  OBJC_ISA_AVAILABILITY;
        
#if !__OBJC2__
        Class super_class                                        OBJC2_UNAVAILABLE;
        const char *name                                         OBJC2_UNAVAILABLE;
        long version                                             OBJC2_UNAVAILABLE;
        long info                                                OBJC2_UNAVAILABLE;
        long instance_size                                       OBJC2_UNAVAILABLE;
        struct objc_ivar_list *ivars                             OBJC2_UNAVAILABLE;
        struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
        struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
        struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
#endif
        
    } OBJC2_UNAVAILABLE;

    
    struct objc_object {
        Class isa  OBJC_ISA_AVAILABILITY;
    };
    
    
    struct objc_method {
        SEL method_name;
        char *method_types;    /* a string representing argument/return types */
        IMP method_imp;
    };
    
    
    
    //    获取属性列表
    //    class_copyPropertyList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    //    property_getName(<#objc_property_t property#>)
    //    添加属性
    //    class_addProperty(<#__unsafe_unretained Class cls#>, <#const char *name#>, <#const objc_property_attribute_t *attributes#>, <#unsigned int attributeCount#>)
    
    //    获取成员变量列表
    //    class_copyIvarList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    //    获取成员变量名称
    //    ivar_getName(<#Ivar v#>)
    //    获取成员变量类型
    //    ivar_getTypeEncoding(<#Ivar v#>)
    //    添加成员变量
    //    class_addIvar(<#__unsafe_unretained Class cls#>, <#const char *name#>, <#size_t size#>, <#uint8_t alignment#>, <#const char *types#>)
    
    //    获取方法列表
    //    class_copyMethodList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    //    获取方法名称
    //    method_getName(<#Method m#>)
    //    获取方法的实现
    //    method_getImplementation(<#Method m#>)
    //    获取方法编码类型
    //    method_getTypeEncoding(<#Method m#>)
    //    添加方法
    //    class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
    
    //    获取协议列表
    //    class_copyProtocolList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    //    protocol_getName(<#Protocol *p#>)
    //    添加协议
    //    class_addProtocol(<#__unsafe_unretained Class cls#>, <#Protocol *protocol#>)
    
    //    获取类方法
    //    class_getClassMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>)
    //    获取实例方法
    //    class_getInstanceMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>)
    
    //    获取方法的实现
    //    class_getMethodImplementation(<#__unsafe_unretained Class cls#>, <#SEL name#>)
    
    //    替换方法实现
    //    class_replaceMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
    //    交换方法实现
    //    method_exchangeImplementations(<#Method m1#>, <#Method m2#>)
    
    //    设置关联对象
    //    objc_setAssociatedObject(<#id object#>, <#const void *key#>, <#id value#>, <#objc_AssociationPolicy policy#>)
    //    获取关联对象
    //    objc_getAssociatedObject(<#id object#>, <#const void *key#>)
    //    移除关联对象
    //    objc_removeAssociatedObjects(<#id object#>)
    
    
    //    动态消息解析和转发
    //    通常情况下，在方法没有找到的时候,程序会在运行时挂掉并抛出 unrecognized selector sent to … 的异常。但在异常抛出前，Objective-C 的运行时会给你三次拯救程序的机会：
    //    1.Method resolution
    //    会调用 +resolveInstanceMethod: 或者 +resolveClassMethod:，让你有机会提供一个函数实现。如果你添加了函数并返回 YES， 那运行时系统就会重新启动一次消息发送的过程,如果返回 NO,则进行下一步
    //    2.Fast forwarding
    //    目标对象实现了 -forwardingTargetForSelector: ，Runtime 这时就会调用这个方法，给你把这个消息转发给其他对象的机会.只要这个方法返回的不是 nil 和 self，整个消息发送的过程就会被重启，当然发送的对象会变成你返回的那个对象。否则，就会继续 Normal Fowarding
    //    3.Normal forwarding
    //    这一步是 Runtime 最后一次给你挽救的机会。首先它会发送 -methodSignatureForSelector: 消息获得函数的参数和返回值类型。如果 -methodSignatureForSelector: 返回 nil ，Runtime 则会发出 -doesNotRecognizeSelector: 消息，程序这时也就挂掉了。如果返回了一个函数签名，Runtime 就会创建一个 NSInvocation 对象并发送 -forwardInvocation: 消息给目标对象。
    //    NSInvocation 实际上就是对一个消息的描述，包括selector 以及参数等信息。所以你可以在 -forwardInvocation: 里修改传进来的 NSInvocation 对象，然后发送 -invokeWithTarget: 消息给它，传进去一个新的目标
    
}

@end
