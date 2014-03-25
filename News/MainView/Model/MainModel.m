//
//  MainModel.m
//  News
//
//  Created by lanou3g on 14-3-3.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.specialId = [dic objectForKey:@"id"];
        self.title = [dic objectForKey:@"title"];
        self.recommendCount = [dic objectForKey:@"forward_count"];
        self.favoriteCount = [dic objectForKey:@"like_count"];
        self.time = [dic objectForKey:@"created_at"];
        self.userId = [[[dic objectForKey:@"message_info"] objectForKey:@"user"] objectForKey:@"id"];
        self.name = [[[dic objectForKey:@"message_info"] objectForKey:@"user"] objectForKey:@"nick"];
        self.picUrl = [[[dic objectForKey:@"message_info"] objectForKey:@"user"] objectForKey:@"avatar"];
        self.tagId = [[[dic objectForKey:@"tags"] firstObject] objectForKey:@"tag_id"];
        if ([[dic allKeys] containsObject:@"thumbnail"]) {
            self.bigPic = [dic objectForKey:@"thumbnail"];
            self.summary = nil;
        }else{
            self.summary = [dic objectForKey:@"summary"];
            self.bigPic = nil;
        }
        self.mark = [[[dic objectForKey:@"tags"] firstObject] objectForKey:@"name"];
    }
    return self;
}

@end