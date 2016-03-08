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

@interface SetViewController ()<MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *clearCacheBtn;

@property (strong, nonatomic) IBOutlet UILabel *piturescache;

- (IBAction)updateBtn:(UIButton *)sender;
- (IBAction)backAction:(UIButton *)sender;


@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    [self showBackBtn];
    [self.clearCacheBtn addTarget:self action:@selector(clearPicturesCache) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(loginbtnAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SDImageCache *cache = [SDImageCache sharedImageCache];
    NSInteger cacheSize = [cache getSize];
    NSString *cacheStr = [NSString stringWithFormat:@"图片缓存(%02fM)", (float)cacheSize/1024/1024];
    self.piturescache.text = cacheStr;
}

#pragma mark ------CustomMethod

- (void)clearPicturesCache{
    //清除缓存
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearDisk];
   self.piturescache.text = @"图片缓存 0.0M";
}

- (void)loginbtnAction{
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"login" bundle:nil];
    UINavigationController *loginNav = [loginSB instantiateInitialViewController];
    [self.navigationController presentViewController:loginNav animated:NO completion:nil];
}

- (void)backBtnAction:(UIButton *)Btn{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
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

- (IBAction)updateBtn:(UIButton *)sender {
    [ProgressHUD show:@"正在检测版本中...."];
    [self performSelector:@selector(checkedBanBen) withObject:nil afterDelay:5.0];
}

- (void)checkedBanBen{
    [ProgressHUD showSuccess:@"已是最新版本"];
}

- (IBAction)backAction:(UIButton *)sender {
    [self sendEmail];
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
