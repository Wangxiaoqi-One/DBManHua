//
//  SetViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "SetViewController.h"
#import <SDWebImage/SDImageCache.h>
#import "ProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import "CollectionViewController.h"

@interface SetViewController ()<MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self showBackBtn];
    [self configView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.imageView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    BmobUser *user = [BmobUser getCurrentUser];
    if (user != nil) {
        [self.loginBtn setTitle:user.username forState:UIControlStateNormal];
    }
}
#pragma mark ------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:{
            SDImageCache *cache = [SDImageCache sharedImageCache];
            NSInteger cacheSize = [cache getSize];
            NSString *cacheStr = [NSString stringWithFormat:@"图片缓存(%02fM)", (float)cacheSize/1024/1024];
            cell.textLabel.text = cacheStr;
            cell.imageView.image = [UIImage imageNamed:@"trash"];
        }
            break;
        case 1:{
            cell.textLabel.text = @"版本信息";
            cell.imageView.image = [UIImage imageNamed:@"mobile"];

        }
            break;
        case 2:
        {
            cell.textLabel.text = @"给我评分";
            cell.imageView.image = [UIImage imageNamed:@"document"];
}
            break;
        case 3:
        {
            cell.textLabel.text = @"意见反馈";
            cell.imageView.image = [UIImage imageNamed:@"mail"];
}
            break;
        case 4:
        {
            cell.textLabel.text = @"我的收藏";
            cell.imageView.image = [UIImage imageNamed:@"heart-1"];
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"切换账号";
            cell.imageView.image = [UIImage imageNamed:@"man"];
        }
            break;
    }
    return cell;
}
#pragma mark ------UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            //清除缓存
            SDImageCache *imageCache = [SDImageCache sharedImageCache];
            [imageCache clearDisk];
            self.imageView.hidden = NO;
            [self performSelector:@selector(hideImageView) withObject:nil afterDelay:1.0];
            [self.tableView reloadData];
        }
            break;
        case 1:{
            [ProgressHUD show:@"正在检测版本中...."];
            [self performSelector:@selector(checkedBanBen) withObject:nil afterDelay:2.0];
        }
            break;
        case 2:{
            //appStore评分
            NSString *str = [NSString stringWithFormat:
                             
                             @"itms-apps://itunes.apple.com/app"];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
            break;
        case 3:
        {
            [self sendEmail];
        }
            break;
        case 4:
        {
            BmobUser *user = [BmobUser getCurrentUser];
            if (user != nil) {
                CollectionViewController *collectionVC = [[CollectionViewController alloc] init];
                [self.navigationController pushViewController:collectionVC animated:NO];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
            }
        }
            break;
        case 5:
        {
            [BmobUser logout];
            [self.loginBtn setTitle:@"未登陆" forState:UIControlStateNormal];
            UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"login" bundle:nil];
            UINavigationController *loginNav = [loginSB instantiateInitialViewController];
            [self.navigationController presentViewController:loginNav animated:NO completion:nil];
        }
            break;
    }
}

#pragma mark ------Lazyloading

- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    return _tableView;
}

- (UIButton *)loginBtn{
    if (_loginBtn == nil) {
        self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.loginBtn.frame = CGRectMake(20, 20, kScreenWidth / 5, 60);
        self.loginBtn.backgroundColor = [UIColor orangeColor];
        [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginBtn.layer.cornerRadius = 30;
        self.loginBtn.layer.borderColor = [UIColor cyanColor].CGColor;
        self.loginBtn.layer.borderWidth = 3;
        [self.loginBtn addTarget:self action:@selector(loginbtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.loginBtn setTitle:@"未登录" forState:UIControlStateNormal];
    }
    return _loginBtn;
}


- (UIImageView *)imageView{
    if (_imageView == nil) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 4, kScreenHeight / 5, kScreenWidth / 2, kScreenHeight / 6)];
        self.imageView.image = [UIImage imageNamed:@"clear_cache_success"];
        self.imageView.hidden = YES;
    }
    return _imageView;
}

#pragma mark ------CustomMethod

- (void)configView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    headerView.backgroundColor = [UIColor brownColor];
    [headerView addSubview:self.loginBtn];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.loginBtn.right, 30, kScreenWidth / 2, 40)];
    titleLabel.text = @"欢迎使用暴漫天地";
    titleLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:titleLabel];
    self.tableView.tableHeaderView = headerView;
}

- (void)loginbtnAction{
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"login" bundle:nil];
    UINavigationController *loginNav = [loginSB instantiateInitialViewController];
    [self.navigationController presentViewController:loginNav animated:NO completion:nil];
}

- (void)backBtnAction:(UIButton *)Btn{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)hideImageView{
    self.imageView.hidden = YES;
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


- (void)checkedBanBen{
    [ProgressHUD showSuccess:@"已是最新版本"];
}


- (void)sendEmail{
    Class mailClass = NSClassFromString(@"MFMailComposeViewController");
    if (mailClass != nil) {
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            //设置主题
            [picker setSubject:@"用户信息反馈"];
            //设置收件人
            NSArray *toRecipients = [NSArray arrayWithObjects:@"1535607759@qq.com", nil];
            [picker setToRecipients:toRecipients];
            //设置发送内容
            NSString *text = @"请留下您宝贵的意见";
            [picker setMessageBody:text isHTML:NO];
            [self presentViewController:picker animated:YES completion:nil];
            
        } else {
            WXQLog(@"未配置邮箱账号");
        }
    } else {
        WXQLog(@"当前设备不能发送");
    }}

//邮件发送完成调用的方法
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result)
    {
        case MFMailComposeResultCancelled: //取消
            NSLog(@"MFMailComposeResultCancelled-取消");
            break;
        case MFMailComposeResultSaved: // 保存
            NSLog(@"MFMailComposeResultSaved-保存邮件");
            break;
        case MFMailComposeResultSent: // 发送
            NSLog(@"MFMailComposeResultSent-发送邮件");
            break;
        case MFMailComposeResultFailed: // 尝试保存或发送邮件失败
            NSLog(@"MFMailComposeResultFailed: %@...",[error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
