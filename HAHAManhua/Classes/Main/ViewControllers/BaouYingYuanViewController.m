//
//  BaouYingYuanViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "BaouYingYuanViewController.h"
#import "PullingRefreshTableView.h"
#import "YIngYuanTableViewCell.h"
#import <AFNetworking.h>
#import "YingYuanModel.h"
#import "TwoYingYuanViewController.h"

@interface BaouYingYuanViewController ()<UITableViewDataSource, UITableViewDelegate, PullingRefreshTableViewDelegate>

{
    NSInteger _pageCount;
}

@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, assign) BOOL refreshing;

@end

@implementation BaouYingYuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showTitleImageView];
    [self showBackBtn];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"YIngYuanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _pageCount = 1;
    [self requestModel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark ------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YIngYuanTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.listArray[indexPath.row];
    return cell;
}
#pragma mark ------UITableViewdelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TwoYingYuanViewController *twoVC = [[TwoYingYuanViewController alloc] init];
    YingYuanModel *model = self.listArray[indexPath.row];
    twoVC.moviesId = model.moviesId;
    [self.navigationController pushViewController:twoVC animated:YES];
}

#pragma mark ------PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    self.refreshing = NO;
    _pageCount = 2;
    [self performSelector:@selector(requestModel) withObject:nil afterDelay:1.0];
}

- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    _pageCount = 1;
    [self performSelector:@selector(requestModel) withObject:nil afterDelay:1.0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark ------Lazyloading

- (PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) pullingDelegate:self];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.rowHeight = 171;
    }
    return _tableView;
}

- (NSMutableArray *)listArray {
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
}

#pragma mark -------CustomMethod

- (void)requestModel{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [sessionManager GET:[NSString stringWithFormat:kBaoYingYuan, _pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *successDic = responseObject;
        NSArray *array = successDic[@"cinema"];
        if (self.refreshing) {
            if (self.listArray.count > 0) {
                [self.listArray removeAllObjects];
            }
        }
        for (NSDictionary *dic in array) {
            YingYuanModel *model = [[YingYuanModel alloc] initWithDictionary:dic];
            [self.listArray addObject:model];
        }
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd = NO;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WXQLog(@"%@", error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
