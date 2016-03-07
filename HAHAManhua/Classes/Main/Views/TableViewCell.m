//
//  TableViewCell.m
//  HAHAManhua
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "TableViewCell.h"
#import <UIImageView+WebCache.h>

#define kwidth (kScreenWidth - 6)/ 5

@interface TableViewCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *picturesView;
@property (strong, nonatomic) UIImageView *user_ImageView;
@property (strong, nonatomic) UIButton *posBtn;

@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *creatTimeLabel;

@property (strong, nonatomic) UIButton *rmbBtn;

@property (strong, nonatomic) UIButton *negBtn;
@property (strong, nonatomic) UIButton *commentsBtn;
@property (strong, nonatomic) UIButton *favoriteBtn;
@property (strong, nonatomic) UIButton *shareBtn;

@property (strong, nonatomic) UIView *userView;

@property (strong, nonatomic) UIView *btnsView;

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView{
    self.backgroundColor = [UIColor colorWithRed:240/ 255.0 green:240/ 255.0 blue:240/ 255.0 alpha:1.0];
    //标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, kScreenWidth - 16, 44)];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];
    //图片
    self.picturesView = [[UIImageView alloc] initWithFrame:CGRectMake(8, self.titleLabel.bottom, kScreenWidth - 16, 200)];
    [self addSubview:self.picturesView];
    [self addSubview:self.userView];
    [self addSubview:self.btnsView];
}

#pragma mark -------LazyLoading

-(UIView *)userView{
    if (_userView == nil) {
        self.userView = [[UIView alloc] initWithFrame:CGRectMake(8, self.picturesView.bottom, kScreenWidth - 16, 44)];
        self.userView.backgroundColor = [UIColor whiteColor];
        self.user_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [self.userView addSubview:self.user_ImageView];
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.user_ImageView.right, 0, 290, 30)];
        self.userNameLabel.font = [UIFont systemFontOfSize:20];
        [self.userView addSubview:self.userNameLabel];
        [self.userView addSubview:self.creatTimeLabel];
        [self.userView addSubview:self.rmbBtn];
    }
    return _userView;
}

- (UIView *)btnsView{
    if (_btnsView == nil) {
        self.btnsView = [[UIView alloc] initWithFrame:CGRectMake(5, self.userView.bottom, kScreenWidth - 10, 44)];
        self.btnsView.backgroundColor = [UIColor whiteColor];
        [self.btnsView addSubview:self.posBtn];
        [self.btnsView addSubview:self.negBtn];
        [self.btnsView addSubview:self.commentsBtn];
        [self.btnsView addSubview:self.favoriteBtn];
        [self.btnsView addSubview:self.shareBtn];
    }
    return _btnsView;
}

- (UILabel *)creatTimeLabel{
    if (_creatTimeLabel == nil) {
        self.creatTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.user_ImageView.right, self.userNameLabel.bottom, 290, 14)];
        self.creatTimeLabel.font = [UIFont systemFontOfSize:12];
        self.creatTimeLabel.textColor = [UIColor lightGrayColor];
    }
    return _creatTimeLabel;
}


- (UIButton *)rmbBtn{
    if (_rmbBtn == nil) {
        self.rmbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rmbBtn.frame = CGRectMake(self. userNameLabel.right, 0, 30, 44);
        [self.rmbBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _rmbBtn;
}
- (UIButton *)posBtn{
    if (_posBtn == nil) {
        self.posBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.posBtn.frame = CGRectMake(0, 0, kwidth, 44);
        [self.posBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _posBtn;
}

- (UIButton *)negBtn{
    if (_negBtn == nil) {
        self.negBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.negBtn.frame = CGRectMake(self. posBtn.right, 0, kwidth, 44);
        [self.negBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _negBtn;
}

- (UIButton *)commentsBtn{
    if (_commentsBtn == nil) {
        self.commentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentsBtn.frame = CGRectMake(self. negBtn.right, 0, kwidth, 44);
        [self.commentsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _commentsBtn;
}

- (UIButton *)favoriteBtn{
    if (_favoriteBtn == nil) {
        self.favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.favoriteBtn.frame = CGRectMake(self. commentsBtn.right, 0, kwidth, 44);
        [self.favoriteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _favoriteBtn;
}

- (UIButton *)shareBtn{
    if (_shareBtn == nil) {
        self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shareBtn.frame = CGRectMake(self. favoriteBtn.right, 0, kwidth, 44);
        [self.shareBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

- (void)setModel:(MainModel *)model{
    self.titleLabel.text = model.content;
    CGFloat height = [model.height floatValue];
    self.picturesView.frame = CGRectMake(8, self.titleLabel.bottom, kScreenWidth - 16, height);
    [self.picturesView sd_setImageWithURL:[NSURL URLWithString:model.pictures] completed:nil];
    self.userView.frame = CGRectMake(8, self.picturesView.bottom, kScreenWidth - 16, 44);
    [self.user_ImageView sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] completed:nil];
    self.userNameLabel.text = model.user_login;
    self.creatTimeLabel.text = model.published_at;
    self.btnsView.frame = CGRectMake(5, self.userView.bottom, kScreenWidth - 10, 44);
    [self.rmbBtn setTitle:[NSString stringWithFormat:@"%@", model.reward_count] forState:UIControlStateNormal];
    [self.posBtn setTitle:[NSString stringWithFormat:@"%@", model.pos] forState:UIControlStateNormal];
    [self.negBtn setTitle:[NSString stringWithFormat:@"%@", model.neg] forState:UIControlStateNormal];
    [self.commentsBtn setTitle:[NSString stringWithFormat:@"%@", model.public_comments_count] forState:UIControlStateNormal];
    [self.favoriteBtn setTitle:[NSString stringWithFormat:@"收藏"] forState:UIControlStateNormal];
        [self.shareBtn setTitle:[NSString stringWithFormat:@"分享"] forState:UIControlStateNormal];
}

- (CGFloat)getcellHeight:(MainModel *)model{
    CGFloat mheight = [model.height floatValue];
    CGFloat height = mheight + 135;
    return height;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
