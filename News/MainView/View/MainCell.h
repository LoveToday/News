//
//  MainCell.h
//  News
//
//  Created by lanou3g on 14-3-3.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainModel;
@interface MainCell : UITableViewCell
{
    UIImageView * _iconImage;
    UILabel * _name;
    UILabel * _time;
    UILabel * _title;
    UILabel * _favorite;
    UILabel * _recommend;
    UILabel * _summary;
    UIImageView * _bigPic;
    UIImageView * _fImage;
    UIImageView * _rImage;
}

@property (nonatomic, retain)MainModel * model;
@property (nonatomic, assign)int flag;
@property (nonatomic, retain)UIButton * markButton;

@end
