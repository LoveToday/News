//
//  HeadView.m
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 80, 80)];
        [self addSubview:_iconImage];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
        [self addSubview:_name];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(100, 45, 200, 50) textContainer:nil];
        _textView.selectable = NO;
        [self addSubview:_textView];
        
        self.segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"我的微博", @"我的粉丝", @"我的关注", nil]];
        _segment.frame = CGRectMake(10, 100, 300, 40);
        [self addSubview:_segment];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
