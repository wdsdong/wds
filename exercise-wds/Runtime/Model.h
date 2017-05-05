//
//  Model.h
//  exercise-wds
//
//  Created by wds on 2017/2/7.
//  Copyright © 2017年 JLRC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDSDelegate.h"
@interface Model : NSObject<WDSDelegate>
{
    NSString *_score;
}
/** age*/
@property (copy, nonatomic) NSString *age;
/** height*/
@property (copy, nonatomic) NSString *height;

+ (void)test1;

- (void)test2;

@end
