//
//  TableViewCell.h
//  HAHAManhua
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@protocol Comments <NSObject>

- (void)showComments:(NSString *)user_id;
- (void)collectionBtnAction;

@end

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) MainModel *model;

- (CGFloat)getcellHeight:(MainModel *)model;

@property (nonatomic, assign) id<Comments>delegate;

@end
