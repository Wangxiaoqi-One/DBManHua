//
//  DownloadModel.m
//  HAHAManhua
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "DownloadModel.h"

@implementation DownloadModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.time = dic[@"date"];
        self.icon = dic[@"icon"];
        self.month = dic[@"month"];
        self.size = dic[@"size"];
        self.uuid = dic[@"uuid"];
        self.zip_url = dic[@"zip_url"];
        self.year = dic[@"year"];
        self.zip_name = dic[@"zip_name"];
    }
    return self;
}

@end
