//
//  DetailViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "DetailViewController.h"
#import "PullingRefreshTableView.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "DetailTableViewCell.h"
#import "DetailModel.h"
#import "VideoViewController.h"

@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate, PullingRefreshTableViewDelegate>

@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *moviesImageView;
@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIButton *posBtn;
@property (nonatomic, strong) UIButton *commentsBtn;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, copy) NSString *moiveID;

@property (nonatomic, copy) NSString *mp4link;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackBtn];
    [self showTitleImageView];
    [self configHeaderView];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)setTwoModel:(TwoMoviesModel *)twoModel{
    [self.moviesImageView sd_setImageWithURL:[NSURL URLWithString:twoModel.mp4_image_link] completed:nil];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = twoModel.title;
    [self.typeImageView sd_setImageWithURL:[NSURL URLWithString:twoModel.small_pictures] completed:nil];
    self.typeLabel.text = twoModel.user_login;
    [self.posBtn setTitle:[NSString stringWithFormat:@"%@", twoModel.score] forState:UIControlStateNormal];
    [self.commentsBtn setTitle:[NSString stringWithFormat:@"%@", twoModel.public_comments_count] forState:UIControlStateNormal];
    self.moiveID = twoModel.videoID;
    self.mp4link = twoModel.mp4_file_link;
     [self requestModel2];
}

#pragma mark ------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.listArray[indexPath.row];
    return cell;
}

#pragma mark ------UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    DetailModel *model = self.listArray[indexPath.row];
//    CGFloat height = [DetailTableViewCell getCellHeightWithModel:model];
//    return height;
//}

#pragma mark -------PullingRefreshTableViewDelegate

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self.tableView tableViewDidFinishedLoading];
}

- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    [self.tableView tableViewDidFinishedLoading];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}
#pragma mark -------CustomMethod

- (void)configHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIButton *bofangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bofangBtn.frame = CGRectMake(264, 92, 103, 37);
    [bofangBtn setTitle:@"立即播放" forState:UIControlStateNormal];
    bofangBtn.backgroundColor = [UIColor redColor];
    [bofangBtn addTarget:self action:@selector(bofangAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:bofangBtn];
    [headerView addSubview:self.moviesImageView];
    [headerView addSubview:self.contentLabel];
    [headerView addSubview:self.typeImageView];
    [headerView addSubview:self.typeLabel];
    [headerView addSubview:self.posBtn];
    [headerView addSubview:self.commentsBtn];
    self.tableView.tableHeaderView = headerView;
}

- (void)requestModel2{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [sessionManager GET:[NSString stringWithFormat:kComments, self.moiveID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *successDic = responseObject;
        NSArray *comments = successDic[@"comments"];
        for (NSDictionary *dic in comments) {
            DetailModel *model = [[DetailModel alloc] initWithDictionary:dic];
            [self.listArray addObject:model];
        }
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd = NO;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WXQLog(@"%@", error);
    }];
}

- (void)bofangAction{
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    videoVC.mp4Link = self.mp4link;
    [self.navigationController pushViewController:videoVC animated:YES];
}

#pragma mark -------Lazyloading

-(UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) pullingDelegate:self];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.rowHeight = 95;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:237 / 255.0 alpha:1.0];
    }
    return _tableView;
}
//首图
- (UIImageView *)moviesImageView{
    if (_moviesImageView == nil) {
        self.moviesImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 128, 67)];
    }
    return _moviesImageView;
}
//内容
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(144, 8, 233, 67)];
    }
    return _contentLabel;
}
//类型
- (UIImageView *)typeImageView{
    if (_typeImageView == nil) {
        self.typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 92, 21, 21)];
    }
    return _typeImageView;
}
//类型
- (UILabel *)typeLabel{
    if (_typeLabel == nil) {
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(29, 92, 107, 21)];
    }
    return _typeLabel;
}
//赞数
- (UIButton *)posBtn{
    if (_posBtn == nil) {
        self.posBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.posBtn.frame = CGRectMake(8, 115, 57, 14);
        [self.posBtn setImage:[UIImage imageNamed:@"serie_button_ding"] forState:UIControlStateNormal];
        [self.posBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _posBtn;
}
//评论数
- (UIButton *)commentsBtn{
    if (_commentsBtn == nil) {
        self.commentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentsBtn.frame = CGRectMake(78, 115, 57, 14);
        [self.commentsBtn setImage:[UIImage imageNamed:@"serie_button_comm"] forState:UIControlStateNormal];
        [self.commentsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
    }
    return _commentsBtn;
}

- (NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
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
