//
//  WeakSingleton.h
//  exercise-wds
//
//  Created by wds on 2018/4/25.
//  Copyright © 2018年 JLRC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakSingleton : NSObject

//特殊的单例实现:在所有使用该单例的对象都释放后,单例对象本身也会自己释放.解决实践过程中出现的单例使用完毕之后,仍然一直存在的问题.
+ (id)sharedInstance;

@end
