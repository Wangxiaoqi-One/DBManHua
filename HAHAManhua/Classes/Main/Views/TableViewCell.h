//
//  TableViewCell.h
//  HAHAManhua
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) MainModel *model;

- (CGFloat)getcellHeight:(MainModel *)model;

@end
