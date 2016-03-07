//
//  DetailModel.h
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property (nonatomic, copy) NSString *user_login;
@property (nonatomic, copy) NSString *user_avatar;
@property (nonatomic, copy) NSString *pos;
@property (nonatomic, copy) NSString *floor;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *content;


- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
