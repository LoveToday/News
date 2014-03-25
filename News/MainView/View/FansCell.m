//
//  FansCell.m
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "FansCell.h"
#import "FansModel.h"
#import "UIImageView+AFNetworking.h"
#import "Url.h"

@implementation FansCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
        [self addSubview:_iconImageView];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 20)];
        [self addSubview:_name];
    }
    return self;
}
- (void)setModel:(FansModel *)model
{

    [_iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", forehttp, model.picture]] placeholderImage:nil];
    _name.text = model.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
