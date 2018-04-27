//
//  DSAirSandbox.h
//  exercise-wds
//
//  Created by wds on 2018/4/27.
//  Copyright © 2018年 JLRC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSAirSandbox : NSObject

+ (instancetype)sharedInstance;

- (void)enableSwipe;
- (void)showSandboxBrowser;

@end
