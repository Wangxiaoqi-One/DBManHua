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

@interface BaouYingYuanViewController ()<UITableViewDataSource, UITableViewDelegate, PullingRefreshTableViewDelegate>

@property (nonatomic, strong) UIImageView *titleImageView;

@property (nonatomic, strong) PullingRefreshTableView *tableView;

@end

@implementation BaouYingYuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.titleImageView;
    [self showBackBtn];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"YIngYuanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self requestModel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark ------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YIngYuanTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
#pragma mark ------UITableViewdelegate

#pragma mark ------PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{

}

- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark ------Lazyloading

- (UIImageView *)titleImageView{
    if (_titleImageView == nil) {
        self.titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        self.titleImageView.image = [UIImage imageNamed:@"movies_title"];
    }
    return _titleImageView;
}

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


#pragma mark -------CustomMethod

- (void)requestModel{
//    AFHTTPSessionManager
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [sessionManager GET:kBaoYingYuan parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WXQLog(@"%@", responseObject);
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
