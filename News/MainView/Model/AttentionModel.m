//
//  AttentionModel.m
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "AttentionModel.h"

@implementation AttentionModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.picture = [dic objectForKey:@"avatar"];
        self.name = [dic objectForKey:@"nick"];
        self.description = [dic objectForKey:@"description"];
    }
    return self;
}

@end
