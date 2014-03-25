//
//  SpecificialCell.h
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpecificialModel;
@interface SpecificialCell : UITableViewCell
{
    UIImageView * _iconImageView;
    UILabel * _name;
    UITextView * _description;
    UILabel * _title;
    UIImageView * _bigPicture;
    UILabel * _content;
    UILabel * _source;
    
}

@property (nonatomic, retain)SpecificialModel * model;
@property (nonatomic, assign)int flag;
@property (nonatomic, retain)UIButton * urlButton;
@property (nonatomic, assign)float height;

@end
