//
//  NSObject+WeakAssociatedObject.m
//  exercise-wds
//
//  Created by wds on 2018/4/25.
//  Copyright © 2018年 JLRC. All rights reserved.
//

#import "NSObject+WeakAssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject (WeakAssociatedObject)

- (void)setObject:(id)object {
    id __weak weakObject = object;
    id(^block)() = ^() {
        return weakObject;
    };
    objc_setAssociatedObject(self, @selector(object), block, OBJC_ASSOCIATION_COPY);
}

- (id)object {
    id (^block)() = objc_getAssociatedObject(self, @selector(object));
    return (block ? block() : nil);
}

@end
