//
//  YIngYuanTableViewCell.m
//  HAHAManhua
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "YIngYuanTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface YIngYuanTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *pictures;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet UIButton *posBtn;

@property (strong, nonatomic) IBOutlet UIButton *commentsBtn;
@property (strong, nonatomic) IBOutlet UILabel *zhangjieLabel;

@end

@implementation YIngYuanTableViewCell


- (void)setModel:(YingYuanModel *)model{
    [self.pictures sd_setImageWithURL:[NSURL URLWithString:model.pictures] completed:nil];
    self.titleLabel.text = model.name;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = model.descriptions;
    [self.posBtn setTitle:[NSString stringWithFormat:@"%@", model.public_articles_pos] forState:UIControlStateNormal];
    [self.commentsBtn setTitle:[NSString stringWithFormat:@"%@", model.public_comments_count] forState:UIControlStateNormal];
    NSString *str = model.total_articles_count;
    self.zhangjieLabel.text = [NSString stringWithFormat:@"更新到%@话", str];
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
