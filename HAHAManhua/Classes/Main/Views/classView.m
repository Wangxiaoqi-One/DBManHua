//
//  classView.m
//  HAHAManhua
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "classView.h"

#define kWidth self.frame.size.width

@implementation classView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView{
    self.backgroundColor = [UIColor lightGrayColor];
    //热门
    self.hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hotBtn.tag = 1;
    self.hotBtn.frame = CGRectMake(0, 0, kWidth / 2, kWidth / 2);
    [self.hotBtn setImage:[UIImage imageNamed:@"ganhuo"] forState:UIControlStateNormal];
    [self.hotBtn setImage:[UIImage imageNamed:@"ganhuo_pressed"] forState:UIControlStateHighlighted];
    //更新
    self.refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.refreshBtn.tag = 2;
    self.refreshBtn.frame = CGRectMake(self.hotBtn.right, 0, kWidth / 2, kWidth / 2);
    [self.refreshBtn setImage:[UIImage imageNamed:@"nencao"] forState:UIControlStateNormal];
    [self.refreshBtn setImage:[UIImage imageNamed:@"nencao_pressed"] forState:UIControlStateHighlighted];
    
    //英式幽默
    self.englishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.englishBtn.tag = 3;
    self.englishBtn.frame = CGRectMake(0, self.hotBtn.bottom, kWidth / 2, kWidth / 2);
    [self.englishBtn setImage:[UIImage imageNamed:@"yinshi"] forState:UIControlStateNormal];
    [self.englishBtn setImage:[UIImage imageNamed:@"yinshi_pressed"] forState:UIControlStateHighlighted];
    
    
    //暴走漫画
    
    self.manhuaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.manhuaBtn.tag = 4;
    self.manhuaBtn.frame = CGRectMake(self.englishBtn.right, self.hotBtn.bottom, kWidth / 2, kWidth / 2);
    [self.manhuaBtn setImage:[UIImage imageNamed:@"baozou"] forState:UIControlStateNormal];
    [self.manhuaBtn setImage:[UIImage imageNamed:@"baozou_pressed"] forState:UIControlStateHighlighted];
    
    //gif怪兽
    self.gifBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.gifBtn.tag = 5;
    self.gifBtn.frame = CGRectMake(0, self.manhuaBtn.bottom, kWidth / 2, kWidth / 2);
    [self.gifBtn setImage:[UIImage imageNamed:@"gif"] forState:UIControlStateNormal];
    [self.gifBtn setImage:[UIImage imageNamed:@"gif_pressed"] forState:UIControlStateHighlighted];
    
    //神吐槽
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.tag = 6;
    self.commentBtn.frame = CGRectMake(self.gifBtn.right, self.manhuaBtn.bottom, kWidth / 2, kWidth / 2);
    [self.commentBtn setImage:[UIImage imageNamed:@"tucao"] forState:UIControlStateNormal];
    [self.commentBtn setImage:[UIImage imageNamed:@"tucao_pressed"] forState:UIControlStateHighlighted];
    
    
    [self addSubview:self.hotBtn];
    [self addSubview:self.refreshBtn];
    [self addSubview:self.englishBtn];
    [self addSubview:self.manhuaBtn];
    [self addSubview:self.gifBtn];
    [self addSubview:self.commentBtn];
}

@end
