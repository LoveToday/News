//
//  SpecificialViewController.m
//  News
//
//  Created by lanou3g on 14-3-3.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "SpecificialViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "SpecificialCell.h"
#import "SpecificialModel.h"
#import "CaculateHeight.h"

@interface SpecificialViewController ()
{
    UITableView * _tableView;
}
@property (nonatomic, retain)NSMutableArray * dataArray;
@end

@implementation SpecificialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = _name;

    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self loadData];
}
- (void)loadData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:_urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        SpecificialModel * model = [[SpecificialModel alloc] initWithDictionary:dic];
        [_dataArray addObject:model];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma UITableViewDataSource
#pragma UITableViewDataSource - Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecificialModel * model = [_dataArray firstObject];
    switch (indexPath.row) {
        case 0:{
            static NSString * cellIndentifier = @"cell";
            SpecificialCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (!cell) {
                cell = [[SpecificialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }
            break;
        case 1:{
            static NSString * cellIndentifier = @"cellIndentifier";
            SpecificialCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (!cell) {
                cell = [[SpecificialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }
            break;
        case 2:{
            if (model.bigPic == nil) {
                static NSString * cellIndentifier = @"content";
                SpecificialCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
                if (!cell) {
                    cell = [[SpecificialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CaculateHeight * height = [[CaculateHeight alloc] init];
                cell.height = [height hightLableUIFont:[UIFont systemFontOfSize:15.0] sendString:model.content];
                cell.flag = 0;
                cell.model = model;
                return cell;
            }else if (model.bigPic != nil){
                static NSString * cellIndentifier = @"picture";
                SpecificialCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
                if (!cell) {
                    cell = [[SpecificialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                CaculateHeight * height = [[CaculateHeight alloc] init];
                cell.height = [height hightLableUIFont:[UIFont systemFontOfSize:15.0] sendString:model.content];
                cell.flag = 1;
                cell.model = model;
                return cell;
            }
        }
            break;
        default:
            break;
    }
    return nil;
}
#pragma UITableViewDelegate
#pragma UITableViewDelegate - Method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecificialModel * model = [_dataArray firstObject];
    switch (indexPath.row) {
        case 0:
            return 70;
            break;
        case 1:
            return 30;
            break;
        case 2:{
            CaculateHeight * height = [[CaculateHeight alloc] init];
            CGFloat cellHeight = [height hightLableUIFont:[UIFont systemFontOfSize:15.0] sendString:model.content];
            if (model.bigPic != nil) {
                return 150+cellHeight;
            }else if (model.bigPic == nil){
                return 70+cellHeight;
            }
        }
            break;
        default:
            break;
    }
    return 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
