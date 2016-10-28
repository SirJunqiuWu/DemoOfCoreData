//
//  WJQCoreDataManager.m
//  DemoOfCoreData
//
//  Created by 吴 吴 on 16/10/28.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import "WJQCoreDataManager.h"
#import "AppDelegate.h"

#define App            (AppDelegate *)[UIApplication sharedApplication].delegate
#define DBNAME         @"UserLogin"

static WJQCoreDataManager *selfManager = nil;
@implementation WJQCoreDataManager

+ (WJQCoreDataManager *)sharedManager {
    @synchronized (self) {
       static dispatch_once_t pred;
        dispatch_once(&pred,^{
            selfManager = [[self alloc]init];
        });
    }
    return selfManager;
}

- (BOOL)saveUserInfo {
    AppDelegate *delegate           = App;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext           = delegate.managedObjectContext;
    
    for (int i = 0; i <50; i ++)
    {
        //根据数据源，往表里面插入实例对象
        UserLogin * tempUser            = [NSEntityDescription insertNewObjectForEntityForName:DBNAME inManagedObjectContext:context];
        tempUser.userName               = [NSString stringWithFormat:@"Jack%d",i];
        tempUser.userId                 = [NSString stringWithFormat:@"00%d",i];
        [self saveContext:context];
    }
    return YES;
}

- (NSArray *)loadUserInfo {
    NSError *error = nil;
    AppDelegate *delegate           = App;
    
    //初始化对象管理上下文
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext           = delegate.managedObjectContext;
    
    //获取实体数据请求
    NSFetchRequest *request         = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity     = [NSEntityDescription entityForName:DBNAME inManagedObjectContext:context];
    [request setEntity:entity];
    NSArray *users = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (!users)
    {
        NSLog(@"load user error:%@",error);
    }
    return users;
}

#pragma mark - 对指定用户进行查找 更新 删除

- (BOOL)isExitUserWithUserId:(NSString *)userId {
    UserLogin *tempUser = [self getUserWithUserId:userId];
    if (!tempUser)
    {
        return NO;
    }
    return YES;
}

- (UserLogin *)getUserWithUserId:(NSString *)userId {
    //创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:DBNAME];
    //创建谓词，设置获取数据的条件
    request.predicate       = [NSPredicate predicateWithFormat:@"userId=%@",userId];
    //执行对象管理上下文的查询方法
    AppDelegate *delegate   = App;
    
    //拿到请求数据
    NSArray *array          = [delegate.managedObjectContext executeFetchRequest:request error:nil];
    UserLogin *tempUser     = [array lastObject];
    return  tempUser;
}

- (UserLogin *)updateUserWithLatestUser:(UserLogin *)latestUser {
    [self saveContext:[self getTempManageObjectContext]];
    return latestUser;
}

- (NSArray *)insertUserWithUser:(User *)user {
    UserLogin *insertUser = [NSEntityDescription insertNewObjectForEntityForName:DBNAME inManagedObjectContext:[self getTempManageObjectContext]];
    insertUser.userName   = user.userName;
    insertUser.userId     = user.userId;
    [self saveContext:[self getTempManageObjectContext]];
    
    NSArray *allArr       = [self loadUserInfo];
    return allArr;
}

- (void)deleteUserWithUser:(UserLogin *)user {
    [[self getTempManageObjectContext]deleteObject:user];
    [self saveContext:[self getTempManageObjectContext]];
}


- (BOOL)clearUserInfo {
    return [self deleteAllDate:DBNAME];
}

- (BOOL)deleteAllDate:(NSString *)tableName {
    AppDelegate *delegate = App;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity  = [NSEntityDescription entityForName:tableName inManagedObjectContext:delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSManagedObjectContext* context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects != nil)
    {
        [fetchedObjects enumerateObjectsUsingBlock:^(NSManagedObject * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [context deleteObject:obj];
        }];
        return [self saveContext:context];
    }
    else
    {
        NSLog(@" error:%@",error.localizedDescription);
        return NO;
    }
    return NO;
}


- (BOOL)saveContext:(NSManagedObjectContext *)context {
    BOOL result = YES;
    AppDelegate* delegate = App;
    NSError* error;
    //异步保存上下文导致数据顺序发生变化
//    [context performBlock:^{
//        [context save:nil];
//        [delegate.managedObjectContext performBlock:^{
//            NSError* error;
//            if (![delegate.managedObjectContext save:&error])
//            {
//                NSLog(@"error is %@",error);
//            }
//        }];
//    }];
    
    //同步保存上下文，数据顺序不会发生变化
    if (context)
    {
        [context save:&error];
        if (![delegate.managedObjectContext save:&error])
        {
           NSLog(@"error is %@",error);
            result = NO;
        }
        else
        {
            result = YES;
        }
    }
    else
    {
        result = NO;
    }
    return result;
}

#pragma mark - 获取AppDelegate

- (NSManagedObjectContext *)getTempManageObjectContext {
    AppDelegate* delegate = App;
    return delegate.managedObjectContext;
}

@end
