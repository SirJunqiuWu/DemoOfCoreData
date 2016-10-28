//
//  WJQCoreDataManager.h
//  DemoOfCoreData
//
//  Created by 吴 吴 on 16/10/28.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserLogin+CoreDataClass.h"
#import "User.h"

@interface WJQCoreDataManager : NSObject


+ (WJQCoreDataManager *)sharedManager;

- (BOOL)saveUserInfo;
- (NSArray *)loadUserInfo;
- (BOOL)clearUserInfo;


#pragma mark - 对指定用户进行查找 更新 添加 删除

/**
 是否存在某个对象

 @param userId 当前要查看的对象id

 @return YES,已经存在;反之不存在
 */
- (BOOL)isExitUserWithUserId:(NSString *)userId;

/**
 获取指定id的用户对象

 @param userId 当前指定用户的userId

 @return 指定userId的对象
 */
- (UserLogin *)getUserWithUserId:(NSString *)userId;



/**
 更新后的最新用户信息(只需要拿到对应的关联对象，直接修改，然后保存)

 @param latestUser 用户最新信息对象

 @return 更改信息后的用户对象
 */
- (UserLogin *)updateUserWithLatestUser:(UserLogin *)latestUser;



/**
 插入新对象

 @param user 当前需要插入的对象

 @return 插入后最新的数据源
 */
- (NSArray *)insertUserWithUser:(User *)user;



/**
 删除指定对象

 @param user 当前要删除的对象
 */
- (void)deleteUserWithUser:(UserLogin *)user;


@end
