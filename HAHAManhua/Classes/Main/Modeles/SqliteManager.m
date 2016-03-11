//
//  SqliteManager.m
//  HAHAManhua
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 WangXiaoQi. All rights reserved.
//

#import "SqliteManager.h"
#import <sqlite3.h>
//引入数据库头文件

@interface SqliteManager ()

{
    NSString *dataBasePath;
}

@property (nonatomic, strong) BmobUser *user;

@end

@implementation SqliteManager


//创建静态单例对象(SqliteManager)
static SqliteManager *dbManager = nil;

+(SqliteManager *)shareInstance{
    if (dbManager == nil) {
        dbManager = [[SqliteManager alloc] init];
    }
    return dbManager;
}



#pragma mark -----------数据库基础操作

static sqlite3 *dataBase = nil;

- (void)creatDataBase{
  //获取应用程序沙盒路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    dataBasePath = [documentPath stringByAppendingPathComponent:@"/user.sqlite"];
    NSLog(@"%@", dataBasePath);
}


- (void)openDataBase{
    if (dataBase != nil) {
        return;
    }else{
        [self creatDataBase];
    }
    int result = sqlite3_open([dataBasePath UTF8String], &dataBase);
    if (result == SQLITE_OK) {
        WXQLog(@"数据库打开成功");
        [self creatDataBaseTable];
    }else{
        WXQLog(@"数据库打开失败");
    }
}

- (void)creatDataBaseTable{
    BmobUser *user = [BmobUser getCurrentUser];
     NSString *sql = [NSString stringWithFormat:@"CREATE TABLE a%@ (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, title TEXT NOT NULL, user_avatar TEXT NOT NULL, created_at TEXT NOT NULL, pictures TEXT, neg TEXT NOT NULL, pos TEXT NOT NULL, reward_count TEXT NOT NULL, public_comments_count TEXT NOT NULL, height TEXT NOT NULL)", user.username];
    int result = sqlite3_exec(dataBase, [sql UTF8String], nil, nil, nil);
    if (result == SQLITE_OK) {
        NSLog(@"OK");
    }else{
        NSLog(@"false");
    }
}

- (void)closeDataBase{
    int result = sqlite3_close(dataBase);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
        dataBase = nil;
    }else{
        NSLog(@"数据库关闭失败");
    }
}

#pragma  mark ------数据库常用操作


- (void)insertIntoDictonary:(NSDictionary *)dic{
    //打开数据库
    [self openDataBase];
    sqlite3_stmt *stmt = nil;
    BmobUser *user = [BmobUser getCurrentUser];
    //sql语句
NSString *sql = [NSString stringWithFormat:@"INSERT INTO a%@ (name, title, user_avatar, created_at, pictures, neg, pos, reward_count, public_comments_count, height) values (?,?,?,?,?,?,?,?,?,?)", user.username];
    
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [dic[@"user_login"] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [dic[@"title"] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [dic[@"user_avatar"] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [dic[@"created_at"] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 5, [dic[@"pictures"] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 6, [dic[@"neg"] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 7, [dic[@"pos"] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 8, [dic[@"reward_count"] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 9, [dic[@"public_comments_count"] UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 10, [[NSString stringWithFormat:@"%@", dic[@"height"]] UTF8String], -1, nil);
        sqlite3_step(stmt);
    }else{
        WXQLog(@"sql语句有问题");
    }
    sqlite3_finalize(stmt);
}


- (void)deleteWithpicture:(NSString *)picture{
    [self openDataBase];
    sqlite3_stmt *stmt = nil;
    //sql语句
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where name = ?", _user.username];
    //验证SQL语句
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        //绑定name的值
        sqlite3_bind_text(stmt, 1, [picture UTF8String], -1, nil);
        sqlite3_step(stmt);
    }else{
        NSLog(@"删除语句有问题");
    }
    //释放
    sqlite3_finalize(stmt);
}


- (NSMutableArray *)selectAllcollection{
    [self openDataBase];
    sqlite3_stmt *stmt;
    BmobUser *user = [BmobUser getCurrentUser];
    NSString *sql = [NSString stringWithFormat:@"select * from a%@", user.username];
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, nil);
    NSMutableArray *allArray = [NSMutableArray new];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            //            title, user_avatar, created_at, pictures, neg, pos, reward_count, public_comments_count
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            
            NSString *user_avatar = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            
            NSString *created_at = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            
            NSString *pictures = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            
            NSString *neg = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            
            NSString *pos = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
            NSString *reward_count = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 8)];
            NSString *public_comments_count = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 9)];
            NSString *height = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 10)];
            NSDictionary *dic = @{@"user_login": name, @"title":title, @"user_avatar": user_avatar, @"created_at": created_at, @"pictures":pictures, @"neg":neg, @"pos":pos, @"reward_count":reward_count, @"public_comments_count":public_comments_count,@"height":height};
            [allArray addObject:dic];
        }
        NSLog(@"PERFECT");
        WXQLog(@"%lu", allArray.count);
    }else{
        NSLog(@"shhhhhhhhhhhh");
    }
    sqlite3_finalize(stmt);
    return allArray;
}


@end
