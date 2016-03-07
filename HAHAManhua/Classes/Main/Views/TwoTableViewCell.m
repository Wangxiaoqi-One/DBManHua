//
//  TwoTableViewCell.m
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "TwoTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface TwoTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *mp4Image;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet UIButton *posBtn;

@property (strong, nonatomic) IBOutlet UIButton *commentsBtn;


@end

@implementation TwoTableViewCell


- (void)setTwoModel:(TwoMoviesModel *)twoModel{
    [self.mp4Image sd_setImageWithURL:[NSURL URLWithString:twoModel.mp4_image_link] completed:nil];
     self.contentLabel.numberOfLines = 0;
    self.contentLabel.text = twoModel.title;
    [self.posBtn setTitle:[NSString stringWithFormat:@"%@", twoModel.score] forState:UIControlStateNormal];
    [self.commentsBtn setTitle:[NSString stringWithFormat:@"%@", twoModel.public_comments_count] forState:UIControlStateNormal];}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
