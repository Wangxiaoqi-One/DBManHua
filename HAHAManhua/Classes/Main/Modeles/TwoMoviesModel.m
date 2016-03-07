//
//  TwoMoviesModel.m
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "TwoMoviesModel.h"

@implementation TwoMoviesModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
         self.score = dic[@"score"];
         self.public_comments_count = dic[@"public_comments_count"];
         self.mp4_image_link = dic[@"mp4_image_link"];
         self.videoID = dic[@"id"];
        self.mp4_file_link = dic[@"mp4_file_link"];
        self.small_pictures = dic[@"small_pictures"];
        self.user_login = dic[@"user_login"];
    }
    return self;
}

@end
