//
//  AppDelegate.h
//  HAHAManhua
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *wbtoken;
@property (nonatomic, strong) NSString *wbRefreshToken;
@property (nonatomic, strong) NSString *wbCurrentUserId;

@end

