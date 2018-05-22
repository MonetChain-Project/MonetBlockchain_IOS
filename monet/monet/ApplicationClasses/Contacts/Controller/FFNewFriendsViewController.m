//
//  FFNewFriendsViewController.m
//  MonetBlockchain
//
//  Created by Megan on 2017/12/15.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFNewFriendsViewController.h"
#import "FFNewFriendsTableViewCell.h"
#import "FFAddFriendsVC.h"
#import "FFOtherUserInfoVC.h"
#import "FFContactsRequestItem.h"
#import "MJExtension.h"

@interface FFNewFriendsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,retain) FFMessage  * message;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FFNewFriendsViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)buildUI
{
    self.title = @"Contacts";
    
    if (self.type == 1) {
        
        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Contacts" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonOnClicked)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DDYSCREENW, DDYSCREENH - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self observeNotification:FFAddFriendRequestNotification];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadFriendRequestData];
    
}

// 获取好友请求相关数据表内容
- (void)loadFriendRequestData
{
//    NSMutableArray *tmpArray = [NSMutableArray array];
    
    self.dataArray = [[FFChatDataBase sharedInstance] selectRange:NSMakeRange(0, 100) chatType:FFChatTypeSystem remoteID:t_FriendRequest];
    
//    self.dataArray = [FFContactsRequestItem mj_objectArrayWithKeyValuesArray:tmpArray];
    
    [self.tableView reloadData];
    
}

- (void)handleNotification:(NSNotification *)notification
{
    if ([notification is:FFAddFriendRequestNotification]) {
        
        [self loadFriendRequestData];
    }
}

- (void)addButtonOnClicked
{
    FFAddFriendsVC * controller = [[FFAddFriendsVC alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FFNewFriendsTableViewCell *cell = [FFNewFriendsTableViewCell cellWithTableView:tableView];
    
    cell.userListType = self.type == 1 ? FFUserListDiscoverType : FFAddUserListType;
    cell.message = self.dataArray[indexPath.row];
    
    __weak __typeof__ (self)weakSelf = self;
    cell.addFriendBlock = ^(FFMessage *message) {
        
        [weakSelf addAction:message];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FFMessage *item = self.dataArray[indexPath.row];
    
    
    FFUser *user = [[FFUser alloc] init];
    user.localid = item.uidFrom;
    user.username = item.nickName;
    user.userImage = item.userImage;
    
    FFOtherUserInfoVC * controller = [[FFOtherUserInfoVC alloc] initWithUser:user];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)addAction:(FFMessage *)message
{
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * localID = [user objectForKey:@"localid"];
    
    
    NSDictionary * params = @{
                              @"flocalid":message.uidFrom
                              };
    [NANetWorkRequest na_postDataWithService:@"friend" action:@"agree_friend" parameters:params results:^(BOOL status, NSDictionary *result) {
        
        if (status)
        {
            [self showSuccessText:@"添加成功!"];
           
            // 更新当前数据
            message.accepted = @"1";
            [self.tableView reloadData];
            
            // 更新本地数据库
            [[FFChatDataBase sharedInstance] saveMessage:message];
            
        }
        else
        {
            NSLog(@"==网络异常==");
        }
    }];
    
}

// 释放对通知的监听
- (void)dealloc
{
    [self unobserveAllNotifications];
}


@end
