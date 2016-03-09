//
//  MainModel.m
//  HAHAManhua
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        self.content = dic[@"title"];
        self.height = dic[@"height"];
        self.pictures = dic[@"pictures"];
        self.neg = dic[@"neg"];
        self.pos = dic[@"pos"];
        self.public_comments_count = dic[@"public_comments_count"];
        self.published_at = dic[@"published_at"];
        self.reward_count = dic[@"reward_count"];
        self.title = dic[@"title"];
        self.user_login = dic[@"user_login"];
        self.user_avatar = dic[@"user_avatar"];
        self.user_id = dic[@"id"];
    }
    return self;
}



@end
