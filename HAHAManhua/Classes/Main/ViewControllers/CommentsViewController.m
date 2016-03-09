//
//  CommentsViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "CommentsViewController.h"
#import "TableViewCell.h"
#import "DetailTableViewCell.h"
#import <AFNetworking.h>
#import "MainModel.h"

static NSString *tCell = @"tcell";
static NSString *dCell = @"dcell";

@interface CommentsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;



@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"评论";
    [self showBackBtn];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:tCell];
    [self.tableView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:dCell];
    
    [self requestModel4];
    
}

#pragma mark ----------CustomMethod


- (void)requestModel4{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [sessionManager GET:[NSString stringWithFormat:kmmm, self.user_id] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *successDic = responseObject;
        NSArray *comments = successDic[@"comments"];
        for (NSDictionary *dic in comments) {
            DetailModel *model = [[DetailModel alloc] initWithDictionary:dic];
            [self.listArray addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WXQLog(@"%@", error);
    }];

}


#pragma mark ----------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0 && indexPath.row == 1) {
//        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tCell forIndexPath:indexPath];
//        return cell;
//    }
        DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dCell forIndexPath:indexPath];
    cell.model = self.listArray[indexPath.row];
        return cell;
}


#pragma mark ----------UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 1 && indexPath.row == 1) {
//        TableViewCell *cell = [[TableViewCell alloc] init];
//        CGFloat height = [cell getcellHeight:self.model];
//        return height;
//    }
//    return 100;
//}

#pragma mark ----------Lazyloading

- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
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
