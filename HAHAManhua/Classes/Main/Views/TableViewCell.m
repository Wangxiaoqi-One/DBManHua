//
//  TableViewCell.m
//  HAHAManhua
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "TableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ShareView.h"
#import "SqliteManager.h"

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

@property (strong, nonatomic) ShareView *shareView;

@property (copy, nonatomic) NSString *user_id;

@property (copy, nonatomic) NSString *high;
@property (copy, nonatomic) NSString *user_avart;
@property (copy, nonatomic) NSString *picture;

@property (nonatomic, assign) BOOL press;

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
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.user_ImageView.right, 0, 250, 30)];
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
        self.creatTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.user_ImageView.right, self.userNameLabel.bottom, 250, 14)];
        self.creatTimeLabel.font = [UIFont systemFontOfSize:12];
        self.creatTimeLabel.textColor = [UIColor lightGrayColor];
    }
    return _creatTimeLabel;
}


- (UIButton *)rmbBtn{
    if (_rmbBtn == nil) {
        self.rmbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rmbBtn.frame = CGRectMake(self. userNameLabel.right, 0, 70, 44);
        [self.rmbBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.rmbBtn setImage:[UIImage imageNamed:@"reward_btn"] forState:UIControlStateNormal];
        self.rmbBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
        self.rmbBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -36, 0, 0);
        self.rmbBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _rmbBtn;
}
- (UIButton *)posBtn{
    if (_posBtn == nil) {
        self.posBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.posBtn.frame = CGRectMake(0, 0, kwidth, 44);
        [self.posBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.posBtn setImage:[UIImage imageNamed:@"comment_ding_pressed"] forState:UIControlStateNormal];
        [self.posBtn addTarget:self action:@selector(pospressAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _posBtn;
}

- (UIButton *)negBtn{
    if (_negBtn == nil) {
        self.negBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.negBtn.frame = CGRectMake(self. posBtn.right, 0, kwidth, 44);
        [self.negBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.negBtn setImage:[UIImage imageNamed:@"button_cai"] forState:UIControlStateNormal];
        [self.negBtn addTarget:self action:@selector(negpressAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _negBtn;
}

- (UIButton *)commentsBtn{
    if (_commentsBtn == nil) {
        self.commentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentsBtn.frame = CGRectMake(self. negBtn.right, 0, kwidth, 44);
        [self.commentsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.commentsBtn setImage:[UIImage imageNamed:@"button_comment"] forState:UIControlStateNormal];
        [self.commentsBtn addTarget:self action:@selector(commentsDetail) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentsBtn;
}

- (UIButton *)favoriteBtn{
    if (_favoriteBtn == nil) {
        self.favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.favoriteBtn.frame = CGRectMake(self. commentsBtn.right, 0, kwidth, 44);
        [self.favoriteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.favoriteBtn setImage:[UIImage imageNamed:@"bookmark_btn"] forState:UIControlStateNormal];
        [self.favoriteBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favoriteBtn;
}

- (UIButton *)shareBtn{
    if (_shareBtn == nil) {
        self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shareBtn.frame = CGRectMake(self. favoriteBtn.right, 0, kwidth, 44);
        [self.shareBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"bookshop_share_btn"] forState:UIControlStateNormal];
        [self.shareBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}


#pragma mark ------set方法

- (void)setModel:(MainModel *)model{
    self.user_id = model.user_id;
    self.titleLabel.text = model.content;
    self.high = [NSString stringWithFormat:@"%@", model.height];
    CGFloat height = [model.height floatValue];
    self.picturesView.frame = CGRectMake(8, self.titleLabel.bottom, kScreenWidth - 16, height);
    self.picture = model.pictures;
    [self.picturesView sd_setImageWithURL:[NSURL URLWithString:model.pictures] completed:nil];
    self.userView.frame = CGRectMake(8, self.picturesView.bottom, kScreenWidth - 16, 44);
    self.user_avart = model.user_avatar;
    [self.user_ImageView sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] completed:nil];
    self.userNameLabel.text = model.user_login;
    self.creatTimeLabel.text = model.published_at;
    self.btnsView.frame = CGRectMake(5, self.userView.bottom, kScreenWidth - 10, 44);
    [self.rmbBtn setTitle:[NSString stringWithFormat:@"%@", model.reward_count] forState:UIControlStateNormal];
    [self.posBtn setTitle:[NSString stringWithFormat:@"%@", model.pos] forState:UIControlStateNormal];
    [self.negBtn setTitle:[NSString stringWithFormat:@"%@", model.neg] forState:UIControlStateNormal];
    [self.commentsBtn setTitle:[NSString stringWithFormat:@"%@", model.public_comments_count] forState:UIControlStateNormal];
    [self.favoriteBtn setTitle:[NSString stringWithFormat:@"收藏"] forState:UIControlStateNormal];
    [self.favoriteBtn setHidden:NO];
//    [self.shareBtn setTitle:[NSString stringWithFormat:@"分享"] forState:UIControlStateNormal];
    [self.shareBtn setHidden:NO];
}

-(void)setDic:(NSDictionary *)dic{
    self.titleLabel.text = dic[@"title"];
    CGFloat height = [dic[@"height"] floatValue];
    
    self.picturesView.frame = CGRectMake(8, self.titleLabel.bottom, kScreenWidth - 16, height);
    WXQLog(@" %.2f----%@", height, dic[@"pictures"]);
    [self.picturesView sd_setImageWithURL:[NSURL URLWithString:dic[@"pictures"]] completed:nil];
    self.userView.frame = CGRectMake(8, self.picturesView.bottom, kScreenWidth - 16, 44);
    [self.user_ImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"user_avatar"]] completed:nil];
    self.userNameLabel.text = dic[@"user_login"];
    self.creatTimeLabel.text = dic[@"created_at"];
    self.btnsView.frame = CGRectMake(5, self.userView.bottom, kScreenWidth - 10, 44);
    [self.rmbBtn setTitle:[NSString stringWithFormat:@"%@", dic[@"reward_count"]] forState:UIControlStateNormal];
    [self.posBtn setTitle:[NSString stringWithFormat:@"%@", dic[@"pos"]] forState:UIControlStateNormal];
    [self.negBtn setTitle:[NSString stringWithFormat:@"%@", dic[@"neg"]] forState:UIControlStateNormal];
    [self.commentsBtn setTitle:[NSString stringWithFormat:@"%@", dic[@"public_comments_count"]] forState:UIControlStateNormal];
    [self.favoriteBtn setHidden:YES];
    [self.shareBtn setHidden:YES];
}


#pragma mark  ----获取高度的方法

- (CGFloat)getcellHeight:(MainModel *)model{
    CGFloat mheight = [model.height floatValue];
    CGFloat height = mheight + 135;
    return height;
}

-(CGFloat)getcellHeights:(NSDictionary *)dic{
    CGFloat mheight = [dic[@"height"] floatValue];
    CGFloat height = mheight + 135;
    return height;
}

#pragma mark -------按钮方法

//分享
- (void)shareBtnAction{
    self.shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
}

//评论
- (void)commentsDetail{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(showComments:)]) {
        [self.delegate showComments:self.user_id];
    }
}


//收藏
- (void)collectionAction{
    BmobUser *user = [BmobUser getCurrentUser];
    if (user != nil) {
        NSDictionary *dic = @{@"user_login": self.userNameLabel.text, @"title":self.titleLabel.text, @"user_avatar": self.user_avart, @"created_at": self.creatTimeLabel.text, @"pictures":self.picture, @"neg":self.negBtn.titleLabel.text, @"pos":self.posBtn.titleLabel.text, @"reward_count":self.rmbBtn.titleLabel.text, @"public_comments_count":self.commentsBtn.titleLabel.text, @"height":self.high};
        for (NSString *str in [dic allValues]) {
            WXQLog(@"%@", str);
        }
        SqliteManager *sqlManager = [SqliteManager shareInstance];
        [sqlManager openDataBase];
        [sqlManager insertIntoDictonary:dic];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"特大喜讯" message:@"观众老爷已为你收藏好" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
    }else{
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(collectionBtnAction)]) {
            [self.delegate collectionBtnAction];
        }
    }
}


//顶
- (void)pospressAction{
    if (!_press) {
       NSInteger poscount = [self.posBtn.titleLabel.text integerValue] + 1;
        [self.posBtn setTitle:[NSString stringWithFormat:@"%ld", poscount] forState:UIControlStateNormal];
        self.press = YES;
    }else{
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(warnAction)]) {
            [self.delegate warnAction];
            self.press = YES;
        }
    }
}

- (void)negpressAction{
    if (!_press) {
        NSInteger negcount = [self.negBtn.titleLabel.text integerValue] + 1;
        [self.negBtn setTitle:[NSString stringWithFormat:@"%ld", negcount] forState:UIControlStateNormal];
        self.press = YES;
    }else{
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(warnAction)]) {
            [self.delegate warnAction];
            self.press = YES;
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
