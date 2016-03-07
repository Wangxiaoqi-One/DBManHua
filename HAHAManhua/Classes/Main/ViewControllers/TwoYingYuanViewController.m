//
//  TwoYingYuanViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "TwoYingYuanViewController.h"
#import "TwoTableViewCell.h"
#import <AFNetworking.h>
#import "TwoMoviesModel.h"
#import "PullingRefreshTableView.h"
#import "DetailViewController.h"

@interface TwoYingYuanViewController ()<UITableViewDataSource, UITableViewDelegate, PullingRefreshTableViewDelegate>
{
    NSInteger _pageCount;
    NSInteger _totalPage;
}


@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) BOOL refreshing;

@end

@implementation TwoYingYuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackBtn];
    [self showTitleImageView];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"TwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _pageCount = 1;
    [self requestModel1];
}

#pragma mark ------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TwoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.twoModel = self.listArray[indexPath.row];
    return cell;
}

#pragma mark ------UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    TwoMoviesModel *model = self.listArray[indexPath.row];
    detailVC.twoModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -------PullingRefreshTableViewDelegate

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    if (_pageCount == _totalPage) {
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd = YES;
    }else{
        _pageCount += 1;
        self.refreshing = NO;
        [self performSelector:@selector(requestModel1) withObject:nil afterDelay:1.0];
    }
}

- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pageCount = 1;
    self.refreshing = YES;
    [self performSelector:@selector(requestModel1) withObject:nil afterDelay:1.0];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark -------Lazyloading

-(UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) pullingDelegate:self];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.rowHeight = 100;
    }
    return _tableView;
}

- (NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
}

#pragma mark -------CustomMethod

- (void)requestModel1{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [sessionManager GET:[NSString stringWithFormat:kYingYuanTwo, self.moviesId, _pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *successDic = responseObject;
        NSArray *array = successDic[@"articles"];
        _totalPage = [successDic[@"total_pages"] integerValue];
        if (self.refreshing) {
            if (self.listArray.count > 0) {
                [self.listArray removeAllObjects];
            }
            for (NSDictionary *dic in array) {
                TwoMoviesModel *model = [[TwoMoviesModel alloc] initWithDictionary:dic];
                [self.listArray addObject:model];
            }

        }
        else{
            if (self.listArray.count == _totalPage) {
                
            }else{
                for (NSDictionary *dic in array) {
                    TwoMoviesModel *model = [[TwoMoviesModel alloc] initWithDictionary:dic];
                    [self.listArray addObject:model];
                }
            }
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
