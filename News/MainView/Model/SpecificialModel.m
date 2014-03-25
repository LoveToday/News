//
//  SpecificialModel.m
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "SpecificialModel.h"

@implementation SpecificialModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.picture = [[[[dic objectForKey:@"messageInfos"] firstObject] objectForKey:@"user"] objectForKey:@"avatar"];
        self.name = [[[[dic objectForKey:@"messageInfos"] firstObject] objectForKey:@"user"] objectForKey:@"nick"];
        self.description = [[[[dic objectForKey:@"messageInfos"] firstObject] objectForKey:@"user"] objectForKey:@"description"];
        self.title = [dic objectForKey:@"title"];
        self.content = [dic objectForKey:@"content"];
        self.source = [dic objectForKey:@"source"];
        self.url = [dic objectForKey:@"url"];
        if ([[dic allKeys] containsObject:@"thumbnail"]) {
            self.bigPic = [dic objectForKey:@"thumbnail"];
        }else self.bigPic = nil;
    }
    return self;
}


@end
