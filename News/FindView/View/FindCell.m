//
//  FindCell.m
//  News
//
//  Created by lanou3g on 14-3-6.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "FindCell.h"

@implementation FindCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, 100, self.frame.size.height - 10)];
        [self addSubview:_name];
        
        self.attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentionButton.frame = CGRectMake(220, 5, 80, self.frame.size.height - 10);
        [self addSubview:_attentionButton];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
