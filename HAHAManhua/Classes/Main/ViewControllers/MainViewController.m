//
//  MainViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "MainViewController.h"
#import "PullingRefreshTableView.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "MainModel.h"
#import "classView.h"
#import "TableViewCell.h"
#import "BaozouMHViewController.h"
#import "CommentsViewController.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, PullingRefreshTableViewDelegate, Comments>

{
    NSInteger _pagecount;
    BOOL show_Hiden;
}


@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, assign) BOOL refreshing;

@property (nonatomic, strong) classView *cv;

@property (nonatomic, copy) NSString *kHttp;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"最热门";
    self.navigationController.navigationBar.translucent = NO;
    //导航栏右边按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 44);
    [rightBtn setImage:[UIImage imageNamed:@"btn_screening"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    //leftButton
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 60, 44);
    [leftBtn setImage:[UIImage imageNamed:@"home_btn"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"home_btn_pressed"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(leftBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    _pagecount = 3;
    self.kHttp = kGIF;
    //网络请求
//    [self requestModel];
    [self.tableView launchRefreshing];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -----UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.listArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

#pragma mark -----UITableViewDelegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainModel *model = self.listArray[indexPath.row];
    TableViewCell *cell = [[TableViewCell alloc] init];
    CGFloat height = [cell getcellHeight:model];
    return height;
}

#pragma mark -----PullingRefreshTableViewDelegate

- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pagecount = 1;
    self.refreshing = YES;
    [self requestModel];
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _pagecount = _pagecount + 1;
    self.refreshing = NO;
    [self requestModel];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}


#pragma mark -----Lazyloading

- (PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) pullingDelegate:self];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}


- (NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
}

- (classView *)cv{
    if (_cv == nil) {
        self.cv = [[classView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, 200, kScreenHeight)];
        [self.cv.hotBtn addTarget:self action:@selector(classViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.cv.refreshBtn addTarget:self action:@selector(classViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.cv.englishBtn addTarget:self action:@selector(classViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.cv.manhuaBtn addTarget:self action:@selector(classViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.cv.gifBtn addTarget:self action:@selector(classViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.cv.commentBtn addTarget:self action:@selector(classViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        show_Hiden = YES;
    }
    return _cv;
}

#pragma mark ----CustomMethod


- (void)requestModel{
    
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络提示" message:@"网络不可用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [sessionManager GET:[NSString stringWithFormat:self.kHttp, _pagecount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSDictionary *groupDic = dic[@"group"];
        NSString *status = groupDic[@"status"];
        if ([status isEqualToString:@"pending"]) {
            NSArray *array = dic[@"articles"];
            if (self.refreshing) {
                if (self.listArray.count > 0) {
                    [self.listArray removeAllObjects];
                }
            }
            for (NSDictionary *dic in array) {
                MainModel *model = [[MainModel alloc] initWithDic:dic];
                [self.listArray addObject:model];
            }
        }
        [self.tableView tableViewDidFinishedLoading];
         self.tableView.reachedTheEnd = NO;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WXQLog(@"%@", error);
    }];
    
}

- (void)leftBtnClickAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnAction:(UIButton *)btn{
    UIWindow *win = [[UIApplication sharedApplication].delegate window];
    [win addSubview:self.cv];
    if (show_Hiden) {
        [UIView animateWithDuration:0.5 animations:^{
            self.cv.frame = CGRectMake(kScreenWidth - 200, 0, 200, kScreenHeight);
            show_Hiden = NO;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.cv.frame = CGRectMake(kScreenWidth, 0, 200, kScreenHeight - 64);
            show_Hiden = YES;
        }];
    }
}


- (void)classViewBtnAction:(UIButton *)btn{
    switch (btn.tag) {
        case 1:{
            self.kHttp = kHot;
            self.navigationItem.title = @"最热门";
        }
            break;
        case 2:{
            self.kHttp = kLastrefresh;
            self.navigationItem.title = @"最新更新";
        }
            break;
        case 3:{
            self.kHttp = kEnglish;
            self.navigationItem.title = @"英式幽默";
        }
            break;
        case 4:{
            self.kHttp = kHot;
            self.navigationItem.title = @"暴走漫画";
        }
            break;
        case 5:{
            self.kHttp = kGIF;
            self.navigationItem.title = @"GIF怪兽";
        }
            break;
        case 6:{
            self.kHttp = kGod;
            self.navigationItem.title = @"神吐槽";
        }
            break;
    }
    [self.tableView launchRefreshing];
    [self rightBtnAction:btn];
}

- (void)showComments:(NSString *)user_id{
    CommentsViewController *commentsVC = [[CommentsViewController alloc] init];
    commentsVC.user_id = user_id;
    [self.navigationController pushViewController:commentsVC animated:YES];
    
}


- (void)collectionBtnAction{
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"login" bundle:nil];
    UINavigationController *loginNav = [loginSB instantiateInitialViewController];
    [self.navigationController presentViewController:loginNav animated:NO completion:nil];
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
