//
//  WeakSingleton.m
//  exercise-wds
//
//  Created by wds on 2018/4/25.
//  Copyright © 2018年 JLRC. All rights reserved.
//

#import "WeakSingleton.h"

@implementation WeakSingleton

+ (id)sharedInstance { //同步锁实现
    static __weak WeakSingleton *instance;
    WeakSingleton *strongInstance = instance;
    @synchronized(self) {
        if (strongInstance == nil) {
            strongInstance = [[WeakSingleton alloc] init];
            instance = strongInstance;
        }
    }
    return  strongInstance;
}

+ (id)sharedInstance2 { //GCD 实现
    static __weak WeakSingleton *instance;
    __block WeakSingleton *strongInstance = instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        strongInstance = [[WeakSingleton alloc] init];
        instance = strongInstance;
    });
    return  strongInstance;
}

@end
