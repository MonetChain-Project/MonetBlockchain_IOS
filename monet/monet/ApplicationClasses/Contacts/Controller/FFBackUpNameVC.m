//
//  FFBackUpNameVC.m
//  MonetBlockchain
//
//  Created by Megan on 2017/12/15.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFBackUpNameVC.h"

@interface FFBackUpNameVC ()<UITextFieldDelegate>
{
    UITextField * _noteTF;
    UIView      * _line;
    NSInteger     _status;
}
@property(nonatomic,strong)FFUser * user;

@end

@implementation FFBackUpNameVC

-(instancetype)initWithUser:(FFUser *)user
{
    if (self = [super init]) {
        
        self.user = user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"  style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    [self observeNotification:UIKeyboardWillShowNotification];
    [self observeNotification:UIKeyboardWillHideNotification];
    [self observeNotification:UITextFieldTextDidChangeNotification];
}

-(void)buildUI
{
    [self.view addTapTarget:self action:@selector(tapAction)];
    
    _status = 0;
    
    _noteTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 64 + 20, DDYSCREENW - 30, 20)];
    _noteTF.font = NA_FONT(15);
    _noteTF.placeholder = @"Set the note";
    _noteTF.textColor = LC_RGB(51, 51, 51);
    _noteTF.delegate = self;
    _noteTF.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_noteTF];
    
    _line = [[UIView alloc] initWithFrame:LC_RECT(15, _noteTF.viewBottomY + 10, DDYSCREENW - 30, 1)];
    _line.backgroundColor = LC_RGB(220, 220, 220);
    [self.view addSubview:_line];
    
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

- (void)saveAction
{
    if(_status != 0)
    {
        [self loadNickData];
    }
    else
    {
        [self showHudWithText:@"不能为空!"];
        return;
    }
}

#pragma mark -
#pragma mark Responding to keyboard events

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldChange
{
    if (_noteTF.text.length != 0)
    {
        _status = 1;
    }
    else
    {
        _status = 0;
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

- (void)loadNickData
{
    NSDictionary * params = @{@"note":_noteTF.text,
                              @"localid":self.user.localid
                              };
    [NANetWorkRequest na_postDataWithService:@"friend" action:@"edit_note" parameters:params results:^(BOOL status, NSDictionary *result) {
        
        if (status)
        {

            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self showSuccessText:@"修改成功!"];
                [self postNotification:@"backUpNameNotification" withObject:_noteTF.text];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            NSLog(@"===网络异常==");
        }
    }];
    
}


@end
