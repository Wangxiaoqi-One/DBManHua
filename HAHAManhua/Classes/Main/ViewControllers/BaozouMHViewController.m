//
//  BaozouMHViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "BaozouMHViewController.h"
#import "MainViewController.h"
#import "BaouYingYuanViewController.h"
#import "SetViewController.h"

@interface BaozouMHViewController ()
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginStatusBtn;

- (IBAction)dadiAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *settingBtn;
@property (strong, nonatomic) IBOutlet UIButton *baoZhuYeBtn;
@property (strong, nonatomic) IBOutlet UIButton *baoYingYuanBtn;
- (IBAction)baoxiazaiBtnAction:(id)sender;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIImageView *dadiImageView;

@property (strong, nonatomic) MainViewController *mainVC;

@end

@implementation BaozouMHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.mainVC = [mainSB instantiateViewControllerWithIdentifier:@"baozou"];
    [self.navigationController pushViewController:self.mainVC animated:YES];
    [self setbtnAction];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    BmobUser *user = [BmobUser getCurrentUser];
    if (user != nil) {
        [self.loginStatusBtn setTitle:user.username forState:UIControlStateNormal];
    }else{
        [self.loginStatusBtn setTitle:@"未登录" forState:UIControlStateNormal];
    }
}

#pragma mark ----Lazyloading

- (UIImageView *)dadiImageView{
    if (_dadiImageView == nil) {
        self.dadiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 173, kScreenWidth - 60, 128)];
        self.dadiImageView.image = [UIImage imageNamed:@"dadi_building_img"];
    }
    return _dadiImageView;
}

#pragma mark ---CustomMethod

- (void)setbtnAction{
    //暴主页
    [self.baoZhuYeBtn setImage:[UIImage imageNamed:@"baozhuye_pressed"] forState:UIControlStateHighlighted];
    [self.baoZhuYeBtn addTarget:self action:@selector(selectPageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //暴影院
    [self.baoYingYuanBtn setImage:[UIImage imageNamed:@"baoyingyuan_pressed"] forState:UIControlStateHighlighted];
    [self.baoYingYuanBtn addTarget:self action:@selector(selectPageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置
    [self.settingBtn addTarget:self action:@selector(setViewAction) forControlEvents:UIControlEventTouchUpInside];
    
    //登陆
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.loginStatusBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectPageAction:(UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self.navigationController pushViewController:self.mainVC animated:YES];
            break;
        case 1:{
            BaouYingYuanViewController *baoyinfyuanVC = [[BaouYingYuanViewController alloc] init];
            [self.navigationController pushViewController:baoyinfyuanVC animated:YES];
        }
            break;
    }
}
//设置
-(void)setViewAction{
    SetViewController *setVC = [[SetViewController alloc] init];
    UINavigationController *setnav = [[UINavigationController alloc] initWithRootViewController:setVC];
    [self.navigationController presentViewController:setnav animated:NO completion:nil];
}
//登陆
- (void)loginAction{
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

- (IBAction)dadiAction:(id)sender {
    [self.view addSubview:self.dadiImageView];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(cancelView) userInfo:nil repeats:NO];
}

- (void)cancelView{
     [UIView animateWithDuration:1.0 animations:^{
         [self.dadiImageView removeFromSuperview];
     }];
    [self.timer invalidate];
}

- (IBAction)baoxiazaiBtnAction:(id)sender {
    
    UIStoryboard *downloadSB = [UIStoryboard storyboardWithName:@"baoDownLoadStoryboard" bundle:nil];
    UINavigationController *downloadNav = [downloadSB instantiateInitialViewController];
    [self.navigationController presentViewController:downloadNav animated:NO completion:nil];
}
@end
