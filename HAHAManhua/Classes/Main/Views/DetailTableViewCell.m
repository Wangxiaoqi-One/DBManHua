//
//  DetailTableViewCell.m
//  HAHAManhua
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "DetailTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface DetailTableViewCell ()
@property (strong, nonatomic) UIImageView *user_avert;
@property (strong, nonatomic) UILabel *user_login;
@property (strong, nonatomic) UILabel *creat_time;
@property (strong, nonatomic) UIButton *posBtn;

@property (strong, nonatomic) UILabel *contentLabel;
@end

@implementation DetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configView];
    }
    return self;
}


- (void)configView{
    self.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:237 / 255.0 alpha:1.0];
    [self addSubview:self.user_avert];
    [self addSubview:self.user_login];
    [self addSubview:self.creat_time];
    [self addSubview:self.posBtn];
    [self addSubview:self.contentLabel];
}

- (void)setModel:(DetailModel *)model{
    [self.user_avert sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] completed:nil];
    self.user_login.text = model.user_login;
    //时间以及楼数
    NSString *str = [NSString stringWithFormat:@"%@    %@L", model.created_at, model.floor];
    self.creat_time.text = str;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = model.content;
    [self.posBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.posBtn setTitle:[NSString stringWithFormat:@"%@", model.pos] forState:UIControlStateNormal];
}


#pragma mark -------Lazyloading


- (UIImageView *)user_avert{
    if (_user_avert == nil) {
        self.user_avert = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 44, 44)];
    }
    return _user_avert;
}

- (UILabel *)user_login{
    if (_user_login == nil) {
        self.user_login = [[UILabel alloc] initWithFrame:CGRectMake(52, 8, kScreenWidth - 120, 25)];
        self.user_login.font = [UIFont systemFontOfSize:17.0];
        self.user_login.backgroundColor = [UIColor whiteColor];
    }
    return _user_login;
}


- (UILabel *)creat_time{
    if (_creat_time == nil) {
        self.creat_time = [[UILabel alloc] initWithFrame:CGRectMake(52, 33, kScreenWidth - 120, 19)];
        self.creat_time.textColor = [UIColor lightGrayColor];
        self.creat_time.font = [UIFont systemFontOfSize:13.0];
        self.creat_time.backgroundColor = [UIColor whiteColor];
    }
    return _creat_time;
}

- (UIButton *)posBtn{
    if (_posBtn == nil) {
        self.posBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.posBtn.frame = CGRectMake(self.user_login.right, 8, 60, 44);
        [self.posBtn setImage:[UIImage imageNamed:@"comment_ding"] forState:UIControlStateNormal];
        self.posBtn.backgroundColor = [UIColor whiteColor];
    }
    return _posBtn;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 52, kScreenWidth - 16, 44)];
        self.contentLabel.backgroundColor = [UIColor whiteColor];
    }
    return _contentLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
