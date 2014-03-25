//
//  AttentionCell.m
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "AttentionCell.h"
#import "UIImageView+AFNetworking.h"
#import "Url.h"
#import "AttentionModel.h"

@implementation AttentionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
        [self addSubview:_iconImage];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 20)];
        [self addSubview:_name];
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(60, 30, 200, 25) textContainer:nil];
        [self addSubview:_textView];
    }
    return self;
}
- (void)setModel:(AttentionModel *)model
{

    [_iconImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", forehttp, model.picture]] placeholderImage:nil];
    _name.text = model.name;
    _textView.text = model.description;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
