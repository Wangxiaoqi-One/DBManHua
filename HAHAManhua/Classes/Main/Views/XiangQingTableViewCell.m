//
//  XiangQingTableViewCell.m
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "XiangQingTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface XiangQingTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *user_avert;
@property (strong, nonatomic) IBOutlet UILabel *user_login;
@property (strong, nonatomic) IBOutlet UILabel *creat_time;
@property (strong, nonatomic) IBOutlet UIButton *posBtn;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation XiangQingTableViewCell
- (void)setModel:(DetailModel *)model{
    [self addSubview:self.contentLabel];
    [self.user_avert sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] completed:nil];
    self.user_login.text = model.user_login;
    //时间以及楼数
    NSString *str = [NSString stringWithFormat:@"%@    %@L", model.created_at, model.floor];
    self.creat_time.text = str;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = model.content;
    [self.posBtn setTitle:[NSString stringWithFormat:@"%@", model.pos] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
