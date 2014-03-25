//
//  MyTabBarViewController.m
//  News
//
//  Created by lanou3g on 14-3-3.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "MainViewController.h"
#import "ActiveViewController.h"
#import "FindViewController.h"
#import "CenterViewController.h"
#import "SettingViewController.h"
#import "AppDelegate.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self loadViewController];
}

- (void)loadViewController
{
    _mainVC = [[MainViewController alloc] init];
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:_mainVC];
    _mainVC.title = @"主页";
    
    ActiveViewController * activeVC = [[ActiveViewController alloc] init];
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:activeVC];
    nav2.tabBarItem.title = @"动态";
    
    FindViewController * findVC = [[FindViewController alloc] init];
    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:findVC];
    nav3.tabBarItem.title = @"发现";
    
    CenterViewController * centerVC = [[CenterViewController alloc] init];
    UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:centerVC];
    nav4.tabBarItem.title = @"个人中心";
    
    SettingViewController * settingVC = [[SettingViewController alloc] init];
    UINavigationController * nav5 = [[UINavigationController alloc] initWithRootViewController:settingVC];
    nav5.tabBarItem.title = @"设置";
    
    self.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nav5, nil];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"isLand"] == nil) {
        self.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nav5, nil];
        NSArray * array = [NSArray arrayWithObjects:@"时事", @"娱乐", @"财经", @"科技", @"体育",  @"时尚", @"健康", @"军事", @"游戏", @"美食", @"教育", @"创业", @"设计", @"旅游", @"汽车", @"家居", nil];
        for (int i = 0; i < array.count; i++) {
            if (i < 5) {
                [defaults setBool:YES forKey:[array objectAtIndex:i]];
            }else [defaults setBool:NO forKey:[array objectAtIndex:i]];
        }
        [defaults setObject:array forKey:@"first"];
        [defaults setObject:@"hehe" forKey:@"isLand"];
        [defaults synchronize];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
