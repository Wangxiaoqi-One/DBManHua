//
//  DownloadCollectionViewCell.m
//  HAHAManhua
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "DownloadCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface DownloadCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *pictures;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UIButton *downloadBtn;

@property (copy, nonatomic) NSString *zip_url;

@end

@implementation DownloadCollectionViewCell

- (void)setModel:(DownloadModel *)model{
    [self.pictures sd_setImageWithURL:[NSURL URLWithString:model.icon] completed:nil];
    self.timeLabel.text = model.time;
}

- (void)awakeFromNib {
    // Initialization code
    [self.downloadBtn addTarget:self action:@selector(downloadBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)downloadBtnAction{

}


@end
