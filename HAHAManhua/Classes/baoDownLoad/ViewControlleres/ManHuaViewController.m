//
//  ManHuaViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "ManHuaViewController.h"
//#import "ZipArchive.h"

@interface ManHuaViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *pictures;

@end

@implementation ManHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackBtn];
    //解压zip文件
    [self jieyazip];
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -----------lazyLoading

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 2);
        [self.scrollView addSubview:self.pictures];
    }
    return _scrollView;
}

- (UIImageView *)pictures{
    if (_pictures == nil) {
        self.pictures = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _pictures;
}

- (void)jieyazip{
//    ZipArchive* zip = [[ZipArchive alloc] init];
//    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString* unzipto = [paths stringByAppendingString:@"/manhua"];
//    if( [zip UnzipOpenFile:self.filePath] )
//    {
//        BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
//        WXQLog(@"%@", unzipto);
//        if( NO==ret )
//        {
//            WXQLog(@"解压失败");
//        }
//        [zip UnzipCloseFile];
//    }
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
