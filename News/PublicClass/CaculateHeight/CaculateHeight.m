//
//  CaculateHeight.m
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "CaculateHeight.h"

@implementation CaculateHeight
- (CGFloat)hightLableUIFont:(UIFont *)font sendString:(NSString *)str
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(310, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    CGFloat hight = textRect.size.height;
    return hight;
}
@end
