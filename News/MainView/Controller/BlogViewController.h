//
//  BlogViewController.h
//  News
//
//  Created by lanou3g on 14-3-3.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain)NSString * urlStr;
@property (nonatomic, retain)NSString * name;

@end
