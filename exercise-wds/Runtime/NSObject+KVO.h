//
//  NSObject+KVO.h
//  exercise-wds
//
//  Created by wds on 2017/2/12.
//  Copyright © 2017年 JLRC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PGObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (KVO)

- (void)PG_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(PGObservingBlock)block;

- (void)PG_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
