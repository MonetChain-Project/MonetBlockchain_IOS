//
//  FFChatListVC.m
//  MonetBlockchain
//
//  Created by Rain on 17/9/18.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFChatListVC.h"
#import "FFUserListView.h"


@interface FFChatListVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FFUserListView *userListView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) FFMCManager *mcManager;

@end

@implementation FFChatListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
}

- (void)prepare {
    [super prepare];
    self.title = @"无网社交";
    
    __weak __typeof__(self) weakSelf = self;
    NSString *randomStr = DDYStrFormat(@"%u%u%u",arc4random_uniform(10),arc4random_uniform(10),arc4random_uniform(10));
    FFUser *user = [FFUser userWithDict:@{@"nickName":randomStr,
                                                  @"localID":randomStr,
                                                  @"avatarPath":@"1",
                                                  @"sex":@"1",
                                                  @"age":@"11"}];
//    _mcManager = [[FFMCManager alloc] initWithUser:user];
//    _mcManager.usersArrayChangeBlock = ^(NSMutableArray *onlineUsersArray) {
//        [weakSelf.userListView changeList:onlineUsersArray];
//        if (onlineUsersArray && onlineUsersArray.count) {
//            weakSelf.tableView.frame = DDYRect(0, 64+FFUserListViewH, DDYSCREENW, DDYSCREENH - 64-FFUserListViewH);
//        } else {
//            weakSelf.tableView.frame = DDYRect(0, 64, DDYSCREENW, DDYSCREENH - 64);
//        }
//        weakSelf.userListView.hidden = !onlineUsersArray.count;
//    };
}

- (void)setupContentView {
    _tableView = [[UITableView alloc] initWithFrame:DDYRect(0, 64, DDYSCREENW, DDYSCREENH - 64)];
    _tableView.backgroundColor = FFBackColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (FFUserListView *)userListView {
    if (!_userListView) {
        _userListView = [FFUserListView listView];
        _userListView.backgroundColor = DDY_White;
        [self.view addSubview:_userListView];
    }
    return _userListView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellID];
    }
    
    cell.textLabel.text = @"白日依山尽,黄河入海流。欲穷千里目,更上一层楼。";
    
    return cell;
}


@end

