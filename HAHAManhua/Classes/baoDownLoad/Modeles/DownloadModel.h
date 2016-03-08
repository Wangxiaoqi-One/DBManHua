//
//  DownloadModel.h
//  HAHAManhua
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadModel : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *zip_url;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *zip_name;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
