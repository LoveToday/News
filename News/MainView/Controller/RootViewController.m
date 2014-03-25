//
//  RootViewController.m
//  CeLaMen
//
//  Created by lanou3g on 14-3-6.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "MainViewController.h"

@interface RootViewController ()

@property (nonatomic, retain)NSMutableArray * nameArray;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.nameArray = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
}
- (void)showMenu
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [_nameArray removeAllObjects];
    NSArray * array = [defaults objectForKey:@"first"];
    for (int i = 0; i < array.count; i++) {
        if ([defaults boolForKey:[array objectAtIndex:i]] == YES) {
            NSString * name = [array objectAtIndex:i];
            RESideMenuItem *hehe = [[RESideMenuItem alloc] initWithTitle:name action:^(RESideMenu *menu, RESideMenuItem *item) {
                [menu hide];
                MyTabBarViewController * viewController = [[MyTabBarViewController alloc] init];
                viewController.mainVC.title = item.title;
                viewController.mainVC.flag = 1;
                viewController.navigationItem.title = item.title;
                
                [menu setRootViewController:viewController];
            }];
            [_nameArray addObject:hehe];
        }
        _sideMenu = [[RESideMenu alloc] initWithItems:[NSArray arrayWithArray:_nameArray]];
        _sideMenu.verticalOffset = IS_WIDESCREEN ? 110 : 76;
        _sideMenu.hideStatusBarArea = [AppDelegate OSVersion] < 7;
    }
    [_sideMenu show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
