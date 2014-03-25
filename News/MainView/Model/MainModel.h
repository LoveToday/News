//
//  MainModel.h
//  News
//
//  Created by lanou3g on 14-3-3.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject

@property (nonatomic, retain)NSString * specialId;
@property (nonatomic, retain)NSString * title;
@property (nonatomic, retain)NSString * recommendCount;
@property (nonatomic, retain)NSString * favoriteCount;
@property (nonatomic, retain)NSString * time;
@property (nonatomic, retain)NSString * summary;
@property (nonatomic, retain)NSString * userId;
@property (nonatomic, retain)NSString * name;
@property (nonatomic, retain)NSString * picUrl;
@property (nonatomic, retain)NSString * tagId;
@property (nonatomic, retain)NSString * bigPic;
@property (nonatomic, retain)NSString * mark;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
