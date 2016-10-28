//
//  UserLogin+CoreDataProperties.h
//  DemoOfCoreData
//
//  Created by 吴 吴 on 16/10/28.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import "UserLogin+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserLogin (CoreDataProperties)

+ (NSFetchRequest<UserLogin *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *userName;

@end

NS_ASSUME_NONNULL_END
