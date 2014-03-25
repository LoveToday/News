//
//  FansModel.h
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FansModel : NSObject

@property (nonatomic, retain)NSString * picture;
@property (nonatomic, retain)NSString * name;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
