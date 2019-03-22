//
//  FFChatDetailsVC.m
//  MonetBlockchain
//
//  Created by Rain on 17/12/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFChatDetailsVC.h"

@interface FFChatDetailsVC ()
{
    UIView * _contentView;
    UILabel * _tips;
    UISwitch * _switchBtn;
}

@property(nonatomic,strong) NSString * localID;

@end

@implementation FFChatDetailsVC

-(instancetype)initWithUid:(NSString *)uid
{
    if (self = [super init]) {
        
        self.localID = uid;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestMaskUserState];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Chat details";
}

-(void)buildUI
{
    _contentView = [[UIView alloc] initWithFrame:LC_RECT(0, 84, DDYSCREENW, 55)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    _tips = [[UILabel alloc] initWithFrame:LC_RECT(10, 0, DDYSCREENW - 100, 55)];
    _tips.text = @"The message don't disturb";
    _tips.font = NA_FONT(16);
    [_contentView addSubview:_tips];
    
    _switchBtn = [[UISwitch alloc] initWithFrame:LC_RECT(DDYSCREENW - 65, 25/2, 50, 30)];
    [_switchBtn setOn:NO];
    [_switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [_contentView addSubview:_switchBtn];
    
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
   
    NSInteger status = isButtonOn ? 1 : 0;
    [self requestMaskUser:status];
}

-(void)requestMaskUserState
{
    NSDictionary * params = @{
                              @"masklocalid":self.localID
                              };
    [NANetWorkRequest na_postDataWithService:@"message" action:@"get_mask_user" parameters:params results:^(BOOL status, NSDictionary *result) {
        if (status) {
            
            NSDictionary * data = [result objectForKey:@"data"];
            [_switchBtn setOn:[[data objectForKey:@"status"] boolValue] ? YES : NO];
            
            NSLog(@"屏蔽状态请求成功!");
        }
        else
        {
            [self showErrorText:@"网络异常"];
            NSLog(@"网络异常");
        }
    }];
}

-(void)requestMaskUser:(NSInteger)status
{
    [FFLocalUserInfo LCInstance].isSignUp = YES;
    
    NSDictionary * params = @{@"status":@(status),
                              @"masklocalid":self.localID
                              };
    [NANetWorkRequest na_postDataWithService:@"message" action:@"mask_user" parameters:params results:^(BOOL status, NSDictionary *result) {
        if (status) {
         
//            NSString * status = result[@"params"][@"status"];
//
//            if ([status integerValue] == 1) {
//
//                NSLog(@"===已屏蔽===");
//                [self showSuccessText:@"已屏蔽"];
//            }
//            else
//            {
//                NSLog(@"===屏蔽取消===");
//                [self showSuccessText:@"取消屏蔽"];
//            }
            [self showSuccessText:@"设置成功!"];
        }
        else
        {
            NSLog(@"===网络异常===");
            [self showErrorText:@"网络异常"];
        }
        
    }];
}



@end
