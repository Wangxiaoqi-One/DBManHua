//
//  YingYuanModel.h
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YingYuanModel : NSObject

@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pictures;
@property (nonatomic, copy) NSString *public_articles_pos;
@property (nonatomic, copy) NSString *public_comments_count;
@property (nonatomic, copy) NSString *total_articles_count;
@property (nonatomic, copy) NSString *moviesId;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
