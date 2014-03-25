//
//  FindViewController.m
//  News
//
//  Created by lanou3g on 14-3-3.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "FindViewController.h"
#import "FindCell.h"
#import "Singleton.h"
#import "MarkViewController.h"

@interface FindViewController ()
{
    UITableView * _tableView;
}
@property (nonatomic, retain)NSArray * array;
@end

@implementation FindViewController

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
    
    self.navigationItem.title = @"发现";
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.array = [defaults objectForKey:@"first"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma UITableViewDataSource
#pragma UITableViewDataSource - Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    static NSString * cellIndentifier = @"cell";
    FindCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[FindCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name.text = [_array objectAtIndex:indexPath.row];
    [cell.attentionButton addTarget:self action:@selector(addAttention:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([defaults boolForKey:[_array objectAtIndex:indexPath.row]]) {
        [cell.attentionButton setBackgroundImage:[UIImage imageNamed:@"btn_share.png"] forState:UIControlStateNormal];
    }else [cell.attentionButton setBackgroundImage:[UIImage imageNamed:@"account_button.png"] forState:UIControlStateNormal];
    
    cell.attentionButton.tag = 100+indexPath.row;
    return cell;
}
- (void)addAttention:(UIButton *)button
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    button.selected = [defaults boolForKey:[_array objectAtIndex:button.tag-100]];
    button.selected = !button.selected;
    if (!button.selected) {
        [button setBackgroundImage:[UIImage imageNamed:@"account_button.png"] forState:UIControlStateNormal];
        button.selected = NO;
    }else {
        [button setBackgroundImage:[UIImage imageNamed:@"btn_share.png"] forState:UIControlStateNormal];
        button.selected = YES;
    }
    [defaults setBool:button.selected forKey:[_array objectAtIndex:button.tag-100]];
    [defaults synchronize];
}

#pragma UITableViewDelegate
#pragma UITableViewDelegate - Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarkViewController * markVC = [[MarkViewController alloc] init];
    markVC.title = [_array objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:markVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
