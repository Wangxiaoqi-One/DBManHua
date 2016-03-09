//
//  VideoViewController.m
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "VideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VideoViewController ()

@property(nonatomic, retain) MPMoviePlayerController *moviePlayer;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    [self showBackBtn];
    [self showTitleImageView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.moviePlayer play];
}

-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        //        NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"乐享极智" ofType:@".mp4"];
        //        NSURL *url=[NSURL fileURLWithPath:urlStr];
        NSString *urlStr= self.mp4Link;
        urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:
                NSUTF8StringEncoding];
        NSURL *url=[NSURL URLWithString:urlStr];
        //初始化播放器并设置播放模式
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
        //.view 播放器视图，如果要显示视频，必须将此播放器添加到控制器视图中
        _moviePlayer.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:self.moviePlayer.view];
    }
    return _moviePlayer;
    
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
