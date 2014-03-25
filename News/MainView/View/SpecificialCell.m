//
//  SpecificialCell.m
//  News
//
//  Created by lanou3g on 14-3-4.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "SpecificialCell.h"
#import "SpecificialModel.h"
#import "UIImageView+AFNetworking.h"
#import "Url.h"

@implementation SpecificialCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([reuseIdentifier isEqualToString:@"cell"]) {
            _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 50, 50)];
            [self addSubview:_iconImageView];
            
            _name = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 100, 20)];
            [self addSubview:_name];
            
            _description = [[UITextView alloc] initWithFrame:CGRectMake(100, 35, 80, 20)];
            _description.selectable = NO;
            [self addSubview:_description];
        }else if ([reuseIdentifier isEqualToString:@"cellIndentifier"]){
            _title = [[UILabel alloc] initWithFrame:self.frame];
        }else if ([reuseIdentifier isEqualToString:@"content"]){
            _content = [[UILabel alloc] init];
            [self addSubview:_content];
            
            _source = [[UILabel alloc] initWithFrame:CGRectMake(20, _content.frame.size.height+20, 100, 30)];
            [self addSubview:_source];
            
            _urlButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _urlButton.frame = CGRectMake(200, _content.frame.size.height+20, 100, 30);
            [_urlButton setTitle:@"查看原文" forState:UIControlStateNormal];
            [self addSubview:_urlButton];
        }else if ([reuseIdentifier isEqualToString:@"picture"]){
            _bigPicture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 70)];
            [self addSubview:_bigPicture];
            
            _content = [[UILabel alloc] init];
            [self addSubview:_content];
            
            _source = [[UILabel alloc] initWithFrame:CGRectMake(20, 10+_bigPicture.frame.size.height+_content.frame.size.height+20, 100, 30)];
            [self addSubview:_source];
            
            _urlButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_urlButton setTitle:@"查看原文" forState:UIControlStateNormal];
            _urlButton.frame = CGRectMake(200, 10+_bigPicture.frame.size.height+_content.frame.size.height+20, 100, 30);
            [self addSubview:_urlButton];
        }
    }
    return self;
}
- (void)setModel:(SpecificialModel *)model
{
    _content.frame = CGRectMake(5, 5, 310, _height);
    [_iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", forehttp, model.picture]] placeholderImage:nil];
    _name.text = model.name;
    _description.text = model.description;
    _title.text = model.title;
    _content.text = model.content;
    _source.text = model.source;
    if (_flag == 1) {
        _content.frame = CGRectMake(5, 100, 310, _height);
        [_bigPicture setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", forehttp, model.bigPic]] placeholderImage:nil];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
