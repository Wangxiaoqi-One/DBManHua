//
//  SqliteManager.h
//  HAHAManhua
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteManager : NSObject

//用单例创建数据管理对象
+ (SqliteManager *)shareInstance;
#pragma mark ---------数据库基础操作
//创建数据库表
- (void)creatDataBaseTable;
//打开数据库
- (void)openDataBase;
//关闭数据库
- (void)closeDataBase;

#pragma marks ---------数据库常用操作

//增加数据

- (void)insertIntoDictonary:(NSDictionary *)dic;

//删除

- (void)deleteWithpicture:(NSString *)picture;

//查询所有数据

- (NSMutableArray *)selectAllcollection;

@end
