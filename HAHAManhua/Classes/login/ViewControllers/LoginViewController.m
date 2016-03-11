//
//  LoginViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/BmobUser.h>

@interface LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *user_name;
@property (strong, nonatomic) IBOutlet UITextField *user_password;
- (IBAction)loginBtnAction:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackBtn];
    
}

#pragma mark --------CustMethod

- (void)showBackBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 44);
    [backBtn setImage:[UIImage imageNamed:@"home_btn"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}

- (void)backBtnAction:(UIButton *)Btn{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark -----------UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

- (IBAction)loginBtnAction:(UIButton *)sender {
    [BmobUser loginWithUsernameInBackground:self.user_name.text password:self.user_password.text block:^(BmobUser *user, NSError *error) {
        if (user != nil) {
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        }else if (error != nil){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"登录失败，请确保密码或账号输入正确" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }

    }];
}
@end
