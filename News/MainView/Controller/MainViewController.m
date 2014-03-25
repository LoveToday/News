//
//  MainViewController.m
//  News
//
//  Created by lanou3g on 14-3-6.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "MainViewController.h"
#import "BlogViewController.h"
#import "SpecificialViewController.h"
#import "Url.h"
#import "AFHTTPRequestOperationManager.h"
#import "MainCell.h"
#import "MainModel.h"
#import "MJRefresh.h"
#import "TheMarkViewController.h"
@interface MainViewController ()
{
    UITableView * _tableView;
    
    MJRefreshHeaderView * _header;
    MJRefreshFooterView * _footer;
    
}
@property (nonatomic, retain)NSString * cursor;

@property (nonatomic, retain)NSMutableArray * dataArray;

@property (nonatomic, retain)NSDictionary * dic;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dic = [NSDictionary dictionaryWithObjectsAndKeys:@"时事", @"1", @"娱乐", @"2", @"财经", @"3", @"科技", @"4", @"体育", @"5",@"汽车", @"6",@"旅游", @"7", @"设计", @"8",@"游戏", @"9",@"美食", @"10",@"教育", @"11", @"创业", @"12", @"军事", @"13",@"健康", @"14", @"时尚",@"15", @"家居", @"16", nil];
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self addHeader];
    [self addFooter];
    
}

- (void)postRequest:(NSString *)urlStr view:(MJRefreshBaseView *)refreshView flag:(int)flag
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (flag == 0) {
            [_dataArray removeAllObjects];
        }
        NSDictionary * dic = (NSDictionary *)responseObject;
        self.cursor = [dic objectForKey:@"next_cursor"];
        NSArray * array = [dic objectForKey:@"discovers"];
        for (NSDictionary * dictionary in array) {
            MainModel * model = [[MainModel alloc] initWithDictionary:dictionary];
            [_dataArray addObject:model];
        }
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0.0];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)addFooter
{
    MJRefreshFooterView * footer = [MJRefreshFooterView footer];
    footer.scrollView = _tableView;
    __block MainViewController * mainVC = self;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView * refreshView){
        if (_flag == 0) {
            [self postRequest:[NSString stringWithFormat:@"%@%@%@", forehttp, main, _cursor] view:refreshView flag:1];
        }else
        {
            [self postRequest:[NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/discover/listByTagId?cursor=%@&tag_id=%@", _cursor, [[_dic allKeysForObject:mainVC.title] firstObject]] view:refreshView flag:1];
        }
    };
    _footer = footer;
}
- (void)addHeader
{
    MJRefreshHeaderView * header = [MJRefreshHeaderView header];
    header.scrollView = _tableView;
    __block MainViewController * mainVC = self;
    header.beginRefreshingBlock = ^(MJRefreshBaseView * refreshView){
        if (_flag == 0) {
            [self postRequest:[NSString stringWithFormat:@"%@%@%@", forehttp, main, @"0"] view:refreshView flag:0];
        }else{
            [self postRequest:[NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/discover/listByTagId?cursor=%@&tag_id=%@", @"0", [[_dic allKeysForObject:mainVC.title] firstObject]] view:refreshView flag:0];
            
        }
        
    };
    [header beginRefreshing];
    _header = header;
}
- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [_tableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

#pragma UITableViewDataSource
#pragma UITableViewDataSource - Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainModel * model = [_dataArray objectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        static NSString * cellIndentifier = @"cell";
        MainCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.markButton.tag = 100+indexPath.section;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }else if (indexPath.row == 1){
        if (model.bigPic == nil) {
            static NSString * cellIndentifier1 = @"cellIndentifier";
            MainCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
            if (!cell) {
                cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier1];
            }
            cell.markButton.tag = 100+indexPath.section;
            cell.flag = 0;
            [cell.markButton addTarget:self action:@selector(enterMarkVC:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }else if (model.bigPic != nil){
            static NSString * cellIndentifier2 = @"indentifier";
            MainCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier2];
            if (!cell) {
                cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier2];
            }
            cell.markButton.tag = 100+indexPath.section;
            cell.flag = 1;
            [cell.markButton addTarget:self action:@selector(enterMarkVC:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }
    }
    return nil;
}
- (void)enterMarkVC:(UIButton *)button
{
    MainModel * model = [_dataArray objectAtIndex:button.tag-100];
    NSString * mark = button.titleLabel.text;
    TheMarkViewController * theMarkVC = [[TheMarkViewController alloc] init];
    theMarkVC.title = mark;
    theMarkVC.tagId = model.tagId;
    [self.navigationController pushViewController:theMarkVC animated:YES];
}

#pragma UITableViewDelegate
#pragma UITableViewDelegate - Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainModel * model = [_dataArray objectAtIndex:indexPath.section];
    switch (indexPath.row) {
        case 0:
        {
            BlogViewController * blogVC = [[BlogViewController alloc] init];
            blogVC.urlStr = [NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/user/showUserById?token=&id=%@", model.userId];
            blogVC.name = model.name;
            blogVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:blogVC animated:YES];
        }
            break;
        case 1:
        {
            SpecificialViewController * specificialVC = [[SpecificialViewController alloc] init];
            specificialVC.urlStr = [NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/discover/show?token=&id=%@", model.specialId];
            specificialVC.name = model.name;
            specificialVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:specificialVC animated:YES];
        }
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainModel * model = [_dataArray objectAtIndex:indexPath.section];
    switch (indexPath.row) {
        case 0:
            return 60;
            break;
        case 1:
            if (model.bigPic != nil) {
                return 200;
            }else return 150;
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
