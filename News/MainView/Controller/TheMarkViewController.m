//
//  TheMarkViewController.m
//  News
//
//  Created by lanou3g on 14-3-7.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "TheMarkViewController.h"
#import "MainModel.h"
#import "MainCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "MJRefresh.h"
#import "FansModel.h"
#import "FansCell.h"

@interface TheMarkViewController ()
{
    UITableView * _tableView;
    UISegmentedControl * _segment;
    MJRefreshFooterView * _footer;
}
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain)NSString * nextCursor;
@property (nonatomic, retain)NSMutableArray * listArray;
@property (nonatomic, retain)NSString * listCursor;
@end

@implementation TheMarkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
        self.listArray = [NSMutableArray arrayWithCapacity:1];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"相关微博", @"相关粉丝", nil]];
    _segment.frame = CGRectMake(0, 0, 320, 60);
    [_segment addTarget:self action:@selector(displayContent:) forControlEvents:UIControlEventValueChanged];
    _segment.selectedSegmentIndex = 0;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = _segment;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addFooter];
    [self loadData:[NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/discover/listByTagId?cursor=%@&tag_id=%@", @"0", _tagId] footView:nil];
}
- (void)displayContent:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:{
            [_dataArray removeAllObjects];
            [self loadData:[NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/discover/listByTagId?cursor=%@&tag_id=%@", _nextCursor, _tagId] footView:nil];
            [_tableView reloadData];
        }
            break;
        case 1:{
            [self loadList:[NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/tag/fans?cursor=%@&tagId=%@&token=",  @"0", _tagId] footView:nil];
            [_tableView reloadData];
        }
            break;
        default:
            break;
    }
}

- (void)loadData:(NSString *)urlStr footView:(MJRefreshBaseView *)refreshView
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        self.nextCursor = [dic objectForKey:@"next_cursor"];
        NSArray * array = [dic objectForKey:@"discovers"];
        for (NSDictionary * dictionary in array) {
            MainModel * model = [[MainModel alloc] initWithDictionary:dictionary];
            [_dataArray addObject:model];
        }
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0.0];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络中断" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
- (void)loadList:(NSString *)urlStr footView:(MJRefreshBaseView *)refreshView
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_listArray removeAllObjects];
        NSDictionary * dic = (NSDictionary *)responseObject;
        self.listCursor = [dic objectForKey:@"next_cursor"];
        NSArray * array = [dic objectForKey:@"users"];
        for (NSDictionary * dictionary in array) {
            FansModel * model = [[FansModel alloc] initWithDictionary:dictionary];
            [_listArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
- (void)addFooter
{
    MJRefreshFooterView * footer = [MJRefreshFooterView footer];
    footer.scrollView = _tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView * refreshView){
        [self loadData:[NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/discover/listByTagId?cursor=%@&tag_id=%@", _nextCursor, _tagId] footView:refreshView];
    };
    _footer = footer;
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
    if (_segment.selectedSegmentIndex == 0) {
        return 2;
    }else
        return _listArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_segment.selectedSegmentIndex == 0) {
        return _dataArray.count;
    }else return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segment.selectedSegmentIndex == 0) {
        MainModel * model = [_dataArray objectAtIndex:indexPath.section];
        if (indexPath.row == 0) {
            static NSString * cellIndentifier = @"cell";
            MainCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (!cell) {
                cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
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
                cell.flag = 0;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = model;
                return cell;
            }else if (model.bigPic != nil){
                static NSString * cellIndentifier2 = @"indentifier";
                MainCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier2];
                if (!cell) {
                    cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier2];
                }
                cell.flag = 1;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = model;
                return cell;
            }
        }
    }
    
    FansModel * model = [_listArray objectAtIndex:indexPath.row];
    static NSString * cellIndentifier = @"normal";
    FansCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[FansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}
#pragma UITableViewDelegate
#pragma UITableViewDelegate - Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MainModel * model = [_dataArray objectAtIndex:indexPath.section];
//    switch (indexPath.row) {
//        case 1:
//        {
//            SpecificialViewController * specificialVC = [[SpecificialViewController alloc] init];
//            specificialVC.urlStr = [NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/discover/show?token=&id=%@", model.specialId];
//            specificialVC.name = _name;
//            [self.navigationController pushViewController:specificialVC animated:YES];
//        }
//            break;
//        default:
//            break;
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segment.selectedSegmentIndex == 0) {
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
    }else if (_segment.selectedSegmentIndex == 2){
        return 60;
    }
    else return 40;
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
