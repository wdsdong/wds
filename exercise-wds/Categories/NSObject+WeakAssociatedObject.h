//
//  NSObject+WeakAssociatedObject.h
//  exercise-wds
//
//  Created by wds on 2018/4/25.
//  Copyright © 2018年 JLRC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WeakAssociatedObject)

//添加 weak 特性的属性的实现
@property (nonatomic, copy) id object;

@end
