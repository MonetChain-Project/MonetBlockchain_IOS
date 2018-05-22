//
//  FFDiscoverVC.m
//  MonetBlockchain
//
//  Created by Rain on 17/12/08.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFDiscoverVC.h"
#import "FFDiscoverCell.h"
#import "FFNearbyVC.h"
#import "FFChatRoomMemberVC.h"

@interface FFDiscoverVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FFDiscoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)prepare {
    [super prepare];
    _dataArray = @[@{@"img":@"back_white",
                     @"title":@"The man near by",
                     @"detail":@"See who in your side",
                     @"row":@"0_0"},
                   @{@"img":@"back_white",
                     @"title":@"The chat room",
                     @"detail":@"Find like-minded friends",
                     @"row":@"0_1"}];
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:DDYRect(0, 64, DDYSCREENW, DDYSCREENH-64-49)];
    _tableView.backgroundColor = DDY_ClearColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
#pragma mark NumberOfRows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark CellForRow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFDiscoverCell *cell = [FFDiscoverCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadData:(NSDictionary *)self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        [self.navigationController pushViewController:[FFNearbyVC vc] animated:YES];
    }
    else if (indexPath.row == 1)
    {
        [self.navigationController pushViewController:[FFChatRoomMemberVC vc] animated:YES];
    }
}


@end
