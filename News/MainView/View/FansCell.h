//
//  FansCell.h
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FansModel;
@interface FansCell : UITableViewCell

{
    UIImageView * _iconImageView;
    UILabel * _name;
}

@property (nonatomic, retain)FansModel * model;

@end
