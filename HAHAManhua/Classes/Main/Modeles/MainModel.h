//
//  MainModel.h
//  HAHAManhua
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *pictures;
@property (nonatomic, copy) NSString *neg;
@property (nonatomic, copy) NSString *pos;
@property (nonatomic, copy) NSString *public_comments_count;
@property (nonatomic, copy) NSString *published_at;
@property (nonatomic, copy) NSString *reward_count;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *user_login;
@property (nonatomic, copy) NSString *user_avatar;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
