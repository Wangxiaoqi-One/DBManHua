//
//  YIngYuanTableViewCell.m
//  HAHAManhua
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "YIngYuanTableViewCell.h"

@interface YIngYuanTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *pictures;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet UIButton *posBtn;

@property (strong, nonatomic) IBOutlet UIButton *commentsBtn;
@property (strong, nonatomic) IBOutlet UILabel *zhangjieLabel;

@end

@implementation YIngYuanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
