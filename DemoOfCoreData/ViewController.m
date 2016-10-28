//
//  ViewController.m
//  DemoOfCoreData
//
//  Created by 吴 吴 on 16/10/27.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"

#import "WJQCoreDataManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupUI {
    float appW = self.view.frame.size.width;
    float btnW = 70.0;
    float originX = (appW - btnW*3)/4;
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(originX,84, btnW, 44);
    saveBtn.backgroundColor = [UIColor blackColor];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [saveBtn setTitle:@"创建" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.tag = 101;
    [saveBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(originX*2+btnW, 84, btnW, 44);
    clearBtn.backgroundColor = [UIColor blackColor];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [clearBtn setTitle:@"清除" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    clearBtn.tag = 102;
    [clearBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
    
    UIButton *loadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loadBtn.frame = CGRectMake(originX*3+btnW*2, 84, btnW, 44);
    loadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    loadBtn.backgroundColor = [UIColor blackColor];
    [loadBtn setTitle:@"加载" forState:UIControlStateNormal];
    [loadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loadBtn.tag = 103;
    [loadBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
    UIButton *insertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    insertBtn.frame = CGRectMake(originX,148,btnW, 44);
    insertBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    insertBtn.backgroundColor = [UIColor blackColor];
    [insertBtn setTitle:@"插入" forState:UIControlStateNormal];
    [insertBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    insertBtn.tag = 104;
    [insertBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insertBtn];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(originX*2+btnW, 148, btnW, 44);
    deleteBtn.backgroundColor = [UIColor blackColor];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [deleteBtn setTitle:@"删除一个" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteBtn.tag = 105;
    [deleteBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updateBtn.frame = CGRectMake(originX*3+btnW*2, 148, btnW, 44);
    updateBtn.backgroundColor = [UIColor blackColor];
    updateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [updateBtn setTitle:@"更新某条" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateBtn.tag = 106;
    [updateBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateBtn];
}

#pragma mark - 按钮点击事件

- (void)btnPressed:(UIButton *)sender {
    if (sender.tag == 101)
    {
        //创建数据
        [[WJQCoreDataManager sharedManager]saveUserInfo];
    }
    else if (sender.tag == 102)
    {
        //清除数据
        [[WJQCoreDataManager sharedManager]clearUserInfo];
        
    }
    else if (sender.tag == 103)
    {
        //加载数据
    }
    else if (sender.tag == 104)
    {
        BOOL isExit = [[WJQCoreDataManager sharedManager]isExitUserWithUserId:@"哈哈_1"];
        if (isExit)
        {
            UIAlertAction *aletAction = [UIAlertAction actionWithTitle:@"确定"  style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经存在这个对象" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:aletAction];
            [self.navigationController presentViewController:alertVC animated:YES  completion:NULL];
            return;
        }
        
        //插入数据
        User *insertUser = [User new];
        insertUser.userName = @"哈哈";
        insertUser.userId   = @"哈哈_1";
        [[WJQCoreDataManager sharedManager]insertUserWithUser:insertUser];
    }
    else if (sender.tag == 105)
    {
        //删除某条数据
        NSArray *datas = [[WJQCoreDataManager sharedManager]loadUserInfo];
        if (datas.count == 0)
        {
            return;
        }
        UserLogin *tempUser = datas[0];
        [[WJQCoreDataManager sharedManager]deleteUserWithUser:tempUser];
    }
    else if (sender.tag == 106)
    {
        //更新某条数据
        NSArray *datas = [[WJQCoreDataManager sharedManager]loadUserInfo];
        if (datas.count == 0)
        {
            return;
        }
        UserLogin *tempUser = datas[0];
        tempUser.userName = @"更新后";
        [[WJQCoreDataManager sharedManager]updateUserWithLatestUser:tempUser];
    }
    else
    {
        
    }
    ListViewController *vc = [[ListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
