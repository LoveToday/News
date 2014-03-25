//
//  SpecificialModel.h
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecificialModel : NSObject

@property (nonatomic, retain)NSString * picture;
@property (nonatomic, retain)NSString * name;
@property (nonatomic, retain)NSString * description;
@property (nonatomic, retain)NSString * title;
@property (nonatomic, retain)NSString * content;
@property (nonatomic, retain)NSString * bigPic;
@property (nonatomic, retain)NSString * url;
@property (nonatomic, retain)NSString * source;


- (id)initWithDictionary:(NSDictionary *)dic;

@end
