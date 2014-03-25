//
//  Singleton.h
//  News
//
//  Created by lanou3g on 14-3-6.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

@property (nonatomic, retain)NSDictionary * userInfo;

+ (Singleton *)defaultSingleton;

@end
