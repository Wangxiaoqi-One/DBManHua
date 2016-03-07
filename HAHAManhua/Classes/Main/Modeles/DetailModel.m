//
//  DetailModel.m
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.user_login = dic[@"user_login"];
        self.user_avatar = dic[@"user_avatar"];
        self.pos = dic[@"pos"];
        self.floor = dic[@"floor"];
        self.created_at = dic[@"created_at"];
        self.content = dic[@"content"];
    }
    return self;
}

@end
