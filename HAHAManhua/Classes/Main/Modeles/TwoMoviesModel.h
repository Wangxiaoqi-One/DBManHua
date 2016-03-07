//
//  TwoMoviesModel.h
//  HAHAManhua
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwoMoviesModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *public_comments_count;
@property (nonatomic, copy) NSString *mp4_image_link;
@property (nonatomic, copy) NSString *videoID;
@property (nonatomic, copy) NSString *mp4_file_link;
@property (nonatomic, copy) NSString *small_pictures;
@property (nonatomic, copy) NSString *user_login;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
