//
//  BlogViewController.m
//  News
//
//  Created by lanou3g on 14-3-3.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "BlogViewController.h"
#import "HeadView.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "Url.h"
#import "MainModel.h"
#import "MainCell.h"
#import "MJRefresh.h"
#import "SpecificialViewController.h"
#import "FansCell.h"
#import "FansModel.h"
#import "AttentionModel.h"
#import "AttentionCell.h"

@interface BlogViewController ()
{
    UITableView * _tableView;
    HeadView * _headView;
    MJRefreshFooterView * _footer;
}
@property (nonatomic, retain)NSMutableArray * dataArray;
@property (nonatomic, retain)NSString * token;
@property (nonatomic, retain)NSString * userId;
@property (nonatomic, retain)NSString * nextCursor;
@property (nonatomic, retain)NSMutableArray * listArray;
@property (nonatomic, retain)NSMutableArray * attentionArr;

@end

@implementation BlogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
        self.listArray = [NSMutableArray arrayWithCapacity:1];
        self.attentionArr = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = _name;
    
    _headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 5, 320, 150)];
    [_headView.segment addTarget:self action:@selector(displayContent:) forControlEvents:UIControlEventValueChanged];
    _headView.segment.selectedSegmentIndex = 0;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.tableHeaderView = _headView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

    [self loadData];
    [self addFooter];
}
- (void)displayContent:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:{
            [_dataArray removeAllObjects];
            [self loadBlogSpecificialMessage:[NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/discover/otherAction?cursor=0&userId=%@&token=%@", _userId, _token] footView:nil];
            [_tableView reloadData];
        }
            break;
        case 1:{
            [self loadListData:[NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/user/fans?token=%@&userId=%@&cursor=0",  _token, _userId]];
            [_tableView reloadData];
        }
            break;
        case 2:
            [self loadAttentionData:[NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/user/attentions?token=%@&userId=%@&cursor=0", _token, _userId]];
            break;
        default:
            break;
    }
}
- (void)loadData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:_urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        self.token = [dic objectForKey:@"token"];
        [_headView.iconImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", forehttp, [dic objectForKey:@"avatar"]]]];
        _headView.name.text = [dic objectForKey:@"nick"];
        _headView.textView.text = [dic objectForKey:@"description"];
        self.userId = [dic objectForKey:@"id"];
        
        [self loadBlogSpecificialMessage:[NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/discover/otherAction?cursor=0&userId=%@&token=%@", _userId, _token] footView:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)loadBlogSpecificialMessage:(NSString *)urlStr footView:(MJRefreshBaseView *)refreshView
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
        
    }];
}
- (void)loadListData:(NSString *)urlStr
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_listArray removeAllObjects];
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSArray * array = [dic objectForKey:@"users"];
        for (NSDictionary * dictionary in array) {
            FansModel * model = [[FansModel alloc] initWithDictionary:dictionary];
            [_listArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)loadAttentionData:(NSString *)urlStr
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_attentionArr removeAllObjects];
        NSDictionary * dic = (NSDictionary *)responseObject;
        NSArray * array = [dic objectForKey:@"users"];
        for (NSDictionary * dictionary in array) {
            AttentionModel * model = [[AttentionModel alloc] initWithDictionary:dictionary];
            [_attentionArr addObject:model];
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
        [self loadBlogSpecificialMessage:[NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/discover/otherAction?cursor=%@&userId=%@&token=%@", _nextCursor, _userId, _token] footView:refreshView];
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
    if (_headView.segment.selectedSegmentIndex == 0) {
        return 2;
    }else if(_headView.segment.selectedSegmentIndex == 1) return _listArray.count;
    else return _attentionArr.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_headView.segment.selectedSegmentIndex == 0) {
        return _dataArray.count;
    }else return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_headView.segment.selectedSegmentIndex == 0) {
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

    }else if(_headView.segment.selectedSegmentIndex == 1){
        FansModel * model = [_listArray objectAtIndex:indexPath.row];
        static NSString * cellIndentifier = @"normal";
        FansCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell = [[FansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }else if (_headView.segment.selectedSegmentIndex == 2){
        AttentionModel * model = [_listArray objectAtIndex:indexPath.row];
        static NSString * cellIndentifier = @"attention";
        AttentionCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell = [[AttentionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }
    return nil;

}

#pragma UITableViewDelegate
#pragma UITableViewDelegate - Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainModel * model = [_dataArray objectAtIndex:indexPath.section];
    switch (indexPath.row) {
        case 1:
        {
            SpecificialViewController * specificialVC = [[SpecificialViewController alloc] init];
            specificialVC.urlStr = [NSString stringWithFormat:@"http://api.qianqu.cc:8081/qianqu/api/iphone/1/discover/show?token=&id=%@", model.specialId];
            specificialVC.name = _name;
            [self.navigationController pushViewController:specificialVC animated:YES];
        }
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_headView.segment.selectedSegmentIndex == 0) {
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
    }else if (_headView.segment.selectedSegmentIndex == 2){
        return 60;
    }
    else return 40;
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
