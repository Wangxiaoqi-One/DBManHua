//
//  RegisterViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "RegisterViewController.h"
#import <BmobSDK/BmobUser.h>
#import "ProgressHUD.h"

@interface RegisterViewController ()

{
    NSString *_emailRegex;
}

@property (strong, nonatomic) IBOutlet UITextField *user_name;
@property (strong, nonatomic) IBOutlet UITextField *user_email;
@property (strong, nonatomic) IBOutlet UITextField *user_password;
@property (strong, nonatomic) IBOutlet UITextField *confirm_password;
- (IBAction)registBtnAction:(UIButton *)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    [self showBackBtn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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

- (IBAction)registBtnAction:(UIButton *)sender {
    if (![self checkout]) {
        return;
    }
    BmobUser *buser = [[BmobUser alloc] init];
    [buser setUsername:self.user_name.text];
    [buser setPassword:self.user_password.text];
    [buser setEmail:self.user_email.text];
    [buser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            BmobUser *user = [BmobUser getCurrentUser];
            //应用开启了邮箱验证功能
            if ([user objectForKey:@"emailVerified"]) {
                //用户没验证过邮箱
                if (![[user objectForKey:@"emailVerified"] boolValue]) {
                    [user verifyEmailInBackgroundWithEmailAddress:self.user_email.text];
                    [ProgressHUD showSuccess:@"注册成功"];
                }
            }
            NSLog(@"注册成功");
        }else{
            [ProgressHUD showError:@"注册失败"];
            NSLog(@"%@", error);
        }
    }];
}

- (BOOL)checkout{
    //用户名不能为空且不能为空格
    if (self.user_name.text.length > 0 && [self.user_name.text stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0 && self.user_password.text.length > 0) {
        //两次输入密码一致
        if ([self.user_password.text isEqualToString:self.confirm_password.text]) {
            return [self validateEmail:self.user_email.text];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"用户提示" message:@"两次输入的密码不一致" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            } ];
            [alertController addAction:action];
            [self.navigationController presentViewController:alertController animated:YES completion:nil];
            return NO;
        }
        
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"用户提示" message:@"用户名无效" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        } ];
        [alertController addAction:action];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
        return NO;
    }
    return YES;

}

- (BOOL)validateEmail:(NSString *)email{
    //判断是否是邮箱
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
