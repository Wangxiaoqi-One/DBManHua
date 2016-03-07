//
//  YingYuanModel.m
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "YingYuanModel.h"

@implementation YingYuanModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.moviesId = dic[@"id"];
        self.descriptions = dic[@"description"];
        self.name = dic[@"name"];
        self.pictures = dic[@"pictures"];
        self.public_articles_pos = dic[@"public_articles_pos"];
        self.public_comments_count = dic[@"public_comments_count"];
        self.total_articles_count = dic[@"total_articles_count"];
    }
    return self;
}

@end
