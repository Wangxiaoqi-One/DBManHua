//
//  CollectionViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "CollectionViewController.h"
#import "TableViewCell.h"
#import "SqliteManager.h"

@interface CollectionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.title = @"我的收藏";
    [self showBackBtn];
    [self showRightBtn];
    [self getCollection];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark --------CustomMethod

- (void)getCollection{
    SqliteManager *daManager = [SqliteManager shareInstance];
    self.listArray = [NSMutableArray arrayWithArray:[daManager selectAllcollection]];
    WXQLog(@"%lu", self.listArray.count);
    [self.tableView reloadData];
}

- (void)showRightBtn{
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 60, 44);
    [self.rightBtn setImage:[UIImage imageNamed:@"bookshop_edit_btn_normal"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
}

#pragma mark --------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.dic = self.listArray[indexPath.row];
    return cell;
}

#pragma mark --------UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [[TableViewCell alloc] init];
    NSDictionary *dic = self.listArray[indexPath.row];
    return [cell getcellHeights:dic];
}


#pragma mark --------UITableView可编辑
//第一步：让当前的tableView处于可编辑状态

- (void)finish{
    [self.tableView setEditing:NO animated:YES];
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [self.tableView setEditing:YES animated:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//设置编辑状态
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    SqliteManager *sqlManager = [SqliteManager shareInstance];
    NSDictionary *dic = self.listArray[indexPath.row];
    [self.listArray removeObjectAtIndex:indexPath.row];
    [sqlManager deleteWithpicture:dic[@"user_login"]];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark --------Lazyloading

- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    return _tableView;
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
