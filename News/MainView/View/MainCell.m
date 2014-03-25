//
//  MainCell.m
//  News
//
//  Created by lanou3g on 14-3-3.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "MainCell.h"
#import "MainModel.h"
#import "UIImageView+AFNetworking.h"
#import "Url.h"

@implementation MainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]]];
        
        // Initialization code
        if ([reuseIdentifier isEqualToString:@"cell"]) {
            _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 50, 50)];
            [self addSubview:_iconImage];
            
            _name = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 100, 20)];
            [self addSubview:_name];
            
            _time = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 80, 20)];
            [self addSubview:_name];
            
        }else if ([reuseIdentifier isEqualToString:@"cellIndentifier"]){
            _title = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 260, 30)];
            _title.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_title];
            
            _favorite = [[UILabel alloc] initWithFrame:CGRectMake(50, 35, 30, 30)];
            [self addSubview:_favorite];
            
            _recommend = [[UILabel alloc] initWithFrame:CGRectMake(100, 35, 30, 30)];
            [self addSubview:_recommend];
            
            _fImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35, 30, 30)];
            [_fImage setImage:[UIImage imageNamed:@"002.png"]];
            [self addSubview:_fImage];
            
            _rImage = [[UIImageView alloc] initWithFrame:CGRectMake(80, 35, 30, 30)];
            [_rImage setImage:[UIImage imageNamed:@""]];
            [self addSubview:_rImage];
            
            _markButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_markButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _markButton.frame = CGRectMake(120, 40, 100, 20);
            _markButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [self addSubview:_markButton];
            
            _summary = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 300, 80)];
            _summary.numberOfLines = 0;
            _summary.font = [UIFont systemFontOfSize:14];
            [self addSubview:_summary];
            
        }else if ([reuseIdentifier isEqualToString:@"indentifier"])
        {
            _title = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 220, 30)];
            _title.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_title];
            
            _favorite = [[UILabel alloc] initWithFrame:CGRectMake(50, 35, 30, 30)];
            [self addSubview:_favorite];
            
            _recommend = [[UILabel alloc] initWithFrame:CGRectMake(100, 35, 30, 30)];
            [self addSubview:_recommend];
            
            _fImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35, 30, 30)];
            [_fImage setImage:[UIImage imageNamed:@"002.png"]];
            [self addSubview:_fImage];
            
            _rImage = [[UIImageView alloc] initWithFrame:CGRectMake(80, 35, 30, 30)];
            [_rImage setImage:[UIImage imageNamed:@""]];
            [self addSubview:_rImage];
            
            _markButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_markButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _markButton.frame = CGRectMake(120, 40, 100, 20);
            _markButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [self addSubview:_markButton];
            
            _bigPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 300, 130)];
            [self addSubview:_bigPic];
        }
    }
    return self;
}


- (void)setModel:(MainModel *)model
{
    
    [_iconImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", forehttp, model.picUrl]] placeholderImage:nil];
    _name.text = model.name;
//    _time.text = [NSString stringWithFormat:@"%@", model.time];
    
    _title.text = model.title;
    _favorite.text = [NSString stringWithFormat:@"%@", model.favoriteCount];
    _recommend.text = [NSString stringWithFormat:@"%@", model.recommendCount];
    switch (_flag) {
        case 0:
            _summary.text = model.summary;
            break;
        case 1:
            [_bigPic setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", forehttp, model.bigPic]] placeholderImage:nil];
            break;
        default:
            break;
    }
    [_markButton setTitle:model.mark forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
