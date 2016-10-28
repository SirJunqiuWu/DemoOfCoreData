//
//  ListViewController.m
//  DemoOfCoreData
//
//  Created by 吴 吴 on 16/10/28.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import "ListViewController.h"
#import "WJQCoreDataManager.h"

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *infoTable;
    NSMutableArray *dataArray;
}

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"数据显示";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    [self uploadDataReq];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupUI {
    infoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height-64) style:UITableViewStylePlain];
    infoTable.dataSource = self;
    infoTable.delegate = self;
    [self.view addSubview:infoTable];
}

- (void)uploadDataReq {
    NSArray *datas = [[WJQCoreDataManager sharedManager]loadUserInfo];
    dataArray = [NSMutableArray arrayWithArray:datas];
    [infoTable reloadData];
}

#pragma mark - UITableViewDataSource && Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"UITableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row>=dataArray.count)
    {
        return;
    }
    UserLogin *tempUser = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"姓名:%@      ID:%@",tempUser.userName,tempUser.userId];
}



@end
