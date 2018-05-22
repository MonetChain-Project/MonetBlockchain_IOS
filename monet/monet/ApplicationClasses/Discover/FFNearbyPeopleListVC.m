//
//  FFNearbyPeopleListVC.m
//  MonetBlockchain
//
//  Created by Rain on 17/12/08.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFNearbyPeopleListVC.h"
#import "FFOtherUserInfoVC.h"
#import "FFNewFriendsTableViewCell.h"
#import "DQActionSheet.h"

@interface FFNearbyPeopleListVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation FFNearbyPeopleListVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadNoNetworkData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = DDYLocalStr(@"Discover");
    
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nearby_choose"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(nearbyChooseAction)];

    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"wallet_qrcode_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(changeAction)];
    
    NSArray *arr = [[NSArray alloc]initWithObjects:right1, right2, nil];
    
    self.navigationItem.rightBarButtonItems = arr;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DDYSCREENW, DDYSCREENH - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    self.dataArray = [NSMutableArray array];
    
}

-(void)nearbyChooseAction
{
    DQActionSheet *sheet = [[DQActionSheet alloc]initWithTitle:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"man",@"woman",@"all",nil];
    
    [sheet showInView:self.view];
    
    //    __weak __typeof__ (self)weakSelf = self;
    sheet.actionBlock = ^( NSInteger clickIndex)
    {
        if (clickIndex == 0)
        {
    
        }
        else
        {
            
        }
    };
}

-(void)changeAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadNoNetworkData {
    [[FFMCManager sharedManager] initWithUser:[FFLoginDataBase sharedInstance].loginUser];
    [self.tableView reloadData];
    __weak __typeof__(self) weakSelf = self;
    [FFMCManager sharedManager].usersArrayChangeBlock = ^(NSMutableArray *onlineUsersArray)
    {
        weakSelf.dataArray = [NSMutableArray array];
        [weakSelf.dataArray addObjectsFromArray:onlineUsersArray];
        [weakSelf.tableView reloadData];
        
    };
}

#pragma mark TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FFNewFriendsTableViewCell *cell = [FFNewFriendsTableViewCell cellWithTableView:tableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userListType = FFUserListDiscoverType;
    cell.user = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FFUser * user = self.dataArray[indexPath.row];
    
    FFOtherUserInfoVC * controller = [[FFOtherUserInfoVC alloc] initWithUser:user];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
