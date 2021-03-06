//
//  FFSendMessageViewController.m
//  MonetBlockchain
//
//  Created by Megan on 2017/9/22.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFSendMessageViewController.h"
#import "FFCreatAccountViewController.h"
#import "FFBindingPhoneVC.h"

@interface FFSendMessageViewController ()<UITextFieldDelegate>
{
    UILabel     * _tipsLabel;
    UILabel     * _codeTips;
    UITextField * _codeLabel;
    UILabel     * _callTips;
    UIButton    * _continueBtn;
}
@end

@implementation FFSendMessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = self.status == 0 ? @"Binding mobile phone" : @"Binding email";
   
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonOnClicked)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self observeNotification:UIKeyboardWillShowNotification];
    [self observeNotification:UIKeyboardWillHideNotification];
    [self observeNotification:UITextFieldTextDidChangeNotification];
}

- (void)buildUI
{
    [self.view addTapTarget:self action:@selector(tapAction)];
    
    _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 80, DDYSCREENW - 56, 45)];
    _tipsLabel.text = @"We have sent you an SMS with a code to the number.";
    _tipsLabel.font = NA_FONT(16);
    _tipsLabel.numberOfLines = 2;
    _tipsLabel.textColor = LC_RGB(111, 111, 111);
    [self.view addSubview:_tipsLabel];

    _codeTips = [[UILabel alloc] initWithFrame:CGRectMake(28, _tipsLabel.viewBottomY + 10, DDYSCREENW - 56, 20)];
    _codeTips.text = @"ENTER THE CODE";
    _codeTips.font = NA_FONT(12);
    [self.view addSubview:_codeTips];
    
    _codeLabel = [[UITextField alloc] initWithFrame:CGRectMake(28, _codeTips.viewBottomY + 10, DDYSCREENW - 56, 48)];
    _codeLabel.font = NA_FONT(32);
    _codeLabel.placeholder = @"code";
    _codeLabel.textColor = LC_RGB(42, 42, 42);
    _codeLabel.delegate = self;
    _codeLabel.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_codeLabel];
 
    _callTips = [[UILabel alloc] initWithFrame:CGRectMake(28, _codeLabel.viewBottomY + 30, DDYSCREENW - 56, 45)];
    _callTips.text = @"Sparks will call you in 1:23.";
    _callTips.font = NA_FONT(16);
    _callTips.numberOfLines = 2;
    _callTips.textColor = LC_RGB(111, 111, 111);
    [self.view addSubview:_callTips];

//    _continueBtn = [[UIButton alloc] initWithFrame:LC_RECT(37.5, _callTips.viewBottomY + 10, DDYSCREENW - 75, 50)];
//    [_continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
//    _continueBtn.titleLabel.font = NA_FONT(18);
//    [_continueBtn setTitleColor:LC_RGB(153, 153, 153) forState:UIControlStateNormal];
//    [_continueBtn setBackgroundColor:LC_RGB(230, 230, 230)];
//    [_continueBtn addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_continueBtn];
//    _continueBtn.layer.cornerRadius = 25;
//    _continueBtn.layer.masksToBounds = YES;
//    [_continueBtn setUserInteractionEnabled:NO];
    
}

-(void)nextButtonOnClicked
{
    if (self.status == 0)
    {
        [self verifyPhoneSMS];
    }
    else
    {
        [self verifyEmail];
    }
}

- (void)continueAction
{
    FFCreatAccountViewController * controller = [[FFCreatAccountViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) handleNotification:(NSNotification *)notification
{
    if ([notification is:UIKeyboardWillShowNotification]) {
        
        [self keyboardWillShow:notification];
        
    }else if ([notification is:UIKeyboardWillHideNotification]){
        
        [self keyboardWillHide:notification];
    }
    else if ([notification is:UITextFieldTextDidChangeNotification]){
        
        [self textFieldChange];
        
    }
    
}


- (void)tapAction
{
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Responding to keyboard events

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldChange
{
    if (_codeLabel.text.length != 0) {
        
//        [_continueBtn setUserInteractionEnabled:YES];
//        [_continueBtn setBackgroundColor:LC_RGB(248, 220, 74)];
//        [_continueBtn setTitleColor:LC_RGB(51, 51, 51) forState:UIControlStateNormal];
    }
    else
    {
//        [_continueBtn setUserInteractionEnabled:NO];
//        [_continueBtn setBackgroundColor:LC_RGB(230, 230, 230)];
//        [_continueBtn setTitleColor:LC_RGB(153, 153, 153) forState:UIControlStateNormal];
        
    }
    
}

#pragma mark -
#pragma mark Responding to keyboard events

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary * userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self moveInputBarWithKeyboardHeight:65 withDuration:animationDuration + 0.5];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [self moveInputBarWithKeyboardHeight:0 withDuration:animationDuration+0.2];
}

- (void) moveInputBarWithKeyboardHeight:(float)height withDuration:(NSTimeInterval)interval
{
    [UIView animateWithDuration:interval animations:^{
        
        //        [_contentScrollView setContentOffset:CGPointMake(0, height)];
    }];
}

- (void)verifyPhoneSMS
{
    [_codeLabel resignFirstResponder];
    
    [FFLocalUserInfo LCInstance].isRSAKey = YES;
    
    NSDictionary * params = @{@"phonenumber":self.phoneStr,
                              @"code":_codeLabel.text
                              };
    
    [NANetWorkRequest na_postDataWithService:@"smsc" action:@"verify" parameters:params results:^(BOOL status, NSDictionary *result) {
        
        if (status) {
            
            [self bingdingMobile];
        }
        else
        {
            if ([result objectForKey:@"errcode"] != 0) {
                
                NSLog(@"==网络异常==");
            };
        }
    }];
}

- (void)bingdingMobile
{
    NSDictionary * params = @{@"phonenumber":self.phoneStr,
                              };
    
    [NANetWorkRequest na_postDataWithService:@"user" action:@"bingd_mobile" parameters:params results:^(BOOL status, NSDictionary *result) {
        
        if (status) {
            
            FFBindingPhoneVC * controller = [[FFBindingPhoneVC alloc] init];
            controller.status = self.status;
            [self.navigationController pushViewController:controller animated:YES];
            
            [FFLocalUserInfo LCInstance].isRSAKey = NO;
            
            NSString * num = [self.phoneStr substringFromIndex:2];
            [FFLocalUserInfo LCInstance].phonenumber = num;
            
            NSLog(@"===手机绑定成功!==");
            [self showSuccessText:@"手机绑定成功!"];
        }
        else
        {
            if ([result objectForKey:@"errcode"] != 0) {
                
                NSLog(@"==网络异常==");
            };
        }
    }];
}

- (void)verifyEmail
{
    [_codeLabel resignFirstResponder];
    
    [FFLocalUserInfo LCInstance].isRSAKey = YES;
    
    NSDictionary * params = @{@"email":self.emailStr,
                              @"code":_codeLabel.text
                              };
    
    [NANetWorkRequest na_postDataWithService:@"mail" action:@"verify" parameters:params results:^(BOOL status, NSDictionary *result) {
        
        if (status) {
            
            [self bingdingEmail];
        
        }
        else
        {
            if ([result objectForKey:@"errcode"] != 0) {
                
                NSLog(@"==网络异常==");
            };
        }
    }];
}

- (void)bingdingEmail
{
    NSDictionary * params = @{@"email":self.emailStr,
                              };
    
    [NANetWorkRequest na_postDataWithService:@"user" action:@"bingd_email" parameters:params results:^(BOOL status, NSDictionary *result) {
        
        if (status) {
            
            FFBindingPhoneVC * controller = [[FFBindingPhoneVC alloc] init];
            controller.status = self.status;
            [self.navigationController pushViewController:controller animated:YES];
            
            [FFLocalUserInfo LCInstance].isRSAKey = NO;
            [FFLocalUserInfo LCInstance].emailnumber = self.emailStr;
            
            NSLog(@"===邮箱绑定成功!==");
            [self showSuccessText:@"邮箱绑定成功!"];
        }
        else
        {
            if ([result objectForKey:@"errcode"] != 0) {
                
                NSLog(@"==网络异常==");
            };
        }
    }];
}


@end
