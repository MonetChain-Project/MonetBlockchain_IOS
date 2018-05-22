//
//  FFFriendSetViewController.m
//  MonetBlockchain
//
//  Created by Rain on 17/11/28.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFFriendSetViewController.h"
#import "FFComplaintsListVC.h"
#import "FFBackUpNameVC.h"

@interface FFFriendSetViewController ()
{
    UIView      * _topView;
    UIView      * _midView;
    UIView      * _bottomView;
    UIButton    * _deleteBtn;
    UILabel     * _addLbl;
    UILabel     * _blackList;
    UILabel     * _complaints;
    UIImageView * _arrow;
    UILabel     * _country;
    UISwitch    * _switch;
}
@property(nonatomic,strong)FFUser * user;

@end

@implementation FFFriendSetViewController

-(instancetype)initWitheUser:(FFUser *)user
{
    if (self = [super init]) {
        self.user = user;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Data set";
}

- (void)buildUI
{
    _topView = [[UIView alloc] initWithFrame:LC_RECT(0, 74, DDYSCREENW, 50)];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    _topView.userInteractionEnabled = YES;
    [_topView addTapTarget:self action:@selector(backUpNameAction)];
    
    _midView = [[UIView alloc] initWithFrame:LC_RECT(0, _topView.viewBottomY + 10, DDYSCREENW, 50)];
    _midView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_midView];
    
    _bottomView = [[UIView alloc] initWithFrame:LC_RECT(0, _midView.viewBottomY + 10 , DDYSCREENW, 50)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    _bottomView.userInteractionEnabled = YES;
    [_bottomView addTapTarget:self action:@selector(complaintsAction)];
    
    _deleteBtn = [[UIButton alloc] initWithFrame:LC_RECT(20, _bottomView.viewBottomY + 30,DDYSCREENW - 40 , 50)];
    [_deleteBtn setTitle:@"Delete" forState: UIControlStateNormal];
    _deleteBtn.titleLabel.font = NA_FONT(16);
    [_deleteBtn setTitleColor:LC_RGB(51, 51, 51) forState:UIControlStateNormal];
    _deleteBtn.layer.cornerRadius = 25;
    _deleteBtn.layer.masksToBounds = YES;
    _deleteBtn.backgroundColor = LC_RGB(247, 218, 87);
    [self.view addSubview:_deleteBtn];
    [_deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    _addLbl = [[UILabel alloc] initWithFrame:LC_RECT(10, 0, DDYSCREENW - 20, 50)];
    _addLbl.textColor = LC_RGB(51, 51, 51);
    _addLbl.font = NA_FONT(15);
    _addLbl.text = @"Add notes";
    [_topView addSubview:_addLbl];
    
    _arrow = [[UIImageView alloc] initWithFrame:LC_RECT(DDYSCREENW - 40, 0, 20, 20)];
    _arrow.viewCenterY = _addLbl.viewCenterY;
    _arrow.image = [UIImage imageNamed:@"arrow_icon"];
    [_topView addSubview:_arrow];
    
    _country = [[UILabel alloc] initWithFrame:LC_RECT(DDYSCREENW - 140, 0, 100, 50)];
    _country.textAlignment = NSTextAlignmentRight;
    _country.textColor = LC_RGB(51, 51, 51);
    _country.font = NA_FONT(15);
    _country.text = self.user.noteName ? self.user.noteName : @"";
    [_topView addSubview:_country];
    
    _blackList = [[UILabel alloc] initWithFrame:LC_RECT(10, 0, DDYSCREENW - 20, 50)];
    _blackList.textColor = LC_RGB(51, 51, 51);
    _blackList.font = NA_FONT(15);
    _blackList.text = @"Join the blacklist";
    [_midView addSubview:_blackList];
    
    _switch = [[UISwitch alloc] initWithFrame:LC_RECT(DDYSCREENW - 90, 0, 80, 40)];
    _switch.viewCenterY = _blackList.viewCenterY;
    [_midView addSubview:_switch];
    [_switch setOn:NO];
    [_switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    
    _complaints = [[UILabel alloc] initWithFrame:LC_RECT(10, 0, DDYSCREENW - 20, 50)];
    _complaints.textColor = LC_RGB(51, 51, 51);
    _complaints.font = NA_FONT(15);
    _complaints.text = @"complaints";
    [_bottomView addSubview:_complaints];
}

- (void)deleteAction
{
    NSDictionary * params = @{@"flocalid":self.user.localid};
    [NANetWorkRequest na_postDataWithService:@"friend" action:@"delete_friend" parameters:params results:^(BOOL status, NSDictionary *result) {
        if (status) {
            
            NSLog(@"==好友删除成功!==");
            [self showSuccessText:@"删除成功!"];
        }
        else
        {
            NSLog(@"==网络异常==");
        }
    }];
}

-(void)backUpNameAction
{
    FFBackUpNameVC * controller = [[FFBackUpNameVC alloc] initWithUser:self.user];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)complaintsAction
{
    FFComplaintsListVC * controller = [[FFComplaintsListVC alloc] initWithUser:self.user];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        
        [self loadAddBlackList];
    }else {
        
        [self requestRemoveBlackFriend];
    }
}

-(void) requestRemoveBlackFriend
{
    NSDictionary * params = @{@"blocalid":self.user.localid};
    
    [NANetWorkRequest na_postDataWithService:@"blacklist" action:@"remove_black_list" parameters:params results:^(BOOL status, NSDictionary *result) {
        
        if (status) {
            
            NSLog(@"==解除拉黑==");
            [self showSuccessText:@"解除拉黑"];
        }
        else
        {
            NSLog(@"==网络异常==");
        }
        
    }];
}

-(void)loadAddBlackList
{
    NSDictionary * params = @{
                              @"blocalid":self.user.localid,
                              @"isblack":@"1"
                              };
    
    [NANetWorkRequest na_postDataWithService:@"blacklist" action:@"add_black_list" parameters:params results:^(BOOL status, NSDictionary *result) {
        if (status) {
            
            NSLog(@"已拉黑用户");
            [self showSuccessText:@"已拉黑用户"];
        }
        else
        {
            NSLog(@"==网络异常==");
        }
        
    }];
}

- (void)requestUserInfo
{
    [FFLocalUserInfo LCInstance].isUser = YES;
    [FFLocalUserInfo LCInstance].isSignUp = YES;
    
    [NANetWorkRequest na_postDataWithService:@"user" action:@"userinfo" parameters:@{@"localid":self.user.localid} results:^(BOOL status, NSDictionary *result) {
        
        if (status) {
            
            NSDictionary * dict = [result objectForKey:@"data"];
            FFUser * user = [FFUser userWithDict:dict];
            _country.text = user.noteName ? user.noteName : @"";
            [_switch setOn:user.inbalck ? YES : NO];
            
            NSLog(@"====他人资料页请求成功====");
        }
    }];
    
}



@end
