//
//  DownloadCollectionViewCell.m
//  HAHAManhua
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "DownloadCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface DownloadCollectionViewCell ()<NSURLConnectionDataDelegate>
@property (strong, nonatomic) IBOutlet UIProgressView *progress;

@property (strong, nonatomic) IBOutlet UIImageView *pictures;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UIButton *downloadBtn;

@property (copy, nonatomic) NSString *zip_url;
@property (copy, nonatomic) NSString *zip_name;
@property (nonatomic, strong) NSMutableData *fileData;
@property (nonatomic, strong) NSFileHandle *writeHandle;
@property (nonatomic, assign) NSInteger currentLength;
@property (nonatomic, assign) NSInteger sumlength;


@end

@implementation DownloadCollectionViewCell

- (void)setModel:(DownloadModel *)model{
    [self.pictures sd_setImageWithURL:[NSURL URLWithString:model.icon] completed:nil];
    self.timeLabel.text = model.time;
    self.zip_url = model.zip_url;
    self.zip_name = model.zip_name;
}

- (void)awakeFromNib {
    // Initialization code
    [self.downloadBtn addTarget:self action:@selector(downloadBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.progress.hidden = YES;
}

- (void)downloadBtnAction{
//    self.progress.hidden = NO;
//    [self download];
}

- (void)download{
     //创建下载路径
    NSURL *url = [NSURL URLWithString:self.zip_url];
    //创建一个请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //发送请求（使用代理方式）
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark --------NSURLConnectionDataDelegate

//当接收到服务器的响应时会调用

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
       //1.创建文件存储路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:self.zip_name];
    NSLog(@"%@", filePath);
    //2.创建一个空的文件，到沙盒中
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([mgr fileExistsAtPath:filePath]) {
        [self.writeHandle closeFile];
        self.writeHandle = nil;
        //在下载完毕后，对进度清空
        self.currentLength = 0;
        self.sumlength  = 0;
        return;
        
    }
    //刚创建完毕的大小是0字节
    [mgr createFileAtPath:filePath contents:nil attributes:nil];
    
    //3.创建写数据的文件句柄
    self.writeHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    
    //4.获取完整的文件的长度
    self.sumlength = response.expectedContentLength;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //累加接收到的数据
    self.currentLength += data.length;
    
    //计算当前进度
    double progress =(double)self.currentLength / self.sumlength;
    self.progress.progress = progress;
    //一点一点接收数据
//    WXQLog(@"%ld", data.length);
    //把data写入到创建的空文件中，但是不能使用writetoFile(会覆盖)
    //移动到文件的尾部
    [self.writeHandle seekToEndOfFile];
    //从当前移动的位置，写入数据
    [self.writeHandle writeData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"下载完毕");
    self.progress.progress = 0;
    self.progress.hidden = YES;
    //关闭连接，不在输入数据在文件中
    [self.writeHandle closeFile];
    
    //销毁
    self.writeHandle = nil;
    //在下载完毕后，对进度清空
    self.currentLength = 0;
    self.sumlength  = 0;
}



@end
