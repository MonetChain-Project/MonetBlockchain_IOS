//
//  FFCountryListViewController.m
//  MonetBlockchain
//
//  Created by Megan on 2017/9/22.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFCountryListViewController.h"
#import "FFCountryListCell.h"

static NSString *cellID = @"countryListCellID";

@interface FFCountryListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    * tableView;
@property (nonatomic,strong) NSMutableArray * countryArray;
@property(nonatomic,retain) NSString * selectedString;

@end

@implementation FFCountryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Your Country";
    
    self.countryArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DDYSCREENW, DDYSCREENH - 64)];
    _tableView.backgroundColor = FFBackColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFCountryListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[FFCountryListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellID];
    }
    
    cell.textLabel.text = @"中国";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString * countryName = self.countryArray[indexPath.row];
    
    if (self.chooseCountryBlock) {
        self.chooseCountryBlock(@"中国");
    }
    
    [self.navigationController popoverPresentationController];
}

@end
