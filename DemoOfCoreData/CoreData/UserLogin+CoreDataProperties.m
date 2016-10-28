//
//  UserLogin+CoreDataProperties.m
//  DemoOfCoreData
//
//  Created by 吴 吴 on 16/10/28.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import "UserLogin+CoreDataProperties.h"

@implementation UserLogin (CoreDataProperties)

+ (NSFetchRequest<UserLogin *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserLogin"];
}

@dynamic userId;
@dynamic userName;

@end
