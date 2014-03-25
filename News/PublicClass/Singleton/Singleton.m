//
//  Singleton.m
//  News
//
//  Created by lanou3g on 14-3-6.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "Singleton.h"
static Singleton * sing = nil;
@implementation Singleton

+ (Singleton *)defaultSingleton
{
    @synchronized(self){
        if (sing == nil) {
            sing = [[Singleton alloc] init];
        }
        return sing;
    }
}

@end
