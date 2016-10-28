//
//  User.h
//  DemoOfCoreData
//
//  Created by 吴 吴 on 16/10/28.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 作为实例对象变更过程中使用的周转对象
 */
@interface User : NSObject

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userId;

@end
