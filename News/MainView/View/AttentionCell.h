//
//  AttentionCell.h
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AttentionModel;
@interface AttentionCell : UITableViewCell
{
    UIImageView * _iconImage;
    UILabel * _name;
    UITextView * _textView;
}

@property (nonatomic, retain)AttentionModel * model;
@end
