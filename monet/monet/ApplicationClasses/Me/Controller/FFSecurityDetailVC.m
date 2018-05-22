//
//  FFSecurityDetailVC.m
//  MonetBlockchain
//
//  Created by Megan on 2017/10/13.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFSecurityDetailVC.h"
#import "FFSignUpViewController.h"
#import "FFBindingEmailVC.h"

@interface FFSecurityDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableView;

@end

@implementation FFSecurityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Security";
}

-(void)buildUI
{
    self.view.backgroundColor = LC_RGB(245, 245, 245);
    _tableView.backgroundColor = LC_RGB(245, 245, 245);
    
    _tableView = [[UITableView alloc] initWithFrame:LC_RECT(0, 64, DDYSCREENW, DDYSCREENH)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseRegionCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChooseRegionCell"];
    }
    
    if (indexPath.section == 0) {

        cell.textLabel.text = [FFLocalUserInfo LCInstance].phonenumber.length <= 0 ? @"Bingding mobile phone number" : [FFLocalUserInfo LCInstance].phonenumber;
    }
    else
    {
        cell.textLabel.text = [FFLocalUserInfo LCInstance].emailnumber <= 0 ? @"Bingding email" : [FFLocalUserInfo LCInstance].emailnumber;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        FFSignUpViewController * controller = [[FFSignUpViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        FFBindingEmailVC *controller = [[FFBindingEmailVC alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
   
}


@end
