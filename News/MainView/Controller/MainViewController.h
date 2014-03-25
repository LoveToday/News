//
//  MainViewController.h
//  News
//
//  Created by lanou3g on 14-3-6.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "RootViewController.h"

@interface MainViewController : RootViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign)int flag;

@end
