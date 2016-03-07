//
//  UIViewController+common.m
//  HAHAManhua
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "UIViewController+common.h"

@implementation UIViewController (common)

- (void)showBackBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 44);
    [backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}


- (void)backBtnAction:(UIButton *)Btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showTitleImageView{
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    titleImageView.image = [UIImage imageNamed:@"movies_title"];
    
    self.navigationItem.titleView = titleImageView;
}


@end
